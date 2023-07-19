import 'package:advanced_course/data/network/requests.dart';
import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../models/models.dart';

abstract class Repository{
Future  <Either <Failure,Authentication>> login(LoginRequest loginRequest);
Future  <Either <Failure,ForgotPassword>> resetPassword(ResetPasswordRequest resetRequest);
}