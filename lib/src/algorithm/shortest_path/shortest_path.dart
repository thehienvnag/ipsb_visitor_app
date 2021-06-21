import 'package:indoor_positioning_visitor/src/algorithm/shortest_path/graph.dart';
import 'package:indoor_positioning_visitor/src/algorithm/shortest_path/node.dart';

mixin IShortestPath {
  /// Get shortest path from graph [graph] and source node [source]
  Graph getShortestPath(Graph graph, int destId);
}

class ShortestPath implements IShortestPath {
  @override
  Graph getShortestPath(Graph graph, int destId) {
    Node? source = graph.nodes[destId];
    if (source == null) {
      throw new Exception('No destination source found!');
    }
    return getShortestPathFromSource(graph, source);
  }

  Graph getShortestPathFromSource(Graph graph, Node source) {
    int start = DateTime.now().millisecondsSinceEpoch;
    source.distance = 0;

    Set<Node> settledNodes = {};
    Set<Node> unSettledNodes = {};

    unSettledNodes.add(source);
    while (unSettledNodes.isNotEmpty) {
      Node current = getMinDistanceNode(unSettledNodes);
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
    int end = DateTime.now().millisecondsSinceEpoch;
    print(end - start);
    return graph;
  }

  Node getMinDistanceNode(Set<Node> unSettledNodes) {
    return unSettledNodes
        .reduce((curr, next) => curr.distance < next.distance ? curr : next);
  }

  void calculateMinDistance(
    Node evaluationNode,
    double edgeDistance,
    Node sourceNode,
  ) {
    double sourceDistance = sourceNode.distance;
    if (sourceDistance + edgeDistance < evaluationNode.distance) {
      evaluationNode.distance = sourceDistance + edgeDistance;
      List<Node> shortestPath = List.from(sourceNode.shortestPath);
      shortestPath.add(sourceNode);
      evaluationNode.shortestPath = shortestPath;
    }
  }
}
