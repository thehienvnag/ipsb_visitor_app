import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/pages/map/controllers/map_controller.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:ipsb_visitor_app/src/utils/utils.dart';

import 'package:ipsb_visitor_app/src/widgets/image_view/image_view_controller.dart';

class MarkerPopup extends GetView<ImageViewController> {
  static const double serviceWidth = 260;
  static const double serviceHeight = 160;
  static const double storeWidth = 260;
  static const double storeHeight = 240;

  final PopupState state;
  final MapController homeController = Get.find();

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (isStore())
              Container(
                width: storeWidth,
                height: 110,
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
              subtitle: Text(
                determineSubtitle(),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (isStore())
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        primary: const Color(0xff344CDD),
                      ),
                      onPressed: () => Get.toNamed(Routes.storeDetails,
                          parameters: {
                            'id': state.location!.storeId.toString()
                          }),
                      icon: Icon(Icons.store),
                      label: Text('Details'),
                    ),
                  ),
                if (!isStore()) Container(),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: OutlinedButton(
                    onPressed: () =>
                        homeController.openDirectionMenu(state.location?.id),
                    child: Icon(
                      Icons.directions,
                      size: 32,
                      color: const Color(0xff344CDD),
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

  String determineSubtitle() {
    String? value;
    int shorten = 20;
    if (isStore()) {
      value = state.location?.store?.description;
    } else {
      shorten = 70;
      value = state.location?.locationType?.description;
    }
    return Formatter.shorten(value, shorten);
  }
}
