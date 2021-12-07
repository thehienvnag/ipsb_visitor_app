import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/filters/kalman_filter_1d.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/packet.dart';

mixin IPacketManager {
  /// Add new advertising packets
  void addPacket(int rssi, int timeStamp);

  /// remove all
  void removeAll({bool spareOne: false});

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
  Iterable<double> getListRssi() {
    return _packets.map((e) => e.rssi.toDouble());
  }

  @override
  bool isNotEmpty() {
    return _packets.isNotEmpty;
  }

  @override
  void removeAll({bool spareOne = false}) {
    if (_packets.isNotEmpty) {
      final last = _packets.last;
      _packets.clear();
      if (spareOne) {
        _packets.add(last);
      }
    }
  }
}
