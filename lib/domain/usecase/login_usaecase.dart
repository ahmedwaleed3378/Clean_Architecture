import 'package:advanced_course/data/network/failure.dart';
import 'package:advanced_course/data/network/requests.dart';
import 'package:advanced_course/domain/models/models.dart';
import 'package:advanced_course/domain/repository/repository.dart';
import 'package:advanced_course/domain/usecase/base_uscase.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase implements BaseUseCase<LoginRequest, Authentication> {
  final Repository _repository;

  LoginUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(LoginRequest input) async {
    return await _repository.login(input);
  }
}
