import 'package:indoor_positioning_visitor/src/common/constants.dart';

class Node<T> {
  /// Node id
  final int? id;

  Node({this.id, this.value});

  final T? value;

  /// Initial distance for node
  double distance = Constants.infiniteDistance;

  ///
  final Map<Node, double> adjacents = {};

  ///
  List<Node> shortestPath = [];

  /// Add a destination for current node with id of destination node [destId]
  /// and distance from current node to destination node [distance]
  void addDestination(Node destNode, double distance) {
    adjacents.putIfAbsent(destNode, () => distance);
  }

  @override
  String toString() {
    return 'id: $id, distance: $distance \n';
  }
}
