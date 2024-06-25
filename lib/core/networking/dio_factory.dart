import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:moveassist/core/utils/constants/string_constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final getIt = GetIt.instance;

class DioFactory {
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;
      addDioInterceptor(dio!);
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioInterceptor(Dio dioInstance) {
    dioInstance.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
      ),
    );

    dioInstance.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer ${StringConstants.token}';
          options.headers['apikey'] = StringConstants.token;
          return handler.next(options);
        },
      ),
    );
  }
}
