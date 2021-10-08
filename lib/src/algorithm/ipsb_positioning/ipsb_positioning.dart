import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/fusion/data_fusion.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/models/location_2d.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/positioning/ble_positioning.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/positioning/pdr_positioning.dart';

class IpsbPositioning {
  static IDataFusion? _dataFusion;

  static void start<T>({
    required PdrPositioningConfig pdrConfig,
    required BlePositioningConfig bleConfig,
    required T Function(Location2d) resultTranform,
    required Function(T) onChange,
  }) {
    _dataFusion = DataFusion(
      onChange: (location) => onChange(resultTranform(location)),
    );
    _dataFusion?.init(bleConfig: bleConfig, pdrConfig: pdrConfig);
    _dataFusion?.start();
  }

  static stop() {
    _dataFusion?.stop();
    _dataFusion = null;
  }
}
