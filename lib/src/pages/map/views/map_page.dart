import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/floor_plan.dart';
import 'package:ipsb_visitor_app/src/pages/map/controllers/map_controller.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:ipsb_visitor_app/src/utils/utils.dart';
import 'package:ipsb_visitor_app/src/widgets/custom_bottom_bar.dart';
import 'package:ipsb_visitor_app/src/widgets/custom_search_bar.dart';
import 'package:ipsb_visitor_app/src/widgets/indoor_map/indoor_map.dart';
import 'package:ipsb_visitor_app/src/widgets/ticket_box.dart';
import 'package:ipsb_visitor_app/src/widgets/user_welcome.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

class MapPage extends GetView<MapController> {
  final double tabBarHeight = 80;

  @override
  Widget build(BuildContext context) {
    // final screenSize = MediaQuery.of(context).size;
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
      floatingActionButton: getFloatingButton(context),
      bottomNavigationBar: getBottomNavBar(),
      bottomSheet: getShoppingListBottomSheet(context),
    );
  }

  Widget getBottomNavBar() {
    return Obx(() {
      final shoppingListVisible = controller.shoppingListVisble.value;
      if (shoppingListVisible) {
        return Container(
          height: 0,
        );
      }
      return CustomBottombar();
    });
  }

  Widget getShoppingListBottomSheet(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Obx(() {
      final shoppingListVisible = controller.shoppingListVisble.value;
      if (!shoppingListVisible) {
        return Container(
          height: 0,
        );
      }
      return Obx(() {
        final shoppingList = controller.sharedData.shoppingList.value;

        return Container(
          height: controller.startShopping.value ? 90 : 210,
          padding: const EdgeInsets.only(top: 10),
          // width: screenSize.width,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [AppBoxShadow.boxShadowLight],
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  ListTile(
                    leading: GestureDetector(
                      onTap: () => controller.testGoingShoppingRoutes(),
                      child: Container(
                        width: 100,
                        height: 60,
                        decoration: BoxDecoration(
                          image: Utils.resolveDecoImg(
                              shoppingList.building?.imageUrl),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                    title: Text(
                      shoppingList.name!,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    subtitle: Text(
                        Formatter.shorten(shoppingList.building?.name, 30)),
                    trailing: Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      child: IconButton(
                        onPressed: () => controller.closeShopping(),
                        icon: controller.isShoppingComplete() &&
                                controller.startShopping.isTrue
                            ? Icon(
                                Icons.check_circle_outline_outlined,
                                color: Colors.greenAccent,
                                size: 40,
                              )
                            : Icon(Icons.close),
                      ),
                    ),
                  ),
                  // if (controller.startShopping.value)
                  //   Positioned(
                  //     top: 4,
                  //     left: 16,
                  //     child: Container(
                  //       width: 100,
                  //       height: 60,
                  //       child: SpinKitWave(
                  //         color: AppColors.primary.withOpacity(0.9),
                  //         type: SpinKitWaveType.start,
                  //       ),
                  //       decoration: BoxDecoration(
                  //         color: Colors.black38,
                  //         borderRadius: BorderRadius.circular(5),
                  //       ),
                  //     ),
                  //   ),
                ],
              ),
              if (!controller.startShopping.value)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: screenSize.width * 0.6,
                        height: 40,
                        child: Wrap(
                          runSpacing: 0,
                          spacing: 0,
                          runAlignment: WrapAlignment.start,
                          direction: Axis.horizontal,
                          children: [
                            Text(
                              'Shopping items:',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ...shoppingList.shoppingItems!
                                .map(
                                  (e) => Chip(
                                    label: Text(
                                      Formatter.shorten(e.product!.name!, 15),
                                    ),
                                  ),
                                )
                                .take(2)
                                .toList(),
                            if (shoppingList.shoppingItems!.length > 2)
                              Chip(label: Text("...")),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            style: OutlinedButton.styleFrom(
                              primary: AppColors.secondary,
                            ),
                            onPressed: () => controller.beginShopping(),
                            child: Text(
                              ' BEGIN  ',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: Colors.black54,
                            ),
                            onPressed: () => controller.closeShopping(),
                            child: Text('CANCEL'),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
            ],
          ),
        );
      });
    });
  }

  Widget getFloatingButton(BuildContext context) {
    return Obx(() {
      final shoppingListVisible = controller.shoppingListVisble.value;
      if (shoppingListVisible) {
        return Container(
          height: 0,
        );
      }
      return AnimatedFloatingActionButton(
        fabButtons: <Widget>[
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              shape: CircleBorder(),
              padding: EdgeInsets.all(12),
              backgroundColor: Colors.white,
            ),
            onPressed: () {
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
              padding: EdgeInsets.all(12),
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
        animatedIconData: AnimatedIcons.menu_close,
      );
    });
  }

  Widget buildMap() {
    return Center(
      child: Obx(() {
        FloorPlan floorplan = controller.selectedFloor.value;
        if (floorplan.imageUrl == null) {
          return CircularProgressIndicator();
        }
        return IndoorMap(
          image: CachedNetworkImageProvider(floorplan.imageUrl!),
          loading: CircularProgressIndicator(),
        );
      }),
    );
  }

  Widget buildCouponPanel() {
    return SlidingUpPanel(
      onPanelClosed: () {
        // controller.changeVisible();
        Get.back();
      },
      border: Border.all(width: 0.6, color: Colors.grey),
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
                        width: MediaQuery.of(context).size.width * 0.9,
                        storeName: coupon.store?.name,
                        imgUrl: coupon.imageUrl!,
                        description: coupon.description,
                        amount: coupon.amount,
                        expireDate: coupon.expireDate,
                        couponTypeId: coupon.couponTypeId,
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
