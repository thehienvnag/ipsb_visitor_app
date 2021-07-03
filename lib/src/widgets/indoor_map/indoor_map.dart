import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/widgets/image_view/image_view.dart';

import 'package:indoor_positioning_visitor/src/widgets/indoor_map/indoor_map_controller.dart';

class IndoorMap extends GetView<IndoorMapController> {
  /// Provide a provider of image for display
  final ImageProvider image;

  /// Loading placehoder widget
  final Widget loading;
  IndoorMap({
    required this.image,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ui.Image>(
      future: controller.getImage(image),
      builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return InteractiveViewer(
            maxScale: 1,
            minScale: 0.1,
            constrained: false,
            transformationController: TransformationController(),
            child: ImageView(
              width: data.width.toDouble(),
              height: data.height.toDouble(),
              image: image,
            ),
          );
        } else {
          return loading;
        }
      },
    );
  }
}
