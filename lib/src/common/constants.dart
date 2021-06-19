import 'package:indoor_positioning_visitor/src/algorithm/shortest_path/graph.dart';
import 'package:indoor_positioning_visitor/src/algorithm/shortest_path/node.dart';
import 'package:indoor_positioning_visitor/src/models/location.dart';
import 'package:indoor_positioning_visitor/src/models/paging.dart';

class Constants {
  static final String baseUrl = "https://ipsb.azurewebsites.net/";
  static final Duration timeout = Duration(seconds: 20);
  static const Map<String, dynamic> defaultPagingQuery = {
    'page': '1',
    'pageSize': '20'
  };

  /// Initial value for emptyMap
  static const Map<String, dynamic> emptyMap = {};

  /// Initial value for empty Node Map
  static const Map<int, Node> emptyNodeMap = {};

  /// Initial value for empty set of locations
  static const Set<Location> emptySetLocation = {};

  /// Infinite distance for node
  static const double infiniteDistance = double.infinity;

  /// Default paging instance
  static final Paging defaultPaging = Paging();

  /// Default Graph instance
  static final Graph defaultGraph = Graph();
}
