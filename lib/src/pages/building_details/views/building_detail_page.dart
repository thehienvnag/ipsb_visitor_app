import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:indoor_positioning_visitor/src/pages/building_details/controllers/building_detail_controller.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';
import 'package:indoor_positioning_visitor/src/widgets/rounded_button.dart';

class BuildingDetailPage extends GetView<BuildingDetailController> {
  final SharedStates sharedData = Get.find();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final buildingSelected = sharedData.building.value;
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: Column(
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
                height: screenSize.height * 0.7,
                child: Card(
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              buildingSelected.name ?? 'Vạn hạnh mall',
                              style: TextStyle(fontSize: 22),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mở cửa 9:30',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blueAccent),
                            ),
                            Text(
                              '  Đóng cửa 22:30',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.blueAccent),
                            ),
                          ],
                        ),
                        Text(
                          'Địa chỉ:',
                          style: TextStyle(fontSize: 18),
                        ),
                        Container(
                          width: screenSize.width,
                          height: 80,
                          child: Card(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            color: Colors.white70,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    buildingSelected.address ??
                                        '50 Lê Văn Việt',
                                    style: TextStyle(fontSize: 19),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Xem bản đồ >>',
                                    style: TextStyle(
                                        color: Colors.blueAccent, fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Thương Hiệu',
                              style: TextStyle(fontSize: 23),
                            ),
                            GestureDetector(
                                onTap: () {
                                  Get.toNamed(Routes.buildingStore);
                                },
                                child: Text(
                                  'Xem tất cả',
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: 17),
                                ))
                          ],
                        ),
                        Obx(() {
                          var listStore = controller.listStore;
                          if (listStore.isEmpty) {
                            return Center(
                              child: Text('Loading'),
                            );
                          }
                          return GestureDetector(
                            onTap: () {},
                            child: Column(
                              children: [
                                Container(
                                  height: 310,
                                  child: GridView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      addSemanticIndexes: true,
                                      shrinkWrap: true,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3, // num row
                                        mainAxisSpacing: 8,
                                        childAspectRatio:
                                            0.85, // height of Card
                                      ),
                                      itemCount: 6,
                                      itemBuilder: (BuildContext ctx, index) {
                                        final store = listStore[index];
                                        return Card(
                                            shape: BeveledRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                    width: 100,
                                                    height: 82,
                                                    child: Image(
                                                      image: NetworkImage(store
                                                          .imageUrl
                                                          .toString()),
                                                      fit: BoxFit.cover,
                                                    )),
                                                Container(
                                                    width: 100,
                                                    height: 40,
                                                    child: Center(
                                                        child: Text(store.name
                                                            .toString())))
                                              ],
                                            ));
                                      }),
                                ),
                              ],
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
