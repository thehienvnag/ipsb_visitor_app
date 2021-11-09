import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/floor_plan.dart';
import 'package:ipsb_visitor_app/src/pages/map/controllers/map_controller.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/widgets/custom_bottom_bar.dart';
import 'package:ipsb_visitor_app/src/widgets/ticket_box.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class HomePage2 extends GetView<MapController> {
  final double tabBarHeight = 80;

  final storePanelController = PanelController();
  final couponPanelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 0,
        title: Container(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 42,
                width: screenSize.width * 0.54,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(3),
                ),
                child: TextFormField(
                  onFieldSubmitted: (value) {
                    storePanelController.open();
                  },
                  cursorColor: Colors.black,
                  cursorHeight: 22,
                  cursorWidth: 1,
                  decoration: new InputDecoration(
                    prefixIcon:
                        Icon(Icons.search_rounded, color: Color(0xff0DB5B4)),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    contentPadding:
                        EdgeInsets.only(left: 15, top: 9, right: 15),
                    hintText: 'Tìm kiếm ...',
                    hintStyle: TextStyle(color: Colors.grey),
                    labelStyle: TextStyle(color: Colors.black),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear, color: Color(0xff0DB5B4)),
                      onPressed: () {},
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: screenSize.width * 0.27,
                color: Colors.grey[300],
                child: Obx(() {
                  return DropdownButton<FloorPlan>(
                    onChanged: controller.changeSelectedFloor,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 25,
                    ),
                    value: controller.selectedFloor.value,
                    items: controller.listFloorPlan.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(e.floorCode ?? ''),
                        ),
                      );
                    }).toList(),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
      // body: SlidingUpPanel(
      //   controller: storePanelController,
      //   isDraggable: false,
      //   backdropOpacity: 0,
      //   minHeight: 0,
      //   maxHeight: MediaQuery.of(context).size.height,
      //   defaultPanelState: PanelState.CLOSED,
      //   body: Container(
      //     margin: EdgeInsets.only(top: 10),
      //     decoration: BoxDecoration(
      //       image: DecorationImage(
      //         image: NetworkImage(
      //             'https://genk.mediacdn.vn/2018/3/14/photo-1-1521033482343809363991.png'),
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //   ),
      // ),
      bottomNavigationBar: CustomBottombar(),
      bottomSheet: bottomSheetEnd(context),
    );
  }

  Widget buildCouponPanel({
    required PanelController panelController,
    required ScrollController scrollController,
  }) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 13),
            width: 70,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          Expanded(child: Obx(() {
            var listCoupon = controller.listCoupon;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: listCoupon.length,
              itemBuilder: (context, index) {
                var coupon = listCoupon[index];
                return GestureDetector(
                  onTap: () {
                    Get.offNamed(Routes.couponDetail);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 13),
                    child: TicketBox(
                      margin: 20,
                      fromEdgeMain: 62,
                      fromEdgeSeparator: 134,
                      isOvalSeparator: false,
                      smallClipRadius: 15,
                      clipRadius: 25,
                      numberOfSmallClips: 8,
                      ticketWidth: 340,
                      ticketHeight: 130,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 24, left: 24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Image.network(
                                            coupon.imageUrl ?? '',
                                            width: 100,
                                            height: 80,
                                            fit: BoxFit.cover,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(4),
                                              ),
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                            child: Text(
                                              coupon.code
                                                  .toString()
                                                  .toUpperCase(),
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(
                                          left: 10, top: 18),
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            coupon.name.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 19,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            height: 20,
                                            child: Text(
                                              coupon.description.toString(),
                                              style: TextStyle(
                                                  color: Colors.black87),
                                            ),
                                          ),
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                OutlinedButton(
                                                  onPressed: () {},
                                                  child: Text('View Detail'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
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
                  ),
                );
              },
            );
          })),
        ],
      ),
    );
  }

  Widget bottomSheetStart(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomSheet: SolidBottomSheet(
        minHeight: 120,
        headerBar: Container(
          color: Colors.white,
          height: 45,
          child: Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 16.0),
              height: 4,
              width: 64,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16.0)),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  width: 300,
                  margin: EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        'Trà sữa Phúc Long ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text('Tầng 1',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Container(
                    width: 150,
                    margin: EdgeInsets.only(left: 40, right: 10),
                    child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black12,
                        onPrimary: Colors.black,
                      ),
                      onPressed: () {},
                      child: Row(
                        children: [
                          Icon(FontAwesomeIcons.arrowDown, color: Colors.black),
                          Text('   Các chặng'),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        controller.changeIsShow();
                      },
                      child: Row(
                        children: [
                          Icon(Icons.directions_sharp, color: Colors.white),
                          Text('   Bắt đầu'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.arrowAltCircleUp,
                            size: 35,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(' Đi thẳng',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black)),
                                Text(' 500m',
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black38)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.arrowCircleLeft, size: 35),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(' Rẽ trái',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                                Text(' 270m',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black38)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.arrowAltCircleRight,
                            size: 35,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(' Rẽ phải',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                                Text(' 270m',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black38)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.arrowAltCircleUp,
                            size: 35,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(' Đi thẳng',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                                Text(' 500m',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black38)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.store,
                            size: 35,
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(' Cửa hàng Phúc Long',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black)),
                                Text(' 140m',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.black38)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheetEnd(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: MediaQuery.of(context).size.height * 0.8,
            child: Container(
                // height: 100,
                color: Colors.blueAccent.shade200,
                child: Row(
                  children: [
                    Container(
                        width: 100,
                        child: Icon(
                          Icons.arrow_upward,
                          size: 60,
                          color: Colors.white,
                        )),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Đi về hướng Tây Bắc',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28),
                        ),
                        Text(
                          '100m',
                          style: TextStyle(color: Colors.white, fontSize: 28),
                        ),
                      ],
                    ),
                  ],
                )),
          ),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SolidBottomSheet(
                minHeight: 120,
                headerBar: Container(
                  color: Colors.white,
                  height: 45,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 16.0),
                      height: 4,
                      width: 64,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16.0)),
                    ),
                  ),
                ),
                body: ListView(
                  children: [
                    Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Center(
                            child: Container(
                              width: 370,
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                'Đi tới: Trà sữa Phúc Long Tầng 1 (250m)',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                width: 150,
                                margin: EdgeInsets.only(left: 40, right: 10),
                                child: OutlinedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black12,
                                    onPrimary: Colors.black,
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Icon(FontAwesomeIcons.arrowDown,
                                          color: Colors.black),
                                      Text('   Các chặng'),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                child: OutlinedButton(
                                  onPressed: () {
                                    controller.changeIsShowFalse();
                                  },
                                  child: Row(
                                    children: [
                                      Icon(Icons.directions_sharp,
                                          color: Colors.white),
                                      Text('   Kết thúc'),
                                    ],
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    //padding: EdgeInsets.all(20),
                                    primary: Colors.red,
                                    onPrimary: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.arrowAltCircleUp,
                                        size: 35,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(' Đi thẳng',
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.black)),
                                            Text(' 500m',
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.black38)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Icon(FontAwesomeIcons.arrowCircleLeft,
                                          size: 35),
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(' Rẽ trái',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black)),
                                            Text(' 270m',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black38)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.arrowAltCircleRight,
                                        size: 35,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(' Rẽ phải',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black)),
                                            Text(' 270m',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black38)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.arrowAltCircleUp,
                                        size: 35,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(' Đi thẳng',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black)),
                                            Text(' 500m',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black38)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.store,
                                        size: 35,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(' Cửa hàng Phúc Long',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black)),
                                            Text(' 140m',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.black38)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 100,
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
