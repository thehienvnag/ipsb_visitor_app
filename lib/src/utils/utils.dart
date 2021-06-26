import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:indoor_positioning_visitor/src/common/constants.dart';

class Utils {
  static double calDistance(Offset p1, Offset p2) {
    var xSquare = pow(p2.dx - p1.dx, 2);
    var ySquare = pow(p2.dy - p1.dy, 2);
    return sqrt(xSquare + ySquare);
  }

  static Image resolveImg(String? url) {
    if (url == null) {
      return Image.asset(Constants.imageErr);
    }
    return Image(
      image: NetworkImage(url),
      errorBuilder: (context, error, stackTrace) =>
          Image.asset(Constants.imageErr),
    );
  }

  static DecorationImage resolveDecoImg(String? url) {
    if (url == null) {
      return DecorationImage(image: AssetImage(Constants.imageErr));
    }
    return DecorationImage(
      onError: (exception, stackTrace) => Image.asset(Constants.imageErr),
      image: NetworkImage(url),
      fit: BoxFit.cover,
    );
  }

  static ImageProvider getServiceImage(int? locationTypeId) {
    ImageProvider imageProvider = AssetImage(MapValue.stairCase);

    switch (locationTypeId) {
      case MapKey.elevator:
        imageProvider = AssetImage(MapValue.elevator);
        break;
      case MapKey.restRoom:
        imageProvider = AssetImage(MapValue.restRoom);
        break;
    }
    return imageProvider;
  }
}
