

import 'package:flutter/material.dart';
import 'package:ionob_task/controller/sqlprovider.dart';
import 'package:ionob_task/utils/constants/appconstants.dart';
import 'package:ionob_task/utils/theme/themedata.dart';
import 'package:ionob_task/view/ui/home/controller/homeprovider.dart';
import 'package:ionob_task/view/ui/splash/controller/splashprovider.dart';
import 'package:ionob_task/view/ui/splash/view/splashscreen.dart';
import 'package:provider/provider.dart';

class IoNobMaterialApp extends StatelessWidget {
  const IoNobMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashProvider(),),
        ChangeNotifierProvider(create: (context) => SqlProvider(),),
        ChangeNotifierProvider(create: (context) => HomeProvider(),),
      ],
      builder: (context,child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstant().appname,
          theme: ThemeDataNob.deftheme,
          home:SplashScreen() ,
        );
      }
    );
  }
}