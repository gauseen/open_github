import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio dio = _initDio();

Dio _initDio() {
  Dio dio = new Dio();
  // new dio instance to request token
  Dio tokenDio = new Dio();
  String token;
  dio.options.baseUrl = 'https://api.github.com';
  tokenDio.options = dio.options;
  dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
    print(
        'send request：path: ${options.path}，baseURL: ${options.baseUrl}，token: ${token}');

    if (token == null) {
      print('----------- no token -----------');
      // lock the dio.
      dio.lock();
      return SharedPreferences.getInstance().then((prefs) {
        options.headers['Authorization'] =
            token = prefs.getString('authorization');

        print('token $token');
        return options;
      }).whenComplete(() => dio.unlock()); // unlock the dio
    } else {
      options.headers['Authorization'] = token;
      return options;
    }
  }, onError: (DioError error) async {
    print('----------- http error -----------');
    token = null;
    return error;
  }));

  return dio;
}
