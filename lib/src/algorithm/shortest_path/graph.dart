import 'package:indoor_positioning_visitor/src/algorithm/shortest_path/node.dart';
import 'package:indoor_positioning_visitor/src/models/edge.dart';

class GraphBuilder {
  static Graph buildGraph(List<Edge> edges) {
    Graph graph = Graph();
    edges.forEach((edge) {
      graph.addNodesFromEdge(edge);
    });
    return graph;
  }
}

class Graph {
  final Map<int, Node> nodes = {};
  Graph.from(List<Edge> edges) {
    edges.forEach((edge) {
      addNodesFromEdge(edge);
    });
  }
  Graph();

  /// Add nodes to graph from [edge]
  void addNodesFromEdge(Edge edge) {
    Node? from = nodes[edge.fromLocationId] ?? Node(id: edge.fromLocationId);
    Node? to = nodes[edge.toLocationId] ?? Node(id: edge.toLocationId);

    from.addDestination(to, edge.distance!);
    to.addDestination(from, edge.distance!);

    nodes.putIfAbsent(edge.fromLocationId!, () => from);
    nodes.putIfAbsent(edge.toLocationId!, () => to);
  }

  List<Node> getPathFrom(int id) {
    return nodes[id]?.shortestPath.reversed.toList() ?? [];
  }
}
