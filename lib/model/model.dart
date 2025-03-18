import 'package:sqflite/sqflite.dart';
import 'package:todo_block/database/db_helper.dart';

class todoModel {
  int? nId;
  String nTitle;
  String nDesc;
  bool isCompleted;

  todoModel(
      {this.nId,
      required this.nTitle,
      required this.nDesc,
      required this.isCompleted});

  /// UI from Database
  static fromMap(Map<String, dynamic> tMap) {
    return todoModel(
        nId: tMap[dbHelper.COLUMN_ID],
        nTitle: tMap[dbHelper.COLUMN_TITLE],
        nDesc: tMap[dbHelper.COLUMN_DESC],
        isCompleted: tMap[dbHelper.COLUMN_ISCOMPLETED]==0 ? false :true);
  }

  /// Database to UI
  Map<String,dynamic> toMap(){
    return{
      dbHelper.COLUMN_TITLE: nTitle,
      dbHelper.COLUMN_DESC: nDesc,
      dbHelper.COLUMN_ISCOMPLETED: isCompleted ? 1 :0,
    };
  }
}
