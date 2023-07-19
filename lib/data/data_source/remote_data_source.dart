import 'package:advanced_course/data/network/app_api.dart';
import 'package:advanced_course/data/network/requests.dart';
import 'package:advanced_course/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<AuthenticationRespone> login(LoginRequest loginRequest);
  Future<ForgotPasswordResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;
  RemoteDataSourceImpl(
    this._appServiceClient,
  );

  @override
  Future<AuthenticationRespone> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgotPasswordResponse> resetPassword(
      ResetPasswordRequest resetPasswordRequest) async {
    return await _appServiceClient.resetPassword(resetPasswordRequest.email);
  }
}
