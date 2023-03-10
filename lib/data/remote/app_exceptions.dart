import 'package:tech_task/res/app_string.dart';

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, AppString.instance.errorDuringCommunication);
}

class BadRequestException extends AppException {
  BadRequestException([String? message])
      : super(message, AppString.instance.invalidRequest);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([String? message])
      : super(message, AppString.instance.unauthorisedRequest);
}

class InvalidInputException extends AppException {
  InvalidInputException([String? message])
      : super(message, AppString.instance.unauthorisedInput);
}
