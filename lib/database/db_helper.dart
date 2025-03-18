import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/model.dart';

class dbHelper{

  static const String TABLE_NAME = "todo";
  static const String COLUMN_ID = "nId";
  static const String COLUMN_TITLE = "nTitle";
  static const String COLUMN_DESC = "nDesc";
  static const String COLUMN_ISCOMPLETED = "isCompleted";

  dbHelper._();
  static dbHelper GetIntstance() => dbHelper._();

  Database? _Db;

  Future<Database>getDb()async{
    _Db ??= await createDb();
    return _Db!;
  }


  Future<Database>createDb()async{

    Directory appFiles = await getApplicationDocumentsDirectory();
    String dbPath = join(appFiles.path,"todoDB.db");

    return await openDatabase(dbPath, version: 1, onCreate: (db,version){
      db.execute("CREATE TABLE $TABLE_NAME($COLUMN_ID integer primary key autoincrement,$COLUMN_TITLE text,$COLUMN_DESC text,$COLUMN_ISCOMPLETED integer)");
    });
  }

  Future<bool> addTodo({required todoModel newModel})async{
    Database db= await getDb();

    int rowsEffected = await db.insert(TABLE_NAME, newModel.toMap());
    return rowsEffected>0;
  }

  Future<bool>updateIsCompleted ({required nID,required isComplete})async{
    Database db = await getDb();
    int rowsEffected = await db.update(TABLE_NAME, {
      COLUMN_ISCOMPLETED : isComplete
    },where: "$COLUMN_ID=?" , whereArgs: ["$nID"]);
    return rowsEffected>0;
  }

  Future<bool>updateTodo({required nId, required nTitle, required nDesc})async{
    Database db = await getDb();
    int rowsEffected = await db.update(TABLE_NAME, {COLUMN_ID : nId,COLUMN_TITLE : nTitle,COLUMN_DESC : nDesc},where: "$COLUMN_ID=?",whereArgs: ["$nId"]);
    return rowsEffected>0;
  }

  Future<bool>deleteTodo({required nId})async{
    Database db = await getDb();
    int rowsEffected = await db.delete(TABLE_NAME,where: "$COLUMN_ID=?",whereArgs: ["$nId"]);
    return rowsEffected>0;
  }

  Future<List<todoModel>> fetchAllTodo()async{
    var db = await getDb();
    List<Map<String,dynamic>> mTodo = await db.query(TABLE_NAME);

    List<todoModel> allTodo = [];

    /// Using foreach loop for insert data map to model
    for(Map<String,dynamic> eachTodo in mTodo){
      allTodo.add(todoModel.fromMap(eachTodo));
    }
    return allTodo;
  }

  /*Future<List<todoModel>> fetchPendingTodo()async{
    var db = await getDb();
    List<Map<String,dynamic>> mTodo = await db.query(TABLE_NAME,where: "$COLUMN_ISCOMPLETED=?",whereArgs: ["0"]);

    List<todoModel> allTodo = [];

    /// Using foreach loop for insert data map to model
    for(Map<String,dynamic> eachTodo in mTodo){
      allTodo.add(todoModel.fromMap(eachTodo));
    }
    return allTodo;
  }

  Future<List<todoModel>> fetchCompleteTodo()async{
    var db = await getDb();
    List<Map<String,dynamic>> mTodo = await db.query(TABLE_NAME,where: "$COLUMN_ISCOMPLETED=?",whereArgs: ["1"]);

    List<todoModel> allTodo = [];

    /// Using foreach loop for insert data map to model
    for(Map<String,dynamic> eachTodo in mTodo){
      allTodo.add(todoModel.fromMap(eachTodo));
    }
    return allTodo;
  }*/
}