
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:ipsb_visitor_app/src/algorithm/shortest_path/graph.dart';
import 'package:ipsb_visitor_app/src/algorithm/shortest_path/node.dart';
import 'package:ipsb_visitor_app/src/models/location.dart';
import 'package:ipsb_visitor_app/src/pages/map/views/place_not_registered_dialog.dart';

mixin IShortestPath {
  /// Get shortest path from graph [graph] and source node [source]
  Graph solve(Graph graph, int destId);
}

class ShortestPath implements IShortestPath {
  @override
  Graph solve(Graph graph, int destId) {
    Node<Location>? source = graph.nodes[destId];
    if (source == null) {
      Get.dialog(PlaceNotRegisteredDialog());
      throw new Exception('No destination source found!');
    }
    return getShortestPathFromSource(graph, source);
  }

  Graph getShortestPathFromSource(Graph graph, Node<Location> source) {
    // int start = DateTime.now().millisecondsSinceEpoch;
    source.distance = 0;

    Set<Node<Location>> settledNodes = {};
    Set<Node<Location>> unSettledNodes = {};

    unSettledNodes.add(source);
    while (unSettledNodes.isNotEmpty) {
      Node<Location> current = getMinDistanceNode(unSettledNodes);
      unSettledNodes.remove(current);

      current.adjacents.keys.forEach((adjacentNode) {
        double edgeDistance = current.adjacents[adjacentNode]!;
        if (!settledNodes.contains(adjacentNode)) {
          calculateMinDistance(adjacentNode, edgeDistance, current);
          unSettledNodes.add(adjacentNode);
        }
      });
      settledNodes.add(current);
    }
    // int end = DateTime.now().millisecondsSinceEpoch;
    // print(end - start);
    return graph;
  }

  Node<Location> getMinDistanceNode(Set<Node<Location>> unSettledNodes) {
    return unSettledNodes
        .reduce((curr, next) => curr.distance < next.distance ? curr : next);
  }

  void calculateMinDistance(
    Node<Location> evaluationNode,
    double edgeDistance,
    Node<Location> sourceNode,
  ) {
    double sourceDistance = sourceNode.distance;
    if (sourceDistance + edgeDistance < evaluationNode.distance) {
      evaluationNode.distance = sourceDistance + edgeDistance;
      List<Node<Location>> shortestPath = List.from(sourceNode.shortestPath);
      shortestPath.add(sourceNode);
      evaluationNode.shortestPath = shortestPath;
    }
  }
}
