// // Dart

// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
// import 'package:dio/dio.dart';
// import 'package:mibook/layers/data/api/api_client.dart';
// import 'package:mibook/layers/data/api/custom_errors.dart';

// // Mock class for Dio
// class MockDio extends Mock implements Dio {}

// void main() {
//   late MockDio mockDio;
//   late ApiClient apiClient;

//   setUp(() {
//     mockDio = MockDio();
//     apiClient = ApiClient();
//     // Replace the internal _dio with mockDio for testing
//     apiClient = ApiClientTestWrapper(mockDio);
//   });

//   group('ApiClient', () {
//     test('get returns data on success', () async {
//       final response = Response(
//         data: {'key': 'value'},
//         statusCode: 200,
//         requestOptions: RequestOptions(path: '/test'),
//       );
//       when(
//         mockDio.get(
//           '',
//           queryParameters: anyNamed('queryParameters'),
//           options: anyNamed('options'),
//         ),
//       ).thenAnswer((_) async => response);

//       final result = await apiClient.get(endpoint: '');
//       expect(result, {'key': 'value'});
//     });

//     test('get throws UnauthorizedError on 401', () async {
//       final dioException = DioException(
//         response: Response(
//           statusCode: 401,
//           data: {},
//           requestOptions: RequestOptions(path: '/test'),
//         ),
//         requestOptions: RequestOptions(path: '/test'),
//       );
//       when(
//         mockDio.get(
//           '',
//           queryParameters: anyNamed('queryParameters'),
//           options: anyNamed('options'),
//         ),
//       ).thenThrow(dioException);

//       expect(
//         () => apiClient.get(endpoint: ''),
//         throwsA(isA<UnauthorizedError>()),
//       );
//     });

//     test('post returns data on success', () async {
//       final response = Response(
//         data: {'created': true},
//         statusCode: 201,
//         requestOptions: RequestOptions(path: '/test'),
//       );
//       when(
//         mockDio.post('', data: anyNamed('data'), options: anyNamed('options')),
//       ).thenAnswer((_) async => response);

//       final result = await apiClient.post(
//         endpoint: '/test',
//         body: {'foo': 'bar'},
//       );
//       expect(result, {'created': true});
//     });

//     test('put returns data on success', () async {
//       final response = Response(
//         data: {'updated': true},
//         statusCode: 200,
//         requestOptions: RequestOptions(path: '/test'),
//       );
//       when(
//         mockDio.put('', data: anyNamed('data'), options: anyNamed('options')),
//       ).thenAnswer((_) async => response);

//       final result = await apiClient.put(
//         endpoint: '/test',
//         body: {'foo': 'bar'},
//       );
//       expect(result, {'updated': true});
//     });

//     test('delete returns data on success', () async {
//       final response = Response(
//         data: {'deleted': true},
//         statusCode: 200,
//         requestOptions: RequestOptions(path: ''),
//       );
//       when(mockDio.delete('')).thenAnswer((_) async => response);

//       final result = await apiClient.delete(endpoint: '');
//       expect(result, {'deleted': true});
//     });

//     test('patch returns data on success', () async {
//       final response = Response(
//         data: {'patched': true},
//         statusCode: 200,
//         requestOptions: RequestOptions(path: ''),
//       );
//       when(
//         mockDio.patch('', data: anyNamed('data'), options: anyNamed('options')),
//       ).thenAnswer((_) async => response);

//       final result = await apiClient.patch(endpoint: '', body: {'foo': 'bar'});
//       expect(result, {'patched': true});
//     });

//     test('handles non-2xx status code', () async {
//       final response = Response(
//         data: {'error': 'bad'},
//         statusCode: 500,
//         requestOptions: RequestOptions(path: '/test'),
//       );
//       when(
//         mockDio.get(
//           '',
//           queryParameters: anyNamed('queryParameters'),
//           options: anyNamed('options'),
//         ),
//       ).thenAnswer((_) async => response);

//       expect(
//         () => apiClient.get(endpoint: ''),
//         throwsA(isA<Exception>()),
//       );
//     });
//   });
// }

// // Helper to inject mock Dio into ApiClient for testing
// class ApiClientTestWrapper extends ApiClient {
//   ApiClientTestWrapper(Dio dio) : super() {
//     super._dio = dio;
//   }
// }
