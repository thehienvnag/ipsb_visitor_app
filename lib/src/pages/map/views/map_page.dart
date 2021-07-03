import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/floor_plan.dart';
import 'package:indoor_positioning_visitor/src/pages/map/controllers/map_controller.dart';
import 'package:indoor_positioning_visitor/src/utils/formatter.dart';
import 'package:indoor_positioning_visitor/src/utils/utils.dart';
import 'package:indoor_positioning_visitor/src/widgets/custom_bottom_bar.dart';
import 'package:indoor_positioning_visitor/src/widgets/custom_search_bar.dart';
import 'package:indoor_positioning_visitor/src/widgets/indoor_map/indoor_map.dart';
import 'package:indoor_positioning_visitor/src/widgets/rounded_button.dart';
import 'package:indoor_positioning_visitor/src/widgets/ticket_box.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MapPage extends GetView<MapController> {
  final double tabBarHeight = 80;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            buildMap(),
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
        if (controller.searchValue.isEmpty) {
          return Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(left: 30, bottom: 10),
            width: screenSize.width,
            child: Row(
              children: [
                ElevatedButton(
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
                  child: Icon(Icons.card_giftcard_sharp, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    primary: Colors.blue,
                    onPrimary: Colors.red,
                  ),
                ),
                ElevatedButton(
                  onPressed: () => controller.testLocationChange(),
                  child: Icon(Icons.run_circle, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                    primary: Colors.blue,
                    onPrimary: Colors.red,
                  ),
                ),
              ],
            ),
          );
        }
        return SizedBox();
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

  Widget buildStorePanel({required Widget child, required double height}) {
    return SlidingUpPanel(
      controller: controller.storePanelController,
      isDraggable: false,
      minHeight: 0,
      maxHeight: height,
      defaultPanelState: PanelState.CLOSED,
      panelBuilder: (scrollController) => Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Kết quả tìm kiếm',
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  ),
                  RoundedButton(
                    onPressed: () {
                      controller.storePanelController.close();
                      controller.changeVisible();
                    },
                    radius: 30,
                    icon: Icon(Icons.close),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                var listStore = controller.listStore;
                if (listStore.isEmpty) {
                  return Container(
                    child: Text('No place found!'),
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: listStore.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final store = listStore[index];
                    final floorPlan = store.floorPlan;
                    return GestureDetector(
                      onTap: () {},
                      child: Card(
                        child: Column(
                          children: [
                            Container(
                              width: 383,
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                image: Utils.resolveDecoImg(
                                  store.imageUrl,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                            ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    Formatter.shorten(store.name).toUpperCase(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    'Tầng: ${Formatter.shorten(floorPlan?.floorCode).toUpperCase()}',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ],
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Formatter.shorten(store.description, 80),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: Icon(Icons.store),
                                        label: Text('Xem thông tin'),
                                      ),
                                      OutlinedButton(
                                        onPressed: () {},
                                        child: Icon(
                                          Icons.directions,
                                          size: 32,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // ListTile(
                      //   leading: Utils.resolveImg(
                      //     store.imageUrl,
                      //     fit: BoxFit.fitHeight,
                      //     width: 50,
                      //   ),
                      //   title: Text(Formatter.shorten(store.name)),
                      //   subtitle: Text(
                      //     Formatter.shorten(store.description, 80),
                      //   ),
                      //   trailing: OutlinedButton(
                      //     onPressed: () {},
                      //     child: Icon(
                      //       Icons.directions,
                      //       size: 26,
                      //     ),
                      //   ),
                      // ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      body: child,
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
