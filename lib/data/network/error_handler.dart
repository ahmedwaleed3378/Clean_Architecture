





// import 'package:advanced_course/data/network/failure.dart';
// import 'package:advanced_flutter_arabic/data/network/failure.dart';
// import 'package:dio/dio.dart';
// import 'package:easy_localization/easy_localization.dart';

// import '../../presentation/resources/strings_manager.dart';

// class ErrorHandler implements Exception {
//   late Failure failure;

//   ErrorHandler.handle(dynamic error) {
//     if (error is DioError) {
//       // dio error so its an error from response of the API or from dio itself
//       failure = _handleError(error);
//     } else {
//       // default error
//       failure = DataSource.DEFAULT.getFailure();
//     }
//   }
// }

// Failure _handleError(DioError error) {
//   switch (error.type) {
//     case DioErrorType.connectTimeout:
//       return DataSource.CONNECT_TIMEOUT.getFailure();
//     case DioErrorType.sendTimeout:
//       return DataSource.SEND_TIMEOUT.getFailure();
//     case DioErrorType.receiveTimeout:
//       return DataSource.RECIEVE_TIMEOUT.getFailure();
//     case DioErrorType.response:
//       if (error.response != null &&
//           error.response?.statusCode != null &&
//           error.response?.statusMessage != null) {
//         return Failure(error.response?.statusCode ?? 0,
//             error.response?.statusMessage ?? "");
//       } else {
//         return DataSource.DEFAULT.getFailure();
//       }
//     case DioErrorType.cancel:
//       return DataSource.CANCEL.getFailure();
//     case DioErrorType.other:
//       return DataSource.DEFAULT.getFailure();
//   }
// }

// enum DataSource {
//   SUCCESS,
//   NO_CONTENT,
//   BAD_REQUEST,
//   FORBIDDEN,
//   UNAUTORISED,
//   NOT_FOUND,
//   INTERNAL_SERVER_ERROR,
//   CONNECT_TIMEOUT,
//   CANCEL,
//   RECIEVE_TIMEOUT,
//   SEND_TIMEOUT,
//   CACHE_ERROR,
//   NO_INTERNET_CONNECTION,
//   DEFAULT
// }

// extension DataSourceExtension on DataSource {
//   Failure getFailure() {
//     switch (this) {
//       case DataSource.SUCCESS:
//         return Failure(code:ResponseCode.SUCCESS,message: ResponseMessage.SUCCESS);
//       case DataSource.NO_CONTENT:
//         return Failure(
//          code:   ResponseCode.NO_CONTENT,message: ResponseMessage.NO_CONTENT);
//       case DataSource.BAD_REQUEST:
//         return Failure(
//          code:   ResponseCode.BAD_REQUEST, message:ResponseMessage.BAD_REQUEST);
//       case DataSource.FORBIDDEN:
//         return Failure(code:ResponseCode.FORBIDDEN,message: ResponseMessage.FORBIDDEN);
//       case DataSource.UNAUTORISED:
//         return Failure(
//          code:   ResponseCode.UNAUTORISED,message: ResponseMessage.UNAUTORISED);
//       case DataSource.NOT_FOUND:
//         return Failure(code:ResponseCode.NOT_FOUND,message: ResponseMessage.NOT_FOUND);
//       case DataSource.INTERNAL_SERVER_ERROR:
//         return Failure(code:ResponseCode.INTERNAL_SERVER_ERROR,message:
//             ResponseMessage.INTERNAL_SERVER_ERROR);
//       case DataSource.CONNECT_TIMEOUT:
//         return Failure(
//          code:   ResponseCode.CONNECT_TIMEOUT,message: ResponseMessage.CONNECT_TIMEOUT);
//       case DataSource.CANCEL:
//         return Failure(code:ResponseCode.CANCEL,message: ResponseMessage.CANCEL);
//       case DataSource.RECIEVE_TIMEOUT:
//         return Failure(
//       code:      ResponseCode.RECIEVE_TIMEOUT,message: ResponseMessage.RECIEVE_TIMEOUT);
//       case DataSource.SEND_TIMEOUT:
//         return Failure(
//         code:    ResponseCode.SEND_TIMEOUT,message: ResponseMessage.SEND_TIMEOUT);
//       case DataSource.CACHE_ERROR:
//         return Failure(
//           code:  ResponseCode.CACHE_ERROR,message: ResponseMessage.CACHE_ERROR);
//       case DataSource.NO_INTERNET_CONNECTION:
//         return Failure(code:ResponseCode.NO_INTERNET_CONNECTION,
//        message:     ResponseMessage.NO_INTERNET_CONNECTION);
//       case DataSource.DEFAULT:
//         return Failure(code:ResponseCode.DEFAULT,message: ResponseMessage.DEFAULT);
//     }
//   }
// }

