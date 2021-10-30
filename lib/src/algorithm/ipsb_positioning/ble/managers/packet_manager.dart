import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/filters/kalman_filter_1d.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/packet.dart';

mixin IPacketManager {
  /// Add new advertising packets
  void addPacket(int rssi, int timeStamp);

  /// Remove old advertising packets
  void removeOldPackets();

  /// Remove first
  void removeFirst();

  /// remove all
  void removeAll();

  /// Not empty
  bool isNotEmpty();

  /// Get list rssi
  Iterable<double> getListRssi();
}

class PacketManager implements IPacketManager {
  final List<Packet> _packets = [];
  final f = KalmanFilter1d();

  @override
  void addPacket(int rssi, int timeStamp) {
    _packets.add(Packet(
      rssi: f.filter(rssi),
      timeStamp: timeStamp,
    ));
  }

  @override
  void removeOldPackets() {
    _packets.removeWhere((element) => element.isOld());
  }

  @override
  Iterable<double> getListRssi() {
    return _packets.map((e) => e.rssi.toDouble());
  }

  @override
  void removeFirst() {
    _packets.removeAt(0);
  }

  @override
  bool isNotEmpty() {
    return _packets.isNotEmpty;
  }

  @override
  void removeAll() {
    _packets.clear();
  }
}
