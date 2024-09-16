import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pmsn2024/models/moviesdao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class MoviesDatabases {
  static final NAMEDB='MOVIESDB';
  static final VERSIONDB=1;

  static Database? _database;

  Future<Database> get database async{
    if(_database != null) return _database!;
    
    return _database = await initDatabase();

  }

Future<Database>  initDatabase() async{
   Directory folder = await getApplicationDocumentsDirectory() ;
   String path = join(folder.path, NAMEDB);
    return openDatabase(
      path,
      version: VERSIONDB,
      onCreate: (db, version) {
        String query ='''
        CREATE TABLE tblgenre(
          idGenero CHAR(1) PRIMARY KEY,
          dscgenre VARCHAR(50)
        );


        CREATE TABLE tblmovies (
        idMovie INTEGER PRIMARY KEY,
        nameMovie VARCHAR(50),
        OVERvIEW TEXT,
        idGenero char(1),
        imgMovie VARCHAR(150),
        releaseDate CHAR(10),
        CONSTRAINT fk_genero FOREIGN KEY (idGenero) REFERENCES tblgenre(idGenero)
        );''';
        db.execute(query);
      },

    );

  

  }


 
  
  Future<int> INSERT(String table, Map<String, dynamic> row )async {
    var con=  await database ;
    return await con.insert(table, row);
  }
  Future<int> UPDATE(String table, Map<String, dynamic> row)async {
    var con = await database ;
    return await con.update(table, row, where: 'idMovie=?',whereArgs: [row['idMovie']]);
    
  }
  Future<int> DELETE(String table , int idMovie)async{
    var con= await database ;
    return await con.delete(table, where: 'idMovie=?',whereArgs: [idMovie]);
  }
  Future<List<MoviesDAO>> SELECT()async{
    var con = await database ;
    var result = await con.query('tblmovies');
    return result.map((movie) => MoviesDAO.fromMap(movie)).toList();
  }
  
}



