import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:com.ipsb.visitor_app/src/common/constants.dart';
import 'package:com.ipsb.visitor_app/src/models/floor_plan.dart';
import 'package:com.ipsb.visitor_app/src/pages/map/controllers/map_controller.dart';
import 'package:com.ipsb.visitor_app/src/widgets/custom_bottom_bar.dart';
import 'package:com.ipsb.visitor_app/src/widgets/custom_search_bar.dart';
import 'package:com.ipsb.visitor_app/src/widgets/indoor_map/indoor_map.dart';
import 'package:com.ipsb.visitor_app/src/widgets/ticket_box.dart';
import 'package:com.ipsb.visitor_app/src/widgets/user_welcome.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapPage extends GetView<MapController> {
  final double tabBarHeight = 80;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            buildMap(),
            Container(
              height: 95,
              decoration: BoxDecoration(
                boxShadow: [AppBoxShadow.boxShadowLight],
                color: Colors.white,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 5),
              child: UserWelcome(
                textColor: Colors.black,
              ),
            ),
            Obx(
              () => MapSearchBar(
                items: controller.listFloorPlan,
                selected: controller.selectedFloor.value,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(() {
        if (!controller.isCouponBtnVisible.value) {
          return Container();
        }
        return AnimatedFloatingActionButton(
            fabButtons: <Widget>[
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(15),
                  backgroundColor: Colors.white,
                ),
                onPressed: () {
                  controller.changeVisible();
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    barrierColor: Colors.transparent,
                    builder: (context) {
                      return buildCouponPanel();
                    },
                  );
                },
                child: Icon(
                  Icons.local_activity_outlined,
                  color: AppColors.primary,
                  size: 30,
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: CircleBorder(
                      // side: BorderSide(color: Colors.purpleAccent, width: 2),
                      ),
                  padding: EdgeInsets.all(15),
                  backgroundColor: Colors.white,
                ),
                onPressed: () => controller.testLocationChange(),
                child: Icon(
                  Icons.directions,
                  color: AppColors.primary,
                  size: 30,
                ),
              )
            ],
            key: key,
            colorStartAnimation: AppColors.primary,
            colorEndAnimation: Colors.pinkAccent,
            animatedIconData: AnimatedIcons.menu_close //To principal button
            );
      }),
      bottomNavigationBar: CustomBottombar(),
    );
  }

  Widget buildMap() {
    return Center(
      child: Obx(() {
        FloorPlan floorplan = controller.selectedFloor.value;
        if (floorplan.imageUrl == null) {
          return Text('Loading');
        }
        return IndoorMap(
          image: NetworkImage(floorplan.imageUrl!),
          loading: Text('Loading'),
        );
      }),
    );
  }

  Widget buildCouponPanel() {
    return SlidingUpPanel(
      onPanelClosed: () {
        controller.changeVisible();
        Get.back();
      },
      border: Border.all(width: 0.6),
      defaultPanelState: PanelState.OPEN,
      controller: controller.couponPanelController,
      maxHeight: 190,
      color: Colors.white,
      backdropOpacity: 0,
      backdropEnabled: false,
      boxShadow: [],
      panelBuilder: (scrollController) => Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 8,
                bottom: 12,
              ),
              width: 70,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
            Expanded(child: Obx(() {
              final listCoupon = controller.listCoupon;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: listCoupon.length,
                itemBuilder: (context, index) {
                  var coupon = listCoupon[index];
                  return GestureDetector(
                    onTap: () => controller.gotoCouponDetails(coupon),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 13,
                        vertical: 5,
                      ),
                      child: TicketBox.small(
                        storeName: coupon.store?.name,
                        imgUrl: coupon.imageUrl!,
                        description: coupon.description,
                        amount: coupon.amount,
                        expireDate: coupon.expireDate,
                        discountType: coupon.discountType,
                        name: coupon.name,
                      ),
                    ),
                  );
                },
              );
            })),
          ],
        ),
      ),
    );
  }
}
