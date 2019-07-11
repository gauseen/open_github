import 'package:dio/dio.dart';

Dio dio = _initDio();

Dio _initDio() {
  Dio dio = new Dio();
  // new dio instance to request token
  Dio tokenDio = new Dio();
  String token;
  dio.options.baseUrl = 'https://www.baidu.com/';
  tokenDio.options = dio.options;
  dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
    print('send request：path: ${options.path}，baseURL: ${options.baseUrl}');

    if (token == 't') {
      print('no token，request token firstly...');
      // lock the dio.
      dio.lock();
      return tokenDio.get('/token').then((d) {
        options.headers['token'] = token = d.data['data']['token'];
        print('request token succeed, value: ' + d.data['data']['token']);
        print(
            'continue to perform request：path:${options.path}，baseURL:${options.path}');
        return options;
      }).whenComplete(() => dio.unlock()); // unlock the dio
    } else {
      options.headers['token'] = token;
      return options;
    }
  }, onError: (DioError error) {
    // Assume 401 stands for token expired
    if (error.response?.statusCode == 401) {
      RequestOptions options = error.response.request;
      // If the token has been updated, repeat directly.
      if (token != options.headers['token']) {
        options.headers['token'] = token;
        // repeat
        return dio.request(options.path, options: options);
      }
      // update token and repeat
      // Lock to block the incoming request until the token updated
      dio.lock();
      dio.interceptors.responseLock.lock();
      dio.interceptors.errorLock.lock();
      return tokenDio.get('/token').then((d) {
        //update token
        options.headers['token'] = token = d.data['data']['token'];
      }).whenComplete(() {
        dio.unlock();
        dio.interceptors.responseLock.unlock();
        dio.interceptors.errorLock.unlock();
      }).then((e) {
        // repeat
        return dio.request(options.path, options: options);
      });
    }
    return error;
  }));

  return dio;
}
