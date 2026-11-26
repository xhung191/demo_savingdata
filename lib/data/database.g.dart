// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DbBookmarkTable extends DbBookmark
    with TableInfo<$DbBookmarkTable, DbBookmarkData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbBookmarkTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
      'rating', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _savedDateMeta =
      const VerificationMeta('savedDate');
  @override
  late final GeneratedColumn<DateTime> savedDate = GeneratedColumn<DateTime>(
      'saved_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  late final GeneratedColumnWithTypeConverter<BookmarkCategory?, int> category =
      GeneratedColumn<int>('category', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<BookmarkCategory?>(
              $DbBookmarkTable.$convertercategoryn);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>?, String> tags =
      GeneratedColumn<String>('tags', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<List<String>?>($DbBookmarkTable.$convertertagsn);
  static const VerificationMeta _imagePathMeta =
      const VerificationMeta('imagePath');
  @override
  late final GeneratedColumn<String> imagePath = GeneratedColumn<String>(
      'image_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        note,
        rating,
        price,
        isFavorite,
        savedDate,
        createdAt,
        category,
        tags,
        imagePath
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_bookmark';
  @override
  VerificationContext validateIntegrity(Insertable<DbBookmarkData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    if (data.containsKey('saved_date')) {
      context.handle(_savedDateMeta,
          savedDate.isAcceptableOrUnknown(data['saved_date']!, _savedDateMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('image_path')) {
      context.handle(_imagePathMeta,
          imagePath.isAcceptableOrUnknown(data['image_path']!, _imagePathMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {title},
      ];
  @override
  DbBookmarkData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbBookmarkData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}rating']),
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price']),
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
      savedDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}saved_date']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      category: $DbBookmarkTable.$convertercategoryn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category'])),
      tags: $DbBookmarkTable.$convertertagsn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags'])),
      imagePath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_path']),
    );
  }

  @override
  $DbBookmarkTable createAlias(String alias) {
    return $DbBookmarkTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<BookmarkCategory, int, int> $convertercategory =
      const EnumIndexConverter<BookmarkCategory>(BookmarkCategory.values);
  static JsonTypeConverter2<BookmarkCategory?, int?, int?> $convertercategoryn =
      JsonTypeConverter2.asNullable($convertercategory);
  static TypeConverter<List<String>, String> $convertertags =
      const StringListConverter();
  static TypeConverter<List<String>?, String?> $convertertagsn =
      NullAwareTypeConverter.wrap($convertertags);
}

class DbBookmarkData extends DataClass implements Insertable<DbBookmarkData> {
  final int id;
  final String title;
  final String? note;
  final int? rating;
  final double? price;
  final bool isFavorite;
  final DateTime? savedDate;
  final DateTime createdAt;
  final BookmarkCategory? category;
  final List<String>? tags;
  final String? imagePath;
  const DbBookmarkData(
      {required this.id,
      required this.title,
      this.note,
      this.rating,
      this.price,
      required this.isFavorite,
      this.savedDate,
      required this.createdAt,
      this.category,
      this.tags,
      this.imagePath});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<int>(rating);
    }
    if (!nullToAbsent || price != null) {
      map['price'] = Variable<double>(price);
    }
    map['is_favorite'] = Variable<bool>(isFavorite);
    if (!nullToAbsent || savedDate != null) {
      map['saved_date'] = Variable<DateTime>(savedDate);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || category != null) {
      map['category'] =
          Variable<int>($DbBookmarkTable.$convertercategoryn.toSql(category));
    }
    if (!nullToAbsent || tags != null) {
      map['tags'] =
          Variable<String>($DbBookmarkTable.$convertertagsn.toSql(tags));
    }
    if (!nullToAbsent || imagePath != null) {
      map['image_path'] = Variable<String>(imagePath);
    }
    return map;
  }

  DbBookmarkCompanion toCompanion(bool nullToAbsent) {
    return DbBookmarkCompanion(
      id: Value(id),
      title: Value(title),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      price:
          price == null && nullToAbsent ? const Value.absent() : Value(price),
      isFavorite: Value(isFavorite),
      savedDate: savedDate == null && nullToAbsent
          ? const Value.absent()
          : Value(savedDate),
      createdAt: Value(createdAt),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      imagePath: imagePath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagePath),
    );
  }

  factory DbBookmarkData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbBookmarkData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      note: serializer.fromJson<String?>(json['note']),
      rating: serializer.fromJson<int?>(json['rating']),
      price: serializer.fromJson<double?>(json['price']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
      savedDate: serializer.fromJson<DateTime?>(json['savedDate']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      category: $DbBookmarkTable.$convertercategoryn
          .fromJson(serializer.fromJson<int?>(json['category'])),
      tags: serializer.fromJson<List<String>?>(json['tags']),
      imagePath: serializer.fromJson<String?>(json['imagePath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'note': serializer.toJson<String?>(note),
      'rating': serializer.toJson<int?>(rating),
      'price': serializer.toJson<double?>(price),
      'isFavorite': serializer.toJson<bool>(isFavorite),
      'savedDate': serializer.toJson<DateTime?>(savedDate),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'category': serializer
          .toJson<int?>($DbBookmarkTable.$convertercategoryn.toJson(category)),
      'tags': serializer.toJson<List<String>?>(tags),
      'imagePath': serializer.toJson<String?>(imagePath),
    };
  }

  DbBookmarkData copyWith(
          {int? id,
          String? title,
          Value<String?> note = const Value.absent(),
          Value<int?> rating = const Value.absent(),
          Value<double?> price = const Value.absent(),
          bool? isFavorite,
          Value<DateTime?> savedDate = const Value.absent(),
          DateTime? createdAt,
          Value<BookmarkCategory?> category = const Value.absent(),
          Value<List<String>?> tags = const Value.absent(),
          Value<String?> imagePath = const Value.absent()}) =>
      DbBookmarkData(
        id: id ?? this.id,
        title: title ?? this.title,
        note: note.present ? note.value : this.note,
        rating: rating.present ? rating.value : this.rating,
        price: price.present ? price.value : this.price,
        isFavorite: isFavorite ?? this.isFavorite,
        savedDate: savedDate.present ? savedDate.value : this.savedDate,
        createdAt: createdAt ?? this.createdAt,
        category: category.present ? category.value : this.category,
        tags: tags.present ? tags.value : this.tags,
        imagePath: imagePath.present ? imagePath.value : this.imagePath,
      );
  DbBookmarkData copyWithCompanion(DbBookmarkCompanion data) {
    return DbBookmarkData(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      note: data.note.present ? data.note.value : this.note,
      rating: data.rating.present ? data.rating.value : this.rating,
      price: data.price.present ? data.price.value : this.price,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
      savedDate: data.savedDate.present ? data.savedDate.value : this.savedDate,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      category: data.category.present ? data.category.value : this.category,
      tags: data.tags.present ? data.tags.value : this.tags,
      imagePath: data.imagePath.present ? data.imagePath.value : this.imagePath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbBookmarkData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('note: $note, ')
          ..write('rating: $rating, ')
          ..write('price: $price, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('savedDate: $savedDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('category: $category, ')
          ..write('tags: $tags, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, note, rating, price, isFavorite,
      savedDate, createdAt, category, tags, imagePath);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbBookmarkData &&
          other.id == this.id &&
          other.title == this.title &&
          other.note == this.note &&
          other.rating == this.rating &&
          other.price == this.price &&
          other.isFavorite == this.isFavorite &&
          other.savedDate == this.savedDate &&
          other.createdAt == this.createdAt &&
          other.category == this.category &&
          other.tags == this.tags &&
          other.imagePath == this.imagePath);
}

class DbBookmarkCompanion extends UpdateCompanion<DbBookmarkData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String?> note;
  final Value<int?> rating;
  final Value<double?> price;
  final Value<bool> isFavorite;
  final Value<DateTime?> savedDate;
  final Value<DateTime> createdAt;
  final Value<BookmarkCategory?> category;
  final Value<List<String>?> tags;
  final Value<String?> imagePath;
  const DbBookmarkCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.note = const Value.absent(),
    this.rating = const Value.absent(),
    this.price = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.savedDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.category = const Value.absent(),
    this.tags = const Value.absent(),
    this.imagePath = const Value.absent(),
  });
  DbBookmarkCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    this.note = const Value.absent(),
    this.rating = const Value.absent(),
    this.price = const Value.absent(),
    this.isFavorite = const Value.absent(),
    this.savedDate = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.category = const Value.absent(),
    this.tags = const Value.absent(),
    this.imagePath = const Value.absent(),
  }) : title = Value(title);
  static Insertable<DbBookmarkData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? note,
    Expression<int>? rating,
    Expression<double>? price,
    Expression<bool>? isFavorite,
    Expression<DateTime>? savedDate,
    Expression<DateTime>? createdAt,
    Expression<int>? category,
    Expression<String>? tags,
    Expression<String>? imagePath,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (note != null) 'note': note,
      if (rating != null) 'rating': rating,
      if (price != null) 'price': price,
      if (isFavorite != null) 'is_favorite': isFavorite,
      if (savedDate != null) 'saved_date': savedDate,
      if (createdAt != null) 'created_at': createdAt,
      if (category != null) 'category': category,
      if (tags != null) 'tags': tags,
      if (imagePath != null) 'image_path': imagePath,
    });
  }

  DbBookmarkCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String?>? note,
      Value<int?>? rating,
      Value<double?>? price,
      Value<bool>? isFavorite,
      Value<DateTime?>? savedDate,
      Value<DateTime>? createdAt,
      Value<BookmarkCategory?>? category,
      Value<List<String>?>? tags,
      Value<String?>? imagePath}) {
    return DbBookmarkCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      note: note ?? this.note,
      rating: rating ?? this.rating,
      price: price ?? this.price,
      isFavorite: isFavorite ?? this.isFavorite,
      savedDate: savedDate ?? this.savedDate,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      imagePath: imagePath ?? this.imagePath,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    if (savedDate.present) {
      map['saved_date'] = Variable<DateTime>(savedDate.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (category.present) {
      map['category'] = Variable<int>(
          $DbBookmarkTable.$convertercategoryn.toSql(category.value));
    }
    if (tags.present) {
      map['tags'] =
          Variable<String>($DbBookmarkTable.$convertertagsn.toSql(tags.value));
    }
    if (imagePath.present) {
      map['image_path'] = Variable<String>(imagePath.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbBookmarkCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('note: $note, ')
          ..write('rating: $rating, ')
          ..write('price: $price, ')
          ..write('isFavorite: $isFavorite, ')
          ..write('savedDate: $savedDate, ')
          ..write('createdAt: $createdAt, ')
          ..write('category: $category, ')
          ..write('tags: $tags, ')
          ..write('imagePath: $imagePath')
          ..write(')'))
        .toString();
  }
}

class $DbIngredientTable extends DbIngredient
    with TableInfo<$DbIngredientTable, DbIngredientData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DbIngredientTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  @override
  List<GeneratedColumn> get $columns => [id, name, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'db_ingredient';
  @override
  VerificationContext validateIntegrity(Insertable<DbIngredientData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbIngredientData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DbIngredientData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
    );
  }

  @override
  $DbIngredientTable createAlias(String alias) {
    return $DbIngredientTable(attachedDatabase, alias);
  }
}

class DbIngredientData extends DataClass
    implements Insertable<DbIngredientData> {
  final int id;
  final String name;
  final double amount;
  const DbIngredientData(
      {required this.id, required this.name, required this.amount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<double>(amount);
    return map;
  }

  DbIngredientCompanion toCompanion(bool nullToAbsent) {
    return DbIngredientCompanion(
      id: Value(id),
      name: Value(name),
      amount: Value(amount),
    );
  }

  factory DbIngredientData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbIngredientData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<double>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<double>(amount),
    };
  }

  DbIngredientData copyWith({int? id, String? name, double? amount}) =>
      DbIngredientData(
        id: id ?? this.id,
        name: name ?? this.name,
        amount: amount ?? this.amount,
      );
  DbIngredientData copyWithCompanion(DbIngredientCompanion data) {
    return DbIngredientData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DbIngredientData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbIngredientData &&
          other.id == this.id &&
          other.name == this.name &&
          other.amount == this.amount);
}

