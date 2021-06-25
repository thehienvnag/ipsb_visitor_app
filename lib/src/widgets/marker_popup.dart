import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:indoor_positioning_visitor/src/widgets/image_view/image_view_controller.dart';
import 'package:indoor_positioning_visitor/src/widgets/place_object.dart';

class MarkerPopup extends GetView<ImageViewController> {
  static const int stairCase = 1;
  static const int elevator = 2;
  static const int store = 3;
  static const double serviceWidth = 320;
  static const double serviceHeight = 80;
  static const double storeWidth = 320;
  static const double storeHeight = 120;

  final PopupState state;

  MarkerPopup({
    Key? key,
    required this.state,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: determineWidth(),
      height: determineHeight(),
      child: Card(
        elevation: 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.black12,
                backgroundImage: determineImg(state.location?.locationTypeId),
              ),
              title: Text(determineTitle() ?? ''),
              subtitle: Text(determineSubtitle() ?? ''),
              trailing: IconButton(
                onPressed: () => controller.closePopup(state.popupType),
                icon: Icon(Icons.close),
              ),
            ),
            if (isStore())
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.store),
                      label: Text('Xem thông tin'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.directions,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  bool isStore() => state.location?.locationTypeId == store;

  double determineWidth() {
    if (isStore()) return storeWidth;
    return serviceWidth;
  }

  double determineHeight() {
    if (isStore()) return storeHeight;
    return serviceHeight;
  }

  String? determineTitle() {
    if (isStore()) {
      return state.location?.store?.name;
    }
    return state.location?.locationType?.name;
  }

  String? determineSubtitle() {
    if (isStore()) {
      return state.location?.store?.description;
    }
    return state.location?.locationType?.description;
  }

  ImageProvider? determineImg(int? type) {
    switch (type) {
      case stairCase:
        return AssetImage(PlaceConstants.stairCase);
      case elevator:
        return AssetImage(PlaceConstants.elevator);
      case store:
        return state.location?.retrieveStoreImg();
    }
    return AssetImage(PlaceConstants.stairCase);
  }
}
