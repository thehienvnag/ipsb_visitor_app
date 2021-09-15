import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:com.ipsb.visitor_app/src/pages/map/controllers/map_controller.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

class TestAlgorithmPage extends GetView<MapController> {
  @override
  Widget build(BuildContext context) {
    return bottomSheetStart(context);
  }

  Widget bottomSheetStart(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
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
                                child: Row(
                                  children: [
                                    Text('Đi tới: ',
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black)),
                                    Text(
                                      'Trà sữa Phúc Long ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    Text('Tầng 1 (250m)',
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
      ),
    );
  }
}
