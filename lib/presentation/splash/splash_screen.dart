import 'dart:async';

import 'package:advanced_course/app/app_preferences.dart';
import 'package:advanced_course/app/di.dart';
import 'package:advanced_course/presentation/resources/assets_manager.dart';
import 'package:advanced_course/presentation/resources/color_manager.dart';
import 'package:advanced_course/presentation/resources/constants_manager.dart';
import 'package:advanced_course/presentation/resources/routes_manager.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;
final AppPreferences _appPreferences=instance<AppPreferences>();
  void _startDelay() {
    _timer = Timer(const Duration(seconds: Constants.splashDelay), goNext);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: const Center(
          child: Image(image: AssetImage(ImageAssets.splashLogo))),
    );
  }

  void goNext() async{
    _appPreferences.isUserLoggedIn().then((isUserLoggedIn) {
      if (isUserLoggedIn) {
        Navigator.pushReplacementNamed(context, Routes.mainRoute);
      } else {
      _appPreferences.isOnBoardingScreenViewed().then((isOnBoardingScreenViewed) {
          if (isOnBoardingScreenViewed) {
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);

          } else {
                    Navigator.pushReplacementNamed(context, Routes.onBoarding);

          }
      });
      }
    });
    
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }
}