class DbIngredientCompanion extends UpdateCompanion<DbIngredientData> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> amount;
  const DbIngredientCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
  });
  DbIngredientCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.amount = const Value.absent(),
  }) : name = Value(name);
  static Insertable<DbIngredientData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
    });
  }

  DbIngredientCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<double>? amount}) {
    return DbIngredientCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DbIngredientCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

abstract class _$RecipeDatabase extends GeneratedDatabase {
  _$RecipeDatabase(QueryExecutor e) : super(e);
  $RecipeDatabaseManager get managers => $RecipeDatabaseManager(this);
  late final $DbBookmarkTable dbBookmark = $DbBookmarkTable(this);
  late final $DbIngredientTable dbIngredient = $DbIngredientTable(this);
  late final BookmarkDao bookmarkDao = BookmarkDao(this as RecipeDatabase);
  late final IngredientDao ingredientDao =
      IngredientDao(this as RecipeDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [dbBookmark, dbIngredient];
}

typedef $$DbBookmarkTableCreateCompanionBuilder = DbBookmarkCompanion Function({
  Value<int> id,
  required String title,
  Value<String?> note,
  Value<int?> rating,
  Value<double?> price,
  Value<bool> isFavorite,
  Value<DateTime?> savedDate,
  Value<DateTime> createdAt,
  Value<BookmarkCategory?> category,
  Value<List<String>?> tags,
  Value<String?> imagePath,
});
typedef $$DbBookmarkTableUpdateCompanionBuilder = DbBookmarkCompanion Function({
  Value<int> id,
  Value<String> title,
  Value<String?> note,
  Value<int?> rating,
  Value<double?> price,
  Value<bool> isFavorite,
  Value<DateTime?> savedDate,
  Value<DateTime> createdAt,
  Value<BookmarkCategory?> category,
  Value<List<String>?> tags,
  Value<String?> imagePath,
});

class $$DbBookmarkTableFilterComposer
    extends Composer<_$RecipeDatabase, $DbBookmarkTable> {
  $$DbBookmarkTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get savedDate => $composableBuilder(
      column: $table.savedDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<BookmarkCategory?, BookmarkCategory, int>
      get category => $composableBuilder(
          column: $table.category,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<String>?, List<String>, String>
      get tags => $composableBuilder(
          column: $table.tags,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnFilters(column));
}

class $$DbBookmarkTableOrderingComposer
    extends Composer<_$RecipeDatabase, $DbBookmarkTable> {
  $$DbBookmarkTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get rating => $composableBuilder(
      column: $table.rating, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get savedDate => $composableBuilder(
      column: $table.savedDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imagePath => $composableBuilder(
      column: $table.imagePath, builder: (column) => ColumnOrderings(column));
}

class $$DbBookmarkTableAnnotationComposer
    extends Composer<_$RecipeDatabase, $DbBookmarkTable> {
  $$DbBookmarkTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

  GeneratedColumn<DateTime> get savedDate =>
      $composableBuilder(column: $table.savedDate, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<BookmarkCategory?, int> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>?, String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<String> get imagePath =>
      $composableBuilder(column: $table.imagePath, builder: (column) => column);
}

class $$DbBookmarkTableTableManager extends RootTableManager<
    _$RecipeDatabase,
    $DbBookmarkTable,
    DbBookmarkData,
    $$DbBookmarkTableFilterComposer,
    $$DbBookmarkTableOrderingComposer,
    $$DbBookmarkTableAnnotationComposer,
    $$DbBookmarkTableCreateCompanionBuilder,
    $$DbBookmarkTableUpdateCompanionBuilder,
    (
      DbBookmarkData,
      BaseReferences<_$RecipeDatabase, $DbBookmarkTable, DbBookmarkData>
    ),
    DbBookmarkData,
    PrefetchHooks Function()> {
  $$DbBookmarkTableTableManager(_$RecipeDatabase db, $DbBookmarkTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbBookmarkTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbBookmarkTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbBookmarkTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<int?> rating = const Value.absent(),
            Value<double?> price = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<DateTime?> savedDate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<BookmarkCategory?> category = const Value.absent(),
            Value<List<String>?> tags = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
          }) =>
              DbBookmarkCompanion(
            id: id,
            title: title,
            note: note,
            rating: rating,
            price: price,
            isFavorite: isFavorite,
            savedDate: savedDate,
            createdAt: createdAt,
            category: category,
            tags: tags,
            imagePath: imagePath,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            Value<String?> note = const Value.absent(),
            Value<int?> rating = const Value.absent(),
            Value<double?> price = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
            Value<DateTime?> savedDate = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<BookmarkCategory?> category = const Value.absent(),
            Value<List<String>?> tags = const Value.absent(),
            Value<String?> imagePath = const Value.absent(),
          }) =>
              DbBookmarkCompanion.insert(
            id: id,
            title: title,
            note: note,
            rating: rating,
            price: price,
            isFavorite: isFavorite,
            savedDate: savedDate,
            createdAt: createdAt,
            category: category,
            tags: tags,
            imagePath: imagePath,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DbBookmarkTableProcessedTableManager = ProcessedTableManager<
    _$RecipeDatabase,
    $DbBookmarkTable,
    DbBookmarkData,
    $$DbBookmarkTableFilterComposer,
    $$DbBookmarkTableOrderingComposer,
    $$DbBookmarkTableAnnotationComposer,
    $$DbBookmarkTableCreateCompanionBuilder,
    $$DbBookmarkTableUpdateCompanionBuilder,
    (
      DbBookmarkData,
      BaseReferences<_$RecipeDatabase, $DbBookmarkTable, DbBookmarkData>
    ),
    DbBookmarkData,
    PrefetchHooks Function()>;
typedef $$DbIngredientTableCreateCompanionBuilder = DbIngredientCompanion
    Function({
  Value<int> id,
  required String name,
  Value<double> amount,
});
typedef $$DbIngredientTableUpdateCompanionBuilder = DbIngredientCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<double> amount,
});

class $$DbIngredientTableFilterComposer
    extends Composer<_$RecipeDatabase, $DbIngredientTable> {
  $$DbIngredientTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));
}

class $$DbIngredientTableOrderingComposer
    extends Composer<_$RecipeDatabase, $DbIngredientTable> {
  $$DbIngredientTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));
}

class $$DbIngredientTableAnnotationComposer
    extends Composer<_$RecipeDatabase, $DbIngredientTable> {
  $$DbIngredientTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);
}

