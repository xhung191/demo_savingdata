import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// File này được sinh ra bởi: dart run build_runner build --delete-conflicting-outputs
part 'database.g.dart';

// ---------- Kiểu dữ liệu đặc biệt ----------
enum BookmarkCategory { food, travel, study, other }

// List<String> <-> chuỗi JSON lưu trong 1 cột text
class StringListConverter extends TypeConverter<List<String>, String> {
  const StringListConverter();
  @override
  List<String> fromSql(String fromDb) =>
      (jsonDecode(fromDb) as List).cast<String>();
  @override
  String toSql(List<String> value) => jsonEncode(value);
}

// ---------- Bảng ----------
// Bookmark do người dùng tự nhập, có NHIỀU KIỂU dữ liệu khác nhau
class DbBookmark extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)(); // String
  TextColumn get note => text().nullable()(); // String dài
  IntColumn get rating => integer().nullable()(); // int
  RealColumn get price => real().nullable()(); // double
  BoolColumn get isFavorite =>
      boolean().withDefault(const Constant(false))(); // bool
  DateTimeColumn get savedDate => dateTime().nullable()(); // DateTime (người dùng chọn)
  DateTimeColumn get createdAt =>
      dateTime().withDefault(currentDateAndTime)(); // DateTime (tự điền)
  IntColumn get category => intEnum<BookmarkCategory>().nullable()(); // enum
  TextColumn get tags =>
      text().map(const StringListConverter()).nullable()(); // List<String>
  TextColumn get imagePath => text().nullable()(); // ảnh: chỉ lưu ĐƯỜNG DẪN

  // Ràng buộc: không cho 2 bookmark trùng tiêu đề
  @override
  List<Set<Column>> get uniqueKeys => [
        {title}
      ];
}

class DbIngredient extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get amount => real().withDefault(const Constant(1))();
}

// ---------- Database + DAO ----------
@DriftDatabase(
  tables: [DbBookmark, DbIngredient],
  daos: [BookmarkDao, IngredientDao],
)
class RecipeDatabase extends _$RecipeDatabase {
  RecipeDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 3) {
            await m.createTable(dbBookmark);
            // dọn các bảng của phiên bản demo cũ
            await customStatement('DROP TABLE IF EXISTS db_recipe');
            await customStatement('DROP TABLE IF EXISTS db_profile');
          }
        },
      );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationSupportDirectory(); // không bị OneDrive đồng bộ
    final file = File(p.join(dir.path, 'recipes.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}

@DriftAccessor(tables: [DbBookmark])
class BookmarkDao extends DatabaseAccessor<RecipeDatabase>
    with _$BookmarkDaoMixin {
  BookmarkDao(RecipeDatabase db) : super(db);

  Stream<List<DbBookmarkData>> watchAll() => (select(dbBookmark)
        ..orderBy([
          (t) => OrderingTerm.desc(t.createdAt),
          (t) => OrderingTerm.desc(t.id),
        ]))
      .watch();

  /// Thêm bookmark trong 1 transaction: kiểm tra trùng + ghi liền nhau.
  /// Trả về true nếu vừa lưu mới, false nếu bookmark ĐÃ được lưu từ trước.
  Future<bool> addBookmark(DbBookmarkCompanion entry, String title) =>
      transaction(() async {
        final dup = await (select(dbBookmark)
              ..where((t) => t.title.lower().equals(title.toLowerCase())))
            .get();
        if (dup.isNotEmpty) return false;
        await into(dbBookmark).insert(entry);
        return true;
      });

  Future<int> setFavorite(int id, bool value) =>
      (update(dbBookmark)..where((t) => t.id.equals(id)))
          .write(DbBookmarkCompanion(isFavorite: Value(value)));

  // Nhớ WHERE, nếu không sẽ xóa sạch bảng!
  Future<int> deleteBookmark(int id) =>
      (delete(dbBookmark)..where((t) => t.id.equals(id))).go();
}

@DriftAccessor(tables: [DbIngredient])
class IngredientDao extends DatabaseAccessor<RecipeDatabase>
    with _$IngredientDaoMixin {
  IngredientDao(RecipeDatabase db) : super(db);

  Stream<List<DbIngredientData>> watchAllIngredients() =>
      select(dbIngredient).watch();

  Future<int> insertIngredient(String name, double amount) => into(dbIngredient)
      .insert(DbIngredientCompanion.insert(name: name, amount: Value(amount)));

  Future<int> deleteIngredient(int id) =>
      (delete(dbIngredient)..where((t) => t.id.equals(id))).go();
}