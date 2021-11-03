import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:ipsb_visitor_app/src/pages/building_details/controllers/building_detail_controller.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:ipsb_visitor_app/src/widgets/rounded_button.dart';

class BuildingDetailPage extends GetView<BuildingDetailController> {
  final SharedStates sharedData = Get.find();

  // MapUtils.openMap(currentAddress, booking.endAddress);

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: Obx(() {
        final buildingSelected = controller.building.value;
        if (buildingSelected.id == null) {
          return Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image.network(buildingSelected.imageUrl ?? ''),
                  Container(
                    margin: EdgeInsets.only(top: 50),
                    width: screenSize.width,
                    alignment: Alignment.topLeft,
                    child: RoundedButton(
                      radius: 35,
                      color: Colors.grey.shade400,
                      icon: Icon(
                        Icons.chevron_left_rounded,
                        color: Colors.white,
                        size: 35,
                      ),
                      onPressed: () {
                        Get.back(closeOverlays: true);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: screenSize.height * 0.25, left: 7, right: 7),
                    width: screenSize.width,
                    child: Card(
                      shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 7),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenSize.width * 0.7,
                                  child: Text(
                                    buildingSelected.name ?? 'Loading',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              'Shopping mall',
                              style: TextStyle(fontSize: 16),
                            ),
                            // Container(
                            //   margin: const EdgeInsets.only(top: 8),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text(
                            //         'Mở cửa 9:30',
                            //         style: TextStyle(
                            //             fontSize: 16, color: Colors.blueAccent),
                            //       ),
                            //       Text(
                            //         '  Đóng cửa 22:30',
                            //         style: TextStyle(
                            //             fontSize: 16, color: Colors.blueAccent),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            Container(
                              width: screenSize.width,
                              height: 120,
                              child: Card(
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                color: Colors.white70,
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          Formatter.shorten(
                                              buildingSelected.address, 60),
                                          style: TextStyle(fontSize: 17),
                                        ),
                                      ),
                                      TextButton(
                                        child: Text(
                                          "View Map >>",
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontSize: 16),
                                        ),
                                        onPressed: () {
                                          MapUtils.openMap(
                                              controller.currentAddress.value,
                                              buildingSelected.address
                                                  .toString());
                                        },
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Stores',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        controller.goToBuildingStoreDetails(
                                            buildingSelected.id);
                                      },
                                      child: Text(
                                        'View more >>',
                                        style: TextStyle(fontSize: 15),
                                      ))
                                ],
                              ),
                            ),
                            Obx(() {
                              var listStore = controller.listStore;
                              int storeCount =
                                  listStore.length > 9 ? 9 : listStore.length;
                              if (listStore.isEmpty) {
                                return Center(
                                  child: Text('No data'),
                                );
                              }
                              return Container(
                                width: screenSize.width,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 9,
                                  horizontal: 10,
                                ),
                                child: Obx(() {
                                  var listStore = controller.listStore;
                                  return Wrap(
                                    alignment: WrapAlignment.spaceBetween,
                                    spacing: 15,
                                    children:
                                        List.generate(storeCount, (index) {
                                      final store = listStore[index];
                                      return GestureDetector(
                                        onTap: () => controller
                                            .goToStoreDetails(store.id),
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 3, bottom: 15),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 2, vertical: 2),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black12,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    width: 60,
                                                    height: 60,
                                                    child: Image.network(
                                                      store.imageUrl ?? '',
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: 10),
                                                    width: 100,
                                                    height: 35,
                                                    child: Text(
                                                      store.name ?? '',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  );
                                }),
                              );
                            }),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 50),
            ],
          ),
        );
      }),
    );
  }
}
