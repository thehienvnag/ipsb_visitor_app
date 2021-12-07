class Packet {
  final double rssi;
  final int timeStamp;

  Packet({
    required this.rssi,
    required this.timeStamp,
  });

  String toString() {
    return rssi.toString();
  }
}
