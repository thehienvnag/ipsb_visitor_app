import 'package:indoor_positioning_visitor/src/common/constants.dart';

class Node<T> {
  /// Node id
  final int? id;

  Node({this.id, this.value});

  final T? value;

  /// Initial distance for node
  double distance = Constants.infiniteDistance;

  ///
  final Map<Node<T>, double> adjacents = {};

  ///
  List<Node<T>> shortestPath = [];

  /// Add a destination for current node with id of destination node [destId]
  /// and distance from current node to destination node [distance]
  void addDestination(Node<T> destNode, double distance) {
    adjacents.putIfAbsent(destNode, () => distance);
  }

  List<T> getShortestPath() =>
      shortestPath.map((e) => e.value!).toList().reversed.toList();
}
