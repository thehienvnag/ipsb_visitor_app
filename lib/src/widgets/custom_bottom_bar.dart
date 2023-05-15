import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';

class CustomBottombarController extends GetxController {
  final SharedStates states = Get.find();

  Future<void> changeSelected(int index) async {
    var routerName = items[index].route;

    Get.offAndToNamed(routerName);

    states.bottomBarSelectedIndex.value = index;
  }
}

class BottomItem extends SalomonBottomBarItem {
  final String route;
  final String text;
  final Widget icon;
  final Color color;

  BottomItem({
    required this.route,
    required this.text,
    required this.icon,
    this.color = AppColors.primary,
  }) : super(
          title: Text(text),
          icon: icon,
          selectedColor: color,
        );
}

final SharedStates states = Get.find();
final items = [
  BottomItem(
    text: 'Home',
    icon: Icon(
      Icons.home,
      size: 18,
    ),
    route: Routes.home,
  ),
  BottomItem(
    text: 'Map',
    icon: Icon(
      Icons.map,
      size: 18,
    ),
    route: Routes.map,
  ),
  BottomItem(
    text: 'My coupons',
    icon: Icon(
      Icons.local_activity,
      size: 18,
    ),
    route: Routes.myCoupon,
  ),
  BottomItem(
    text: 'Shopping',
    icon: Icon(
      Icons.shopping_cart,
      size: 18,
    ),
    route: Routes.shoppingList,
  ),
  BottomItem(
    text: 'Notification',
    icon: new Stack(
      children: <Widget>[
        new Icon(
          Icons.notifications,
          size: 18,
        ),
        // states.unreadNotification.value != 0 ?
        Obx(() {
          if (states.unreadNotification.value != 0) {
            return Positioned(
              right: 0,
              child: new Container(
                padding: EdgeInsets.all(1),
                decoration: new BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                constraints: BoxConstraints(
                  minWidth: 12,
                  minHeight: 12,
                ),
                child: Text(
                  states.unreadNotification.value.toString(),
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          } else {
            return SizedBox();
          }
        }),
      ],
    ),
    route: Routes.notifications,
  ),
];

class CustomBottombar extends GetView<CustomBottombarController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey.shade300),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 4.0,
              offset: Offset(-2, 0),
            ),
          ],
        ),
        child: SalomonBottomBar(
          currentIndex: controller.states.bottomBarSelectedIndex.value,
          onTap: (i) => controller.changeSelected(i),
          items: items,
        ),
      );
    });
  }
}
