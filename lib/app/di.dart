import 'package:advanced_course/app/app_preferences.dart';
import 'package:advanced_course/data/repository/repository_implementer.dart';
import 'package:advanced_course/domain/models/models.dart';
import 'package:advanced_course/domain/usecase/login_usaecase.dart';
import 'package:advanced_course/domain/usecase/reset_password_usecase.dart';
import 'package:advanced_course/presentation/forgot_password/view_model/forgot_password_viewmodel.dart';
import 'package:advanced_course/presentation/login/view_model/login_viewmodel.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/data_source/remote_data_source.dart';
import '../data/network/app_api.dart';
import '../data/network/dio_factory.dart';
import '../data/network/network_info.dart';
import '../domain/repository/repository.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  //app module: all generic dependencies

  // we could create an init function to define the dependencies of one specific module
  //such as login Module or chat Module

  // instances
  final SharedPreferences sharedPreferencesInstance =
      await SharedPreferences.getInstance();
  instance.registerLazySingleton<SharedPreferences>(
      () => sharedPreferencesInstance);

  instance
      .registerLazySingleton<AppPreferences>(() => AppPreferences(instance()));

  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() => DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();
  //app service client
  instance.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<AppServiceClient>()));

  // repository

  instance.registerLazySingleton<Repository>(
      () => RepositoryImplementer(instance(), instance()));
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

Future<void> initResetPassModule() async {
  if (!GetIt.I.isRegistered<ResetPasswordUseCase>()) {
    instance.registerFactory<ResetPasswordUseCase>(
        () => ResetPasswordUseCase(instance()));
    instance.registerFactory<ForgotPasswordViewModel>(
        () => ForgotPasswordViewModel(instance()));
  }
}
