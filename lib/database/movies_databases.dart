import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pmsn2024/models/moviesdao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class MoviesDatabases {
  static const String NAMEDB = 'MOVIESDB';
  static const int VERSIONDB = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    Directory folder = await getApplicationDocumentsDirectory();
    String path = join(folder.path, NAMEDB);
    return await openDatabase(
      path,
      version: VERSIONDB,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE tblgenre (
          idGenero CHAR(1) PRIMARY KEY,
          dscgenre VARCHAR(50)
        );
        ''');

        await db.execute('''
        CREATE TABLE tblmovies (
  idMovie INTEGER PRIMARY KEY AUTOINCREMENT,
  nameMovie VARCHAR(50),
  OVERVIEW TEXT,
  idGenero CHAR(1),
  imgMovie VARCHAR(150),
  releaseDate CHAR(10),
  FOREIGN KEY (idGenero) REFERENCES tblgenre(idGenero)
);

        ''');
      },
    );
  }

  Future<int> INSERT(String table, Map<String, dynamic> row) async {
    var con = await database;
    return await con.insert(table, row);
  }

  Future<int> UPDATE(String table, Map<String, dynamic> row) async {
    var con = await database;
    return await con.update(
      table,
      row,
      where: 'idMovie = ?',
      whereArgs: [row['idMovie']],
    );
  }

  Future<int> DELETE(String table, int idMovie) async {
    var con = await database;
    return await con.delete(table, where: 'idMovie = ?', whereArgs: [idMovie]);
  }

  Future<List<MoviesDAO>> SELECT() async {
    var con = await database;
    var result = await con.query('tblmovies');
    return result.map((movie) => MoviesDAO.fromMap(movie)).toList();
  }
}
