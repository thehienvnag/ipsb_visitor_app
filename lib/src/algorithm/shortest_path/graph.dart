import 'package:ipsb_visitor_app/src/algorithm/shortest_path/node.dart';
import 'package:ipsb_visitor_app/src/models/edge.dart';
import 'package:ipsb_visitor_app/src/models/location.dart';
import 'package:ipsb_visitor_app/src/models/store.dart';
import 'package:ipsb_visitor_app/src/utils/utils.dart';

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

  List<List<Location>> getShoppingRoutes(
    int currentPosition,
    List<Store> stores,
    List<Location> Function(int, int) shortestPathSolver,
  ) {
    if (stores.isEmpty) return [];
    List<List<Location>> shoppingRoutes = [];
    final initial = shortestPathSolver(
      currentPosition,
      stores[0].location!.id!,
    );
    shoppingRoutes.add(initial);
    int i = 0;
    stores.forEach((e) {
      if (i < stores.length - 1) {
        Location p1 = e.location!;
        Location p2 = stores[++i].location!;
        final pathTo = shortestPathSolver(p1.id!, p2.id!);
        shoppingRoutes.add(pathTo);
      }
    });
    return shoppingRoutes;
  }

  /// Sort store by distance from current location to store
  void sortStoreByDistance(
    int currentPosition,
    List<Store> stores,
    List<Location> Function(int, int) shortestPathSolver,
  ) {
    stores.forEach((e) {
      if (e.complete) {
        e.distance = 0;
        return;
      }

      int endLocationId = e.location!.id!;

      // Find all shortest paths from current position to endLocationId
      final paths = shortestPathSolver.call(
        currentPosition,
        endLocationId,
      );

      // Sum of distance from all points
      int i = 0;
      double distance = 0;
      paths.forEach((e) {
        if (i < paths.length - 1) {
          distance += Utils.calDistance(e, paths[++i]);
        }
      });
      e.distance = distance;
    });
    stores.sort((a, b) => a.distance!.compareTo(b.distance!));
  }

  /// Get shopping points on floor
  static List<Store> getShoppingPoints(
    List<Store> list,
    int floorPlanId,
  ) =>
      list.where((e) => e.location?.floorPlanId == floorPlanId).toList();

  /// Get
  static List<Location> getRouteOnFloor(
    Iterable<Location> list,
    int floorPlanId,
  ) =>
      list.where((e) => e.floorPlanId == floorPlanId).toList();
}
