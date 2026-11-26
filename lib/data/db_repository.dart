import 'dart:io';

import 'package:drift/drift.dart' show Value;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'database.dart';

export 'database.dart' show BookmarkCategory;

// ---------- Model của lớp UI (tách biệt với class của Database) ----------
class Bookmark {
  final int? id;
  final String title;
  final String? note;
  final int? rating;
  final double? price;
  final bool isFavorite;
  final DateTime? savedDate;
  final BookmarkCategory? category;
  final List<String> tags;
  final String? imagePath;
  final DateTime? createdAt;
  const Bookmark({
    this.id,
    required this.title,
    this.note,
    this.rating,
    this.price,
    this.isFavorite = false,
    this.savedDate,
    this.category,
    this.tags = const [],
    this.imagePath,
    this.createdAt,
  });
}

class Ingredient {
  final int id;
  final String name;
  final double amount;
  const Ingredient({required this.id, required this.name, required this.amount});
}

// ---------- Repository ----------
class DBRepository {
  late final RecipeDatabase _db;

  Future<void> init() async {
    _db = RecipeDatabase();
  }

  // ----- chuyển đổi DB class -> Model -----
  Bookmark _bookmarkToModel(DbBookmarkData d) => Bookmark(
        id: d.id,
        title: d.title,
        note: d.note,
        rating: d.rating,
        price: d.price,
        isFavorite: d.isFavorite,
        savedDate: d.savedDate,
        category: d.category,
        tags: d.tags ?? const [],
        imagePath: d.imagePath,
        createdAt: d.createdAt,
      );

  Ingredient _ingredientToModel(DbIngredientData i) =>
      Ingredient(id: i.id, name: i.name, amount: i.amount);

  // ----- Bookmark -----
  Stream<List<Bookmark>> watchBookmarks() => _db.bookmarkDao
      .watchAll()
      .map((rows) => rows.map(_bookmarkToModel).toList());

  /// true = vừa lưu mới, false = bookmark này đã được lưu từ trước
  Future<bool> addBookmark(Bookmark b) async {
    // Ảnh KHÔNG lưu vào DB: copy vào thư mục app, DB chỉ giữ đường dẫn.
    String? savedImage;
    if (b.imagePath != null) savedImage = await _copyImageToAppDir(b.imagePath!);

    final isNew = await _db.bookmarkDao.addBookmark(
      DbBookmarkCompanion.insert(
        title: b.title,
        note: Value(b.note),
        rating: Value(b.rating),
        price: Value(b.price),
        isFavorite: Value(b.isFavorite),
        savedDate: Value(b.savedDate),
        category: Value(b.category),
        tags: Value(b.tags),
        imagePath: Value(savedImage),
      ),
      b.title,
    );

    // Trùng thì bỏ ảnh vừa copy cho đỡ rác
    if (!isNew && savedImage != null) await _deleteFile(savedImage);
    return isNew;
  }

  Future<void> setFavorite(Bookmark b, bool value) =>
      _db.bookmarkDao.setFavorite(b.id!, value);

  Future<void> removeBookmark(Bookmark b) async {
    await _db.bookmarkDao.deleteBookmark(b.id!);
    if (b.imagePath != null) await _deleteFile(b.imagePath!);
  }

  // ----- Ingredient -----
  Stream<List<Ingredient>> watchIngredients() => _db.ingredientDao
      .watchAllIngredients()
      .map((rows) => rows.map(_ingredientToModel).toList());

  Future<void> addIngredient(String name, double amount) =>
      _db.ingredientDao.insertIngredient(name, amount);

  Future<void> removeIngredient(int id) =>
      _db.ingredientDao.deleteIngredient(id);

  // ----- File ảnh -----
  Future<String> _copyImageToAppDir(String pickedPath) async {
    final dir = await getApplicationSupportDirectory();
    final ext = p.extension(pickedPath);
    final name = 'bm_${DateTime.now().microsecondsSinceEpoch}$ext';
    final saved = await File(pickedPath).copy(p.join(dir.path, name));
    return saved.path;
  }

  Future<void> _deleteFile(String path) async {
    try {
      final f = File(path);
      if (await f.exists()) await f.delete();
    } catch (_) {}
  }
}