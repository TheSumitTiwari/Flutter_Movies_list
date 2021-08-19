import 'package:movies_list/model/movie.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MoviesDatabase {
  static final MoviesDatabase instance = MoviesDatabase._init();

  static Database? _database;

  MoviesDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('movie.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    print('dabPath' + dbPath);
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableMovie ( 
  ${MovieFields.id} $idType, 
  ${MovieFields.img} $textType,
  ${MovieFields.title} $textType,
  ${MovieFields.description} $textType,
  ${MovieFields.time} $textType
  )
''');
  }

  Future<Movie> create(Movie note) async {
    final db = await instance.database;

    final id = await db.insert(tableMovie, note.toJson());
    return note.copy(id: id);
  }

  Future<Movie> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableMovie,
      columns: MovieFields.values,
      where: '${MovieFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Movie.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Movie>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${MovieFields.time} ASC';

    final result = await db.query(tableMovie, orderBy: orderBy);

    return result.map((json) => Movie.fromJson(json)).toList();
  }

  Future<int> update(Movie note) async {
    final db = await instance.database;

    return db.update(
      tableMovie,
      note.toJson(),
      where: '${MovieFields.id} = ?',
      whereArgs: [note.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableMovie,
      where: '${MovieFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
