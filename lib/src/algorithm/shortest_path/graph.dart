import 'package:visitor_app/src/algorithm/shortest_path/node.dart';
import 'package:visitor_app/src/models/edge.dart';
import 'package:visitor_app/src/models/location.dart';

class Graph {
  final Map<int, Node<Location>> nodes = {};
  Graph.from(List<Edge> edges) {
    edges.forEach((edge) {
      addNodesFromEdge(edge);
    });
  }
  Graph();

  /// Add nodes to graph from [edge]
  void addNodesFromEdge(Edge edge) {
    Node<Location>? from = nodes[edge.fromLocationId] ??
        Node(id: edge.fromLocationId, value: edge.fromLocation);
    Node<Location>? to = nodes[edge.toLocationId] ??
        Node(id: edge.toLocationId, value: edge.toLocation);

    from.addDestination(to, edge.distance!);
    to.addDestination(from, edge.distance!);

    nodes.putIfAbsent(edge.fromLocationId!, () => from);
    nodes.putIfAbsent(edge.toLocationId!, () => to);
  }

  List<Node> getPathFrom(int id) {
    Node? findNode = nodes[id];
    findNode?.shortestPath.add(findNode);
    return findNode?.shortestPath.reversed.toList() ?? [];
  }

  double getDistance(int id) {
    return nodes[id]?.distance ?? 0;
  }

  List<Location> getShortestPath(int beginLocationId) {
    final nodeToFind = this.nodes[beginLocationId];
    return nodeToFind?.getShortestPath() ?? [];
  }

  static List<Location> getPathOnFloor(List<Location> list, int floorPlanId) =>
      list.where((e) => e.floorPlanId == floorPlanId).toList();
}
