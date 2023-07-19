import 'package:advanced_course/data/network/failure.dart';
import 'package:advanced_course/data/network/requests.dart';
import 'package:advanced_course/domain/models/models.dart';
import 'package:advanced_course/domain/repository/repository.dart';
import 'package:advanced_course/domain/usecase/base_uscase.dart';
import 'package:dartz/dartz.dart';

class ResetPasswordUseCase
    implements BaseUseCase<ResetPasswordRequest, ForgotPassword> {
  final Repository _repository;

  ResetPasswordUseCase(this._repository);
  @override
  Future<Either<Failure, ForgotPassword>> execute(
      ResetPasswordRequest input) async {
    return await _repository.resetPassword(input);
  }
}
