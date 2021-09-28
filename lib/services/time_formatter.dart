import 'package:intl/intl.dart';

String formatTimeSecond(DateTime dateTime) {
  return DateFormat('ss').format(dateTime);
}

String formatTimeHour(DateTime dateTime) {
  return DateFormat('h').format(dateTime);
}

String formatTimeMinute(DateTime dateTime) {
  return DateFormat('mm').format(dateTime);
}

String formatTimeHourMin(DateTime dateTime) {
  return DateFormat('hh:mm a').format(dateTime);
}

String formatDay(DateTime dateTime) {
  return DateFormat('EEEE').format(dateTime);
}

String formatDate(DateTime dateTime) {
  return DateFormat('dd MMMM').format(dateTime);
}
