import 'package:dio/dio.dart';

class UnauthorizedError extends DioException {
  UnauthorizedError({required super.requestOptions});
}

class DuplicatedReadingError extends Error {
  DuplicatedReadingError();
}
