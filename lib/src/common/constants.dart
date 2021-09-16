import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/location.dart';

class Constants {
  /// Location type is lift
  static const int locationTypeLift = 3;

  /// Location type is stair
  static const int locationTypeStair = 4;

  /// Base url for calling api
  static final String baseUrl = "https://ipsb.azurewebsites.net/";

  /// Timeout when calling API
  static final Duration timeout = Duration(seconds: 20);

  /// Default query of paging parameters
  static const Map<String, dynamic> defaultPagingQuery = {
    'page': '1',
    'pageSize': '20'
  };

  /// Initial value for emptyMap
  static const Map<String, dynamic> emptyMap = {};

  /// Initial value for empty set of locations
  static const Set<Location> emptySetLocation = {};

  /// Infinite distance for node
  static const double infiniteDistance = double.infinity;

  /// Get default rx var getx controller
  static Rx<T> get<T>() {
    return (Get.arguments['defaultState'] as T).obs;
  }

  /// Default image
  static const String imageErr = "assets/images/error.png";

  static const String pin = "assets/images/pin.png";

  static const String discountTypeFixed = "Fixed";
  static const String discountTypePercentage = "Percentage";
}

class Fonts {
  static const String montserrat = "Montserrat";
}

class AppBoxShadow {
  static BoxShadow boxShadow = BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 1,
    blurRadius: 7,
    offset: Offset(0, 2), // changes position of shadow
  );
  static BoxShadow boxShadowLight = BoxShadow(
    color: Colors.grey.withOpacity(0.5),
    spreadRadius: 1,
    blurRadius: 7,
    offset: Offset(0, 1), // changes position of shadow
  );
}

class AppColors {
  static const Color primary = const Color(0xffFF6F66);
  static const Color secondary = const Color(0xffA48EAA);
  static const Color colorBlue = const Color(0xff64B0E7);
  static const List<Color> gradientColor = [
    Color(0xff64B0E7),
    Color(0xff64B0E7)
  ];
  // static const List<Color> gradientColor =  [Color(0xff775FEA), Color(0xff324CDA)];
}

class StorageConstants {
  static const floorPlanBox = "floorPlanBox";
  static const edgeBox = "edgeBox";
}

class MapKey {
  static const int stairCase = 4;
  static const int elevator = 3;
  static const int restRoom = 10;
  static const int store = 1;
  static const double radius = 18;
}

class ConstImg {
  static const String stairCase = "assets/images/staircase.png";
  static const String elevator = "assets/images/elevator.png";
  static const String restRoom = "assets/images/toilet.png";
  static const String couponSaved = "assets/images/saved.svg";
  static const String couponExpired = "assets/images/expired.svg";
}

class AppHiveType {
  static const int location = 0;
  static const int locationType = 1;
  static const int floorPlan = 2;
  static const int edge = 3;
  static const int store = 4;
  static const int storageListEdge = 5;
}
