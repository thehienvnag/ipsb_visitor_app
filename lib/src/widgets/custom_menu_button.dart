import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/pages/map/controllers/map_controller.dart';
import 'package:menu_button/menu_button.dart';

import 'package:ipsb_visitor_app/src/models/floor_plan.dart';

class CustomMenuButton extends GetView<MapController> {
  final FloorPlan? selected;

  final List<FloorPlan>? items;

  CustomMenuButton({
    Key? key,
    this.selected,
    this.items,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MenuButton<FloorPlan>(
      child: normalChildButton(),
      items: items ?? [],
      itemBuilder: (value) => Container(
        height: 40,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 16),
        child: Text('Floor ${value.floorCode ?? ''}'),
      ),
      toggledChild: Container(
        child: normalChildButton(),
      ),
      onItemSelected: (value) {
        controller.changeFloor(value.id!);
      },
      // onMenuButtonToggle: (bool isToggle) {},
    );
  }

  Widget normalChildButton() {
    return SizedBox(
      width: 100,
      height: 35,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.map_rounded,
              color: AppColors.primary,
            ),
            Flexible(
              child: Text(
                'Floor ${selected?.floorCode ?? ''}',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
