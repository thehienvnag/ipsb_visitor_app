import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:intl/intl.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';
import 'package:timeago/timeago.dart' as timeago;

class Formatter {
  static String date(DateTime? date, [String formatter = 'dd-MM-yyyy']) {
    if (date == null) return 'Date not set';
    return DateFormat(formatter).format(date);
  }

  static String distanceFormat(
    double? distanceTo, {
    String unit = "km",
    int? buildingId,
  }) {
    if (distanceTo == null) return "";
    SharedStates states = Get.find();
    if (buildingId != null && states.building.value.id == buildingId) return "";
    return "(${distanceTo.toStringAsFixed(1)} $unit)";
  }

  static String shorten(String? s, [int n = 30, String? defaultValue = ""]) {
    if (s == null) {
      if (defaultValue == null) return "";
      s = defaultValue;
    }
    if (s.length < n) {
      return s;
    }
    var cut = s.indexOf(' ', n);
    if (cut == -1) return s;
    return s.substring(0, cut) + ' ...';
  }

  static String price(double? price, [String currency = "VND"]) {
    final formatter = new NumberFormat("###,###,###,###");
    return formatter.format(price) + ' $currency';
  }

  static String amount(double? amount, int? couponTypeId,
      [String currency = "VND"]) {
    if (amount == null || couponTypeId == null) {
      return '';
    }
    if (couponTypeId == Constants.discountTypeFixed) {
      final formatter = new NumberFormat("###,###,###,###");
      return '− ' + formatter.format(amount) + ' $currency';
    }
    final formatter = new NumberFormat("###");
    return '− ' + formatter.format(amount) + '%';
  }

  static String dateCaculator(DateTime? date) {
    if (date == null) {
      return "";
    }
    int differenceInDays =
        new DateTime.now().difference(DateTime.parse(date.toString())).inHours;
    final fifteenAgo =
        new DateTime.now().subtract(new Duration(hours: differenceInDays));
    return timeago.format(fifteenAgo, locale: 'en');
  }

  static String formatAddress(Placemark place) {
    String result = "";
    if (place.street!.isNotEmpty && !place.street!.contains("+")) {
      result += place.street! + ", ";
    } else {
      if (place.subThoroughfare!.isNotEmpty) {
        result += '${place.subThoroughfare}, ';
      }
      if (place.thoroughfare!.isNotEmpty) {
        result += ' ${place.thoroughfare}, ';
      }
    }
    if (place.subAdministrativeArea!.isNotEmpty) {
      result += '${place.subAdministrativeArea}, ';
    }
    if (place.administrativeArea!.isNotEmpty) {
      result += '${place.administrativeArea}, ';
    }
    return result.replaceFirst(RegExp("Đường"), "Str.");
  }
}
