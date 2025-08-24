import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:mibook/layers/data/api/custom_errors.dart';

abstract class IApiClient {
  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> options = const {},
  });

  Future<Map<String, dynamic>> post({
    required String endpoint,
    Map<String, dynamic> body = const {},
    Map<String, dynamic> options = const {},
  });

  Future<Map<String, dynamic>> put({
    required String endpoint,
    Map<String, dynamic> body = const {},
    Map<String, dynamic> options = const {},
  });

  Future<Map<String, dynamic>> delete({required endpoint});

  Future<Map<String, dynamic>> patch({
    required String endpoint,
    Map<String, dynamic> body = const {},
    Map<String, dynamic> options = const {},
  });
}

@Injectable(as: IApiClient)
class ApiClient implements IApiClient {
  final Dio _dio;

  ApiClient(this._dio);

  @override
  Future<Map<String, dynamic>> get({
    required String endpoint,
    Map<String, dynamic> queryParameters = const {},
    Map<String, dynamic> options = const {},
  }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: Options(headers: options),
      );
      return _processResponse(response);
    } on DioException catch (e) {
      throw _handleError(e); // Explicitly throw an error
    }
  }

  @override
  Future<Map<String, dynamic>> post({
    required String endpoint,
    Map<String, dynamic> body = const {},
    Map<String, dynamic> options = const {},
  }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: body,
        options: Options(headers: options),
      );
      return _processResponse(response);
    } on DioException catch (e) {
      throw _handleError(e); // Explicitly throw an error
    }
  }

  @override
  Future<Map<String, dynamic>> put({
    required String endpoint,
    Map<String, dynamic> body = const {},
    Map<String, dynamic> options = const {},
  }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: body,
        options: Options(headers: options),
      );
      return _processResponse(response);
    } on DioException catch (e) {
      throw _handleError(e); // Explicitly throw an error
    }
  }

  @override
  Future<Map<String, dynamic>> delete({required endpoint}) async {
    try {
      final response = await _dio.delete(endpoint);
      return _processResponse(response);
    } on DioException catch (e) {
      throw _handleError(e); // Explicitly throw an error
    }
  }

  @override
  Future<Map<String, dynamic>> patch({
    required String endpoint,
    Map<String, dynamic> body = const {},
    Map<String, dynamic> options = const {},
  }) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: body,
        options: Options(headers: options),
      );
      return _processResponse(response);
    } on DioException catch (e) {
      throw _handleError(e); // Explicitly throw an error
    }
  }

  Map<String, dynamic> _processResponse(Response response) {
    if (response.statusCode != null &&
        response.statusCode! >= 200 &&
        response.statusCode! < 300) {
      return response.data as Map<String, dynamic>;
    } else {
      throw Exception(
        'Request failed with status: ${response.statusCode}, data: ${response.data}',
      );
    }
  }

  Exception _handleError(DioException error) {
    if (error.response != null) {
      if (error.response?.statusCode == 401) {
        return UnauthorizedError(requestOptions: RequestOptions());
      }
      return Exception(
        'DioError: ${error.response?.statusCode}, ${error.response?.data}',
      );
    } else {
      return Exception('DioError: ${error.message}');
    }
  }
}
