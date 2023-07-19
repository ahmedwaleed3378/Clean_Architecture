import 'package:advanced_course/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
const String prefKey='Prefernces Key';
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED =
    "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
class AppPreferences {
 final  SharedPreferences _sharedPreferences ;
  AppPreferences(
  this._sharedPreferences
  );
  Future<String >getAppLang()async{
   String? language =_sharedPreferences.getString(prefKey);
   if (language!=null&&language.isNotEmpty) {
    return language;
     
   }
   else {
    return LanguageTypes.ENGLISH.getValue();
   }
  }

  
  // on boarding

  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED) ??
        false;
  }

  //login

  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }
}
