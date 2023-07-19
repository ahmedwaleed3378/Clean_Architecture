import 'package:advanced_course/app/di.dart';
import 'package:advanced_course/presentation/resources/strings_manager.dart';
import 'package:advanced_course/presentation/forgot_password/view/forgot_password_screen.dart';
import 'package:advanced_course/presentation/login/view/login_screen.dart';
import 'package:advanced_course/presentation/main/main_screen.dart';
import 'package:advanced_course/presentation/onboarding/view/onboarding_screen.dart';
import 'package:advanced_course/presentation/register/register_screen.dart';
import 'package:advanced_course/presentation/splash/splash_screen.dart';
import 'package:advanced_course/presentation/store_details/store_details_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = '/';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String mainRoute = '/main';
  static const String onBoarding = '/onBoarding';
  static const String storeDetailRoute = '/storeDetail';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );

      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(
          builder: (context) {
            return const LoginScreen();
          },
        );
      case Routes.onBoarding:
        return MaterialPageRoute(
          builder: (context) => const OnBoarding(),
        );

      case Routes.registerRoute:
        return MaterialPageRoute(
          builder: (context) => const RegisterScreen(),
        );

      case Routes.forgotPasswordRoute:
        initResetPassModule();
        return MaterialPageRoute(
          builder: (context) => const ForgotPassScreen(),
        );

      case Routes.mainRoute:
        return MaterialPageRoute(
          builder: (context) => const MainScreen(),
        );

      case Routes.storeDetailRoute:
        return MaterialPageRoute(
          builder: (context) => const StoreDetailsScreen(),
        );

      default:
        return unDefined();
    }
  }

  static Route<dynamic> unDefined() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(title: const Text(Strings.noRoute)),
              body: const Center(
                child: Text(Strings.noRoute),
              ),
            ));
  }
}
