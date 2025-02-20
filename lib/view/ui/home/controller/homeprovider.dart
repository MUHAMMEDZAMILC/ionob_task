// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:ionob_task/controller/sqlprovider.dart';
import 'package:ionob_task/view/ui/home/model/taskmodel.dart';
import 'package:provider/provider.dart';

class HomeProvider extends ChangeNotifier {
  
  bool iscomplete = false,ispageloading = true,isbtnloading = false;
 togglecomplete() async {
  iscomplete = !iscomplete;
  notifyListeners();
 }
 List<Task> tasklist = [];
 gettasks(BuildContext context) async {
  tasklist = await context.read<SqlProvider>().gettask(context);
  ispageloading = false;
  notifyListeners();
 } 

 inserttask(BuildContext context,Task data,bool isedit ) async{
  isbtnloading = true;
  notifyListeners();
  await context.read<SqlProvider>().inserttask(context, data,isedit);
  gettasks(context);
  isbtnloading = false;
  notifyListeners();
 }

 deletetask(BuildContext context,int id,) async {
  await context.read<SqlProvider>().deletetask(context, id,);
  gettasks(context);
 }
}