import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ionob_task/controller/sqlprovider.dart';
import 'package:ionob_task/utils/helper/pagenavigator.dart';
import 'package:ionob_task/view/ui/home/view/homepage.dart';
import 'package:provider/provider.dart';

class SplashProvider extends ChangeNotifier {
  
  initsplash(BuildContext context) async {
    await context.read<SqlProvider>().initdb();
    Timer(Duration(seconds: 3), () {
      Screen.openAsNewPage(context, HomeScree());
    },);
  }
}