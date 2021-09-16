import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:visitor_app/src/pages/building_details/controllers/building_detail_controller.dart';
import 'package:visitor_app/src/routes/routes.dart';
import 'package:visitor_app/src/services/global_states/shared_states.dart';
import 'package:visitor_app/src/utils/formatter.dart';
import 'package:visitor_app/src/widgets/rounded_button.dart';

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
        return Column(
          children: [
            Stack(
              children: [
                Image.network(buildingSelected.imageUrl ??
                    'http://www.vtr.org.vn/FileManager/Anh%20web%202019/Thang%2011/2130/tttmgigamall%20(3).jpg'),
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
                  margin: EdgeInsets.only(top: 200, left: 7, right: 7),
                  width: screenSize.width,
                  height: screenSize.height * 0.75,
                  child: Card(
                    shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: screenSize.width * 0.7,
                                  child: Text(
                                    buildingSelected.name ?? 'Vạn hạnh mall',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Text(
                                  '  (${buildingSelected.numberOfFloor ?? '5'} tầng)',
                                  style: TextStyle(fontSize: 17),
                                ),
                              ],
                            ),
                            Text(
                              'Trung tâm mua sắm',
                              style: TextStyle(fontSize: 16),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Mở cửa 9:30',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.blueAccent),
                                  ),
                                  Text(
                                    '  Đóng cửa 22:30',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.blueAccent),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: screenSize.width,
                              height: 120,
                              child: Card(
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(6.0),
                                ),
                                color: Colors.white70,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                                          "Xem bản đồ >>",
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
                                    'Thương Hiệu',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  GestureDetector(
                                      onTap: () {
                                        Get.toNamed(Routes.buildingStore);
                                      },
                                      child: Text(
                                        'Xem tất cả',
                                        style: TextStyle(
                                            color: Colors.blueAccent,
                                            fontSize: 15),
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
                                  child: Text('Loading'),
                                );
                              }
                              return Container(
                                margin: const EdgeInsets.symmetric(vertical: 9),
                                child: Obx(() {
                                  var listStore = controller.listStore;
                                  return SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Wrap(
                                          spacing: 15,
                                          children: List.generate(storeCount,
                                              (index) {
                                            final store = listStore[index];
                                            return GestureDetector(
                                              onTap: () => controller
                                                  .goToStoreDetails(store.id),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 3,
                                                            bottom: 10),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 2,
                                                            vertical: 2),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Colors.black12),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: 60,
                                                          height: 60,
                                                          child: Image.network(
                                                            store.imageUrl ??
                                                                '',
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          width: 100,
                                                          height: 35,
                                                          child: Text(
                                                            store.name ?? '',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              );
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        );
      }),
    );
  }
}
