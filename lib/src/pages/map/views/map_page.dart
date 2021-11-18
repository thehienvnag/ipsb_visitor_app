import 'package:animated_floating_buttons/widgets/animated_floating_action_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/models/floor_plan.dart';
import 'package:ipsb_visitor_app/src/pages/map/controllers/map_controller.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';
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
            controller.sharedData.building.value.id != null
                ? buildMap()
                : buildErrorMap(
                    title: 'Oops! Can not load map',
                    description:
                        'You may not be in a building existing in our system.',
                  ),
            controller.sharedData.building.value.id != null
                ? Container(
                    height: 95,
                    decoration: BoxDecoration(
                      boxShadow: [AppBoxShadow.boxShadowLight],
                      color: Colors.white,
                    ),
                  )
                : Container(
                    height: 55,
                    decoration: BoxDecoration(
                      boxShadow: [AppBoxShadow.boxShadowLight],
                      color: Colors.white,
                    ),
                  ),
            Obx(() {
              return Container(
                margin: const EdgeInsets.only(top: 5),
                child: UserWelcome(
                  textColor: Colors.black,
                  currentPosition: controller.currentAddress.value,
                ),
              );
            }),
            controller.sharedData.building.value.id != null
                ? Obx(
                    () => MapSearchBar(
                      items: controller.listFloorPlan,
                      selected: controller.selectedFloor.value,
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
      floatingActionButton: controller.sharedData.building.value.id != null
          ? getFloatingButton(context)
          : SizedBox(),
      bottomNavigationBar: getBottomNavBar(),
      bottomSheet: determineBottomSheet(context),
    );
  }

  Widget buildErrorMap({required String title, required String description}) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 100),
            height: 200,
            width: 200,
            child: Image.asset(ConstImg.error),
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
                color: Colors.red,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15),
            width: 320,
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBottomNavBar() {
    return CustomBottombar();
    // return Obx(() {
    //   if (controller.shoppingListVisble.isTrue ||
    //       controller.directionBottomSheet.isTrue) {
    //     return Container(
    //       height: 0,
    //     );
    //   }
    //   return CustomBottombar();
    // });
  }

  Widget determineBottomSheet(BuildContext context) {
    return Obx(() {
      if (controller.directionBottomSheet.isTrue) {
        return getRouteDirectionBottomSheet(context);
      }
      if (controller.shoppingListVisble.isTrue) {
        return getShoppingListBottomSheet(context);
      }
      return Container(height: 0);
    });
  }

  Widget getRouteDirectionBottomSheet(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Obx(() {
      final data = controller.getDirectionDetails(
        controller.destPosition.value,
        controller.distanceToDest.value,
      );
      return Container(
        padding: const EdgeInsets.only(top: 10),
        width: screenSize.width,
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [AppBoxShadow.boxShadowLight],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "DIRECTIONS",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                IconButton(
                  onPressed: () => controller.closeDirectionMenu(),
                  icon: Icon(Icons.close_rounded),
                ),
              ],
            ),
            ListTile(
              leading: GestureDetector(
                onTap: () => controller.testLocationChange(),
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: Utils.resolveDecoImg(data?["imageUrl"]),
                  ),
                ),
              ),
              title: Text(
                data?["title"] ?? "",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                Formatter.distanceFormat(data?["distanceTo"], unit: "meter"),
              ),
              trailing: controller.isShowingDirection.value == true
                  ? OutlinedButton.icon(
                      onPressed: () => controller.stopDirection(),
                      icon: Icon(Icons.stop, color: Colors.redAccent, size: 30),
                      label: Text(
                        "Exit",
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    )
                  : OutlinedButton.icon(
                      onPressed: () => controller.startShowDirection(),
                      icon: Icon(Icons.arrow_right, size: 30),
                      label: Text("Start"),
                    ),
            ),
          ],
        ),
      );
    });
  }

  Widget getShoppingListBottomSheet(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Obx(() {
      final shoppingList = controller.sharedData.shoppingList.value;
      return Container(
        height: controller.sharedData.startShopping.isTrue ? 90 : 210,
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
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  subtitle:
                      Text(Formatter.shorten(shoppingList.building?.name, 30)),
                  trailing: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: IconButton(
                      onPressed: () => controller.closeShopping(),
                      icon: controller.isShoppingComplete() &&
                              controller.sharedData.startShopping.isTrue
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
            if (!controller.sharedData.startShopping.isTrue)
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
  }

  Widget getFloatingButton(BuildContext context) {
    return OutlinedButton(
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
    );
    // return Obx(() {
    //   if (controller.shoppingListVisble.isTrue ||
    //       controller.directionBottomSheet.isTrue) {
    //     return Container(
    //       height: 0,
    //     );
    //   }
    //   return AnimatedFloatingActionButton(
    //     fabButtons: <Widget>[
    //       // OutlinedButton(
    //       //   style: OutlinedButton.styleFrom(
    //       //     shape: CircleBorder(
    //       //         // side: BorderSide(color: Colors.purpleAccent, width: 2),
    //       //         ),
    //       //     padding: EdgeInsets.all(12),
    //       //     backgroundColor: Colors.white,
    //       //   ),
    //       //   onPressed: () => controller.testLocationChange(),
    //       //   child: Icon(
    //       //     Icons.directions,
    //       //     color: AppColors.primary,
    //       //     size: 30,
    //       //   ),
    //       // )
    //     ],
    //     key: key,
    //     colorStartAnimation: AppColors.primary,
    //     colorEndAnimation: Colors.pinkAccent,
    //     animatedIconData: AnimatedIcons.menu_close,
    //   );
    // });
  }

  Widget buildMap() {
    return Center(
      child: Obx(() {
        FloorPlan floorplan = controller.selectedFloor.value;
        return IndoorMap(
          imageUrl: floorplan.imageUrl,
          isLoading: controller.isLoading.value,
          loadingWidget: CircularProgressIndicator(),
          errorWidget: buildErrorMap(
            title: 'Oops! Can not load map',
            description: 'Error in loading map image.',
          ),
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
