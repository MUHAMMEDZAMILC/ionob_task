import 'package:flutter/material.dart';
import 'package:ionob_task/utils/constants/colors.dart';
import 'package:ionob_task/utils/helper/help_screensize.dart';
import 'package:ionob_task/view/components/apptext.dart';
import 'package:ionob_task/view/ui/splash/controller/splashprovider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    context.read<SplashProvider>().initsplash(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: SizedBox(
        width: ScreenUtil.screenWidth,
        height: ScreenUtil.screenHeight,
        child: Column(children: [
          AppText(text: 'Task',weight: FontWeight.w500,letterspace: 0.5,color: ColorResources.blackcolor,)
        ],),
      ),
    );
  }
}