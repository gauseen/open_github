import '../utils/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

// 获取动态事件
Future fetchEvents({ int pageNum = 1, }) async {
  var url = await getUrlOfEvents();
  return await dio.get('$url?page=$pageNum&per_page=15').then((res) => res.data);
}

Future getUrlOfEvents() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var _username = prefs.getString('username');
  if (_username == null) {
    return '/events';
  } else {
    return '/users/$_username/received_events';
  }
}