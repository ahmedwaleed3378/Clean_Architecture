import 'package:advanced_course/app/constants.dart';
import 'package:advanced_course/data/responses/responses.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
part 'app_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST('/customers/login')
  Future<AuthenticationRespone> login(
    @Field('email') String email,
    @Field('password') String password,
  );

  @POST('/customers/forgotPassword')
  Future<ForgotPasswordResponse> resetPassword(@Field('email') String email);
}
