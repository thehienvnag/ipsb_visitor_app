import 'package:intl/intl.dart';

class Formatter {
  static String dateFormat(DateTime? date) {
    if (date == null) return 'Date not set';
    return DateFormat('dd-MM-yyyy').format(date);
  }
}
