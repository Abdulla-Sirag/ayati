// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_section_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorMySectionDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MySectionDatabaseBuilder databaseBuilder(String name) =>
      _$MySectionDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$MySectionDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$MySectionDatabaseBuilder(null);
}

class _$MySectionDatabaseBuilder {
  _$MySectionDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$MySectionDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$MySectionDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<MySectionDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$MySectionDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$MySectionDatabase extends MySectionDatabase {
  _$MySectionDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  MySectionDao? _mySectionDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `MySection` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `sectionFirstVerse` TEXT, `sectionChapter` TEXT, `sectionChapterNo` INTEGER, `sectionStart` INTEGER, `sectionEnd` INTEGER, `sectionPageNo` INTEGER, `isLong` INTEGER, `isRecited` INTEGER, `filterOption` INTEGER)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  MySectionDao get mySectionDao {
    return _mySectionDaoInstance ??= _$MySectionDao(database, changeListener);
  }
}

class _$MySectionDao extends MySectionDao {
  _$MySectionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _mySectionInsertionAdapter = InsertionAdapter(
            database,
            'MySection',
            (MySection item) => <String, Object?>{
                  'id': item.id,
                  'sectionFirstVerse': item.sectionFirstVerse,
                  'sectionChapter': item.sectionChapter,
                  'sectionChapterNo': item.sectionChapterNo,
                  'sectionStart': item.sectionStart,
                  'sectionEnd': item.sectionEnd,
                  'sectionPageNo': item.sectionPageNo,
                  'isLong': item.isLong == null ? null : (item.isLong! ? 1 : 0),
                  'isRecited':
                      item.isRecited == null ? null : (item.isRecited! ? 1 : 0),
                  'filterOption': item.filterOption?.index
                }),
        _mySectionUpdateAdapter = UpdateAdapter(
            database,
            'MySection',
            ['id'],
            (MySection item) => <String, Object?>{
                  'id': item.id,
                  'sectionFirstVerse': item.sectionFirstVerse,
                  'sectionChapter': item.sectionChapter,
                  'sectionChapterNo': item.sectionChapterNo,
                  'sectionStart': item.sectionStart,
                  'sectionEnd': item.sectionEnd,
                  'sectionPageNo': item.sectionPageNo,
                  'isLong': item.isLong == null ? null : (item.isLong! ? 1 : 0),
                  'isRecited':
                      item.isRecited == null ? null : (item.isRecited! ? 1 : 0),
                  'filterOption': item.filterOption?.index
                }),
        _mySectionDeletionAdapter = DeletionAdapter(
            database,
            'MySection',
            ['id'],
            (MySection item) => <String, Object?>{
                  'id': item.id,
                  'sectionFirstVerse': item.sectionFirstVerse,
                  'sectionChapter': item.sectionChapter,
                  'sectionChapterNo': item.sectionChapterNo,
                  'sectionStart': item.sectionStart,
                  'sectionEnd': item.sectionEnd,
                  'sectionPageNo': item.sectionPageNo,
                  'isLong': item.isLong == null ? null : (item.isLong! ? 1 : 0),
                  'isRecited':
                      item.isRecited == null ? null : (item.isRecited! ? 1 : 0),
                  'filterOption': item.filterOption?.index
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<MySection> _mySectionInsertionAdapter;

  final UpdateAdapter<MySection> _mySectionUpdateAdapter;

  final DeletionAdapter<MySection> _mySectionDeletionAdapter;

  @override
  Future<List<MySection>> findPrayerSections(int index) async {
    return _queryAdapter.queryList(
        'SELECT * FROM MySection WHERE filterOption = ?1 ORDER BY sectionPageNo AND sectionChapterNo ASC',
        mapper: (Map<String, Object?> row) => MySection(id: row['id'] as int?, sectionFirstVerse: row['sectionFirstVerse'] as String?, sectionChapter: row['sectionChapter'] as String?, sectionChapterNo: row['sectionChapterNo'] as int?, sectionStart: row['sectionStart'] as int?, sectionEnd: row['sectionEnd'] as int?, sectionPageNo: row['sectionPageNo'] as int?, isLong: row['isLong'] == null ? null : (row['isLong'] as int) != 0, filterOption: row['filterOption'] == null ? null : FilterOption.values[row['filterOption'] as int]),
        arguments: [index]);
  }

  @override
  Future<List<MySection>> findMemorizationSections(int index) async {
    return _queryAdapter.queryList(
        'SELECT * FROM MySection WHERE filterOption = ?1 ORDER BY sectionPageNo AND sectionChapterNo ASC',
        mapper: (Map<String, Object?> row) => MySection(id: row['id'] as int?, sectionFirstVerse: row['sectionFirstVerse'] as String?, sectionChapter: row['sectionChapter'] as String?, sectionChapterNo: row['sectionChapterNo'] as int?, sectionStart: row['sectionStart'] as int?, sectionEnd: row['sectionEnd'] as int?, sectionPageNo: row['sectionPageNo'] as int?, isLong: row['isLong'] == null ? null : (row['isLong'] as int) != 0, filterOption: row['filterOption'] == null ? null : FilterOption.values[row['filterOption'] as int]),
        arguments: [index]);
  }

  @override
  Future<List<MySection>> findSuggestedSections(int index) async {
    return _queryAdapter.queryList(
        'SELECT * FROM MySection WHERE filterOption = ?1 ORDER BY sectionPageNo AND sectionChapterNo ASC',
        mapper: (Map<String, Object?> row) => MySection(id: row['id'] as int?, sectionFirstVerse: row['sectionFirstVerse'] as String?, sectionChapter: row['sectionChapter'] as String?, sectionChapterNo: row['sectionChapterNo'] as int?, sectionStart: row['sectionStart'] as int?, sectionEnd: row['sectionEnd'] as int?, sectionPageNo: row['sectionPageNo'] as int?, isLong: row['isLong'] == null ? null : (row['isLong'] as int) != 0, filterOption: row['filterOption'] == null ? null : FilterOption.values[row['filterOption'] as int]),
        arguments: [index]);
  }

  @override
  Future<List<MySection>> findNotRecitedSections(int index) async {
    return _queryAdapter.queryList(
        'SELECT * FROM MySection WHERE filterOption = ?1 AND isRecited = false ORDER BY sectionPageNo AND sectionChapterNo ASC',
        mapper: (Map<String, Object?> row) => MySection(id: row['id'] as int?, sectionFirstVerse: row['sectionFirstVerse'] as String?, sectionChapter: row['sectionChapter'] as String?, sectionChapterNo: row['sectionChapterNo'] as int?, sectionStart: row['sectionStart'] as int?, sectionEnd: row['sectionEnd'] as int?, sectionPageNo: row['sectionPageNo'] as int?, isLong: row['isLong'] == null ? null : (row['isLong'] as int) != 0, filterOption: row['filterOption'] == null ? null : FilterOption.values[row['filterOption'] as int]),
        arguments: [index]);
  }

  @override
  Future<void> insertMySection(MySection mySection) async {
    await _mySectionInsertionAdapter.insert(
        mySection, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateMySection(MySection mySection) async {
    await _mySectionUpdateAdapter.update(mySection, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteMySection(MySection mySection) async {
    await _mySectionDeletionAdapter.delete(mySection);
  }
}

// ignore_for_file: unused_element
final _filterOptionConverter = FilterOptionConverter();
