import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/positioning/ble_positioning.dart';
import 'package:ipsb_visitor_app/src/algorithm/ipsb_positioning/positioning/pdr_positioning.dart';

import 'fusion/data_fusion.dart';
import 'models/location_2d.dart';

class IpsbPositioning {
  static IDataFusion? _dataFusion;

  static void start<T>({
    required PdrPositioningConfig pdrConfig,
    required BlePositioningConfig bleConfig,
    required T Function(Location2d?) resultTranform,
    required Function(int) onFloorChange,
    required Function(T, void Function(Location2d)) onChange,
  }) {
    _dataFusion = DataFusion(
      onFloorChange: onFloorChange,
      onChange: (location, setCurrent) => onChange(
        resultTranform(location),
        setCurrent,
      ),
    );
    _dataFusion?.init(bleConfig: bleConfig, pdrConfig: pdrConfig);
    _dataFusion?.start();
  }

  static stop() {
    _dataFusion?.stop();
    _dataFusion = null;
  }
}
