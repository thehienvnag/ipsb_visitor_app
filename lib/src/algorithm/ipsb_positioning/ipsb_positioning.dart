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
    required Function(T, int?, void Function(Location2d)) onChange,
  }) {
    _dataFusion = DataFusion(
      onChange: (location, floorPlanId, setCurrent) => onChange(
        resultTranform(location),
        floorPlanId,
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
