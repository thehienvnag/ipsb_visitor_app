import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/common/constants.dart';
import 'package:indoor_positioning_visitor/src/utils/formatter.dart';
import 'package:indoor_positioning_visitor/src/utils/utils.dart';

import 'package:indoor_positioning_visitor/src/widgets/image_view/image_view_controller.dart';

class MarkerPopup extends GetView<ImageViewController> {
  static const double serviceWidth = 320;
  static const double serviceHeight = 80;
  static const double storeWidth = 320;
  static const double storeHeight = 320;

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
        elevation: 7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (isStore())
              Container(
                width: storeWidth,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                    image: state.location!.retrieveStoreImg(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ListTile(
              leading: !isStore()
                  ? CircleAvatar(
                      backgroundColor: Colors.black12,
                      backgroundImage:
                          Utils.getServiceImage(state.location?.locationTypeId),
                    )
                  : null,
              title: Text(
                Formatter.shorten(determineTitle()).toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
              subtitle: Text(Formatter.shorten(determineSubtitle(), 40)),
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

  bool isStore() => state.location?.locationTypeId == MapKey.store;

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
}
