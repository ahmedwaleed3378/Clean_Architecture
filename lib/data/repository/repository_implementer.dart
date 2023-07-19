import 'dart:developer';
import 'package:advanced_course/data/mappers/mapper.dart';
import 'package:advanced_course/data/network/error_handler.dart';
import 'package:dartz/dartz.dart';

import 'package:advanced_course/data/data_source/remote_data_source.dart';
import 'package:advanced_course/data/network/failure.dart';
import 'package:advanced_course/data/network/network_info.dart';
import 'package:advanced_course/data/network/requests.dart';
import 'package:advanced_course/domain/models/models.dart';
import 'package:advanced_course/domain/repository/repository.dart';

class RepositoryImplementer implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  RepositoryImplementer(
    this._remoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final respone = await _remoteDataSource.login(loginRequest);

        if (respone.status == APIInternalStatus.SUCCESS) {
          //success
          return Right(respone.toDomain());
        } else {
          //failure
          return Left(Failure(
              code: APIInternalStatus.FAILURE,
              message: respone.message ?? ResponseMessage.UNKNOWN));
        }
      } catch (e) {
        print('---------------');
        print(e.toString());
        return Left(ErrorHandler.handler(e).failure);
      }
    }

    //no internet
    else {
      //failure
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ForgotPassword>> resetPassword(
      ResetPasswordRequest resetRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.resetPassword(resetRequest);
        if (response.status == APIInternalStatus.SUCCESS) {
          // success
          return Right(response.toDomain());
        } else {
          //failure

          return Left(Failure(
              code: APIInternalStatus.FAILURE,
              message: response.message ?? ResponseMessage.UNKNOWN));
        }
      } catch (e) {
        log('---------------');
      //  log(e.toString());
        return Left(ErrorHandler.handler(e).failure);
      }
    } else {
      //failure No Internet connection
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