class $$DbIngredientTableTableManager extends RootTableManager<
    _$RecipeDatabase,
    $DbIngredientTable,
    DbIngredientData,
    $$DbIngredientTableFilterComposer,
    $$DbIngredientTableOrderingComposer,
    $$DbIngredientTableAnnotationComposer,
    $$DbIngredientTableCreateCompanionBuilder,
    $$DbIngredientTableUpdateCompanionBuilder,
    (
      DbIngredientData,
      BaseReferences<_$RecipeDatabase, $DbIngredientTable, DbIngredientData>
    ),
    DbIngredientData,
    PrefetchHooks Function()> {
  $$DbIngredientTableTableManager(_$RecipeDatabase db, $DbIngredientTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DbIngredientTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DbIngredientTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DbIngredientTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double> amount = const Value.absent(),
          }) =>
              DbIngredientCompanion(
            id: id,
            name: name,
            amount: amount,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            Value<double> amount = const Value.absent(),
          }) =>
              DbIngredientCompanion.insert(
            id: id,
            name: name,
            amount: amount,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DbIngredientTableProcessedTableManager = ProcessedTableManager<
    _$RecipeDatabase,
    $DbIngredientTable,
    DbIngredientData,
    $$DbIngredientTableFilterComposer,
    $$DbIngredientTableOrderingComposer,
    $$DbIngredientTableAnnotationComposer,
    $$DbIngredientTableCreateCompanionBuilder,
    $$DbIngredientTableUpdateCompanionBuilder,
    (
      DbIngredientData,
      BaseReferences<_$RecipeDatabase, $DbIngredientTable, DbIngredientData>
    ),
    DbIngredientData,
    PrefetchHooks Function()>;

class $RecipeDatabaseManager {
  final _$RecipeDatabase _db;
  $RecipeDatabaseManager(this._db);
  $$DbBookmarkTableTableManager get dbBookmark =>
      $$DbBookmarkTableTableManager(_db, _db.dbBookmark);
  $$DbIngredientTableTableManager get dbIngredient =>
      $$DbIngredientTableTableManager(_db, _db.dbIngredient);
}

mixin _$BookmarkDaoMixin on DatabaseAccessor<RecipeDatabase> {
  $DbBookmarkTable get dbBookmark => attachedDatabase.dbBookmark;
  BookmarkDaoManager get managers => BookmarkDaoManager(this);
}

class BookmarkDaoManager {
  final _$BookmarkDaoMixin _db;
  BookmarkDaoManager(this._db);
  $$DbBookmarkTableTableManager get dbBookmark =>
      $$DbBookmarkTableTableManager(_db.attachedDatabase, _db.dbBookmark);
}

mixin _$IngredientDaoMixin on DatabaseAccessor<RecipeDatabase> {
  $DbIngredientTable get dbIngredient => attachedDatabase.dbIngredient;
  IngredientDaoManager get managers => IngredientDaoManager(this);
}

class IngredientDaoManager {
  final _$IngredientDaoMixin _db;
  IngredientDaoManager(this._db);
  $$DbIngredientTableTableManager get dbIngredient =>
      $$DbIngredientTableTableManager(_db.attachedDatabase, _db.dbIngredient);
}