// class ResponseCode {
//   static const int SUCCESS = 200; // success with data
//   static const int NO_CONTENT = 201; // success with no data (no content)
//   static const int BAD_REQUEST = 400; // failure, API rejected request
//   static const int UNAUTORISED = 401; // failure, user is not authorised
//   static const int FORBIDDEN = 403; //  failure, API rejected request
//   static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side
//   static const int NOT_FOUND = 404; // failure, not found

//   // local status code
//   static const int CONNECT_TIMEOUT = -1;
//   static const int CANCEL = -2;
//   static const int RECIEVE_TIMEOUT = -3;
//   static const int SEND_TIMEOUT = -4;
//   static const int CACHE_ERROR = -5;
//   static const int NO_INTERNET_CONNECTION = -6;
//   static const int DEFAULT = -7;
// }

// class ResponseMessage {
//   static const String SUCCESS = 'success'; // success with data
//   static const String NO_CONTENT =
//       'success'; // success with no data (no content)
//   static const String BAD_REQUEST =
//       'badRequestError'; // failure, API rejected request
//   static const String UNAUTORISED =
//       'unauthorizedError'; // failure, user is not authorised
//   static const String FORBIDDEN =
//       'forbiddenError'; //  failure, API rejected request
//   static const String INTERNAL_SERVER_ERROR =
//       'internalServerError'; // failure, crash in server side
//   static const String NOT_FOUND =
//       'notFoundError'; // failure, crash in server side

//   // local status code
//   static const String CONNECT_TIMEOUT = 'timeoutError';
//   static const String CANCEL = 'defaultError';
//   static const String RECIEVE_TIMEOUT = 'timeoutError';
//   static const String SEND_TIMEOUT = 'timeoutError';
//   static const String CACHE_ERROR = 'cacheError';
//   static const String NO_INTERNET_CONNECTION = 'noInternetError';
//   static const String DEFAULT = 'defaultError';
// }

// class ApiInternalStatus {
//   static const int SUCCESS = 0;
//   static const int FAILURE = 1;
// }




// ignore_for_file: constant_identifier_names

import 'package:advanced_course/data/network/failure.dart';
import 'package:dio/dio.dart';

class ErrorHandler implements Exception {
  late Failure failure;
  ErrorHandler.handler(dynamic error) {
    if (error is DioException) {
      failure = _handling(error);
    }
    //default error
    else {
      failure =
          Failure(code: ResponseCode.UNKNOWN, message: ResponseMessage.UNKNOWN);
    }
  }
}

Failure _handling(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.CONNECT_TIMEOUT.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.RECIEVE_TIMEOUT.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.UNAUTORISED.getFailure();
    case DioExceptionType.badResponse:
      if (error.response != null &&
          error.response?.statusCode != null &&
          error.response?.statusMessage != null) {
        return Failure(
            code: error.response?.statusCode ?? 0,
            message: error.response?.statusMessage ?? '');
      } else {
        return Failure(
            code: ResponseCode.UNKNOWN, message: ResponseMessage.UNKNOWN);
      }

    case DioExceptionType.cancel:
      return DataSource.CANCEL.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.CACHE_ERROR.getFailure();
    case DioExceptionType.unknown:
      return DataSource.DFAULT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTORISED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DFAULT
}

