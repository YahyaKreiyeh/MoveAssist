import 'package:intl/intl.dart';

class DateHelper {
  DateHelper._();
  static String formatDateWithMonth(DateTime date) {
    return DateFormat('d MMMM, yyyy').format(date);
  }

  static String formatDayName(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  static String formatDateNumbers(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date);
  }
}
