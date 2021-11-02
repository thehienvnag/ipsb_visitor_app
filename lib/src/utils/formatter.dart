import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class Formatter {
  static String date(DateTime? date, [String formatter = 'dd-MM-yyyy']) {
    if (date == null) return 'Date not set';
    return DateFormat(formatter).format(date);
  }

  static String shorten(String? s, [int n = 30]) {
    if (s == null) {
      return '';
    }
    if (s.length < n) {
      return s;
    }
    var cut = s.indexOf(' ', n);
    if (cut == -1) return s;
    return s.substring(0, cut) + ' ...';
  }

  static String price(double? price, [String currency = "VNĐ"]) {
    final formatter = new NumberFormat("###,###,###,###");
    return formatter.format(price) + ' $currency';
  }

  static String amount(double? amount, String? discountType,
      [String currency = "VNĐ"]) {
    if (amount == null || discountType == null) {
      return '';
    }
    if (discountType == Constants.discountTypeFixed) {
      final formatter = new NumberFormat("###,###,###,###");
      return '-' + formatter.format(amount) + ' $currency';
    }
    final formatter = new NumberFormat("###");
    return '-' + formatter.format(amount) + '%';
  }

  static String dateCaculator(DateTime? date){
    if (date == null) {
      return "";
    }
    int differenceInDays = new DateTime.now().difference(DateTime.parse(date.toString())).inHours;
    final fifteenAgo = new DateTime.now().subtract(new Duration(hours: differenceInDays));
    return timeago.format(fifteenAgo, locale: 'en');
  }
}
