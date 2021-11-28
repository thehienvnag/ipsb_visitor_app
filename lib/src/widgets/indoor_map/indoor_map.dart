import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/widgets/image_view/image_view.dart';

import 'package:ipsb_visitor_app/src/widgets/indoor_map/indoor_map_controller.dart';

class IndoorMap extends GetView<IndoorMapController> {
  /// Provide a provider of image for display
  final String? imageUrl;

  /// Is loading status
  final bool isLoading;

  /// Loading placehoder widget
  final Widget loadingWidget;

  /// Loading placehoder widget
  final Widget errorWidget;
  IndoorMap({
    required this.imageUrl,
    required this.errorWidget,
    required this.isLoading,
    required this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) return loadingWidget;
    if (imageUrl == null) return errorWidget;
    final screenSize = MediaQuery.of(context).size;
    final image = CachedNetworkImageProvider(imageUrl!);
    controller.screenSize.value = screenSize;
    return FutureBuilder<ui.Image>(
      future: controller.getImage(image),
      builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return Obx(() {
            return Transform.rotate(
              angle: controller.rotateAngle.value,
              child: InteractiveViewer(
                maxScale: 1,
                minScale: 0.1,
                constrained: false,
                transformationController: controller.transformationController,
                child: ImageView(
                  width: data.width.toDouble(),
                  height: data.height.toDouble(),
                  image: image,
                ),
              ),
            );
          });
        } else if (snapshot.hasError) {
          return errorWidget;
        } else {
          return loadingWidget;
        }
      },
    );
  }
}