extension DataSourceExtention on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(
            code: ResponseCode.SUCCESS, message: ResponseMessage.SUCCESS);

      case DataSource.NO_CONTENT:
        return Failure(
            code: ResponseCode.NO_CONTENT, message: ResponseMessage.NO_CONTENT);

      case DataSource.BAD_REQUEST:
        return Failure(
            code: ResponseCode.BAD_REQUEST,
            message: ResponseMessage.BAD_REQUEST);

      case DataSource.FORBIDDEN:
        return Failure(
            code: ResponseCode.FORBIDDEN, message: ResponseMessage.FORBIDDEN);

      case DataSource.UNAUTORISED:
        return Failure(
            code: ResponseCode.UNAUTORISED,
            message: ResponseMessage.UNAUTORISED);

      case DataSource.NOT_FOUND:
        return Failure(
            code: ResponseCode.NOT_FOUND, message: ResponseMessage.NOT_FOUND);

      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(
            code: ResponseCode.INTERNAL_SERVER_ERROR,
            message: ResponseMessage.INTERNAL_SERVER_ERROR);

      case DataSource.CONNECT_TIMEOUT:
        return Failure(
            code: ResponseCode.CONNECT_TIMEOUT,
            message: ResponseMessage.CONNECT_TIMEOUT);

      case DataSource.CANCEL:
        return Failure(
            code: ResponseCode.CANCEL, message: ResponseMessage.CANCEL);

      case DataSource.RECIEVE_TIMEOUT:
        return Failure(
            code: ResponseCode.RECIEVE_TIMEOUT,
            message: ResponseMessage.RECIEVE_TIMEOUT);

      case DataSource.SEND_TIMEOUT:
        return Failure(
            code: ResponseCode.SEND_TIMEOUT,
            message: ResponseMessage.SEND_TIMEOUT);

      case DataSource.CACHE_ERROR:
        return Failure(
            code: ResponseCode.CACHE_ERROR,
            message: ResponseMessage.CACHE_ERROR);

      case DataSource.NO_INTERNET_CONNECTION:
      case DataSource.DFAULT:
        return Failure(
            code: ResponseCode.UNKNOWN, message: ResponseMessage.UNKNOWN);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data (no content)
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUTORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; //  failure, API rejected request
  static const int NOT_FOUND = 404; //  failure, API rejected request
  static const int INTERNAL_SERVER_ERROR = 500; // failure, crash in server side

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int UNKNOWN = -7;
}

class ResponseMessage {
  static const String SUCCESS = "success"; // success with data
  static const String NO_CONTENT =
      "success"; // success with no data (no content)
  static const String BAD_REQUEST =
      "Bad request, Try again later"; // failure, API rejected request
  static const String UNAUTORISED =
      "User is unauthorised, Try again later"; // failure, user is not authorised
  static const String FORBIDDEN =
      "Forbidden request, Try again later"; //  failure, API rejected request
  static const String NOT_FOUND = "Not Found"; //  failure, API rejected request
  static const String INTERNAL_SERVER_ERROR =
      "Some thing went wrong, Try again later"; // failure, crash in server side

  // local status code
  static const String CONNECT_TIMEOUT = "Time out error, Try again later";
  static const String CANCEL = "Request was cancelled, Try again later";
  static const String RECIEVE_TIMEOUT = "Time out error, Try again later";
  static const String SEND_TIMEOUT = "Time out error, Try again later";
  static const String CACHE_ERROR = "Cache error, Try again later";
  static const String NO_INTERNET_CONNECTION =
      "Please check your internet connection";
  static const String UNKNOWN = "Some thing went wrong, Try again later";
}

class APIInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
