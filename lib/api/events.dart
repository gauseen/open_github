import '../utils/http.dart';

// 获取动态事件
Future fetchEvents({ int pageNum = 1, }) async {
  return await dio.get('/events?page=$pageNum&per_page=15').then((res) => res.data);
}