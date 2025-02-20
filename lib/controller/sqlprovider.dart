import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ionob_task/utils/constants/strings.dart';
import 'package:ionob_task/view/ui/home/model/taskmodel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlProvider extends ChangeNotifier {
  Database? database;
  initdb() async {
    var databasesPath = await getDatabasesPath();
String path = join(databasesPath, 'test.db');
database = await openDatabase(path, version: 1,
    onCreate: (Database db, int version) async {
  // When creating the db, create the table
  await db.execute(
      'CREATE TABLE IF NOT EXISTS $tbltask (id INTEGER PRIMARY KEY, title TEXT, desc TEXT,complete INTEGER,status INTEGER)');
      log("table created");
});
  }

  inserttask(BuildContext context,Task data,bool isedit) async {
    if (isedit) {
      await database?.update(tbltask, data.toInsert(),where: "id = ${data.id}");
    } else {
      await database?.insert(tbltask, data.toInsert());
    }
    
  }

  deletetask(BuildContext context,int id) async{
    await database?.delete(tbltask,where: "id = $id");
  }

  gettask(BuildContext context) async {
    List<Task> tasklist=[];
    var map = await database?.rawQuery("SELECT * FROM $tbltask where status =1");
    log(map.toString());
    if (map!=null) {

      for (var i = 0; i < map.length; i++) {
        tasklist.add(Task(
        id: map[i]['id'] as int?,
        title: map[i]['title'] as String?,
        desc: map[i]['desc'] as String?,
        iscomplete: map[i]['complete'] as int?
      ));
      }
    }
    return tasklist;
  }
}