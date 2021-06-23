import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/algorithm/shortest_path/node.dart';
import 'package:indoor_positioning_visitor/src/models/location.dart';

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

  /// Svg initial
  /// // '<svg viewBox="0 0 $width $height"></svg>';
  static String initSvg(int width, int height) => '''
      <svg width="400" height="500" xmlns="http://www.w3.org/2000/svg">
       
      </svg>
    ''';

  /// Get default rx var getx controller
  static Rx<T> get<T>() {
    return (Get.arguments['defaultState'] as T).obs;
  }
}
