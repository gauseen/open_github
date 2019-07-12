class Utils {
  static String formatTime(DateTime date) {
    int diff = DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;

    const double mills = 1000.0;
    const double seconds = mills * 60.0;
    const double minutes = seconds * 60.0;
    const double hours = minutes * 60.0;
    const double days = hours * 24.0;

    if (diff < seconds) {
      return '刚刚';
    } else if (diff < minutes) {
      return (diff / seconds).round().toString() + '分钟前';
    } else if (diff < hours) {
      return (diff / minutes).round().toString() + '小时前';
    } else if (diff < days) {
      return (diff / hours).round().toString() + '天前';
    } else {
      return date.toString();
    }
  }
}
