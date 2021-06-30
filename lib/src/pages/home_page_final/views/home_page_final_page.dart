import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/pages/home_page_final/controllers/home_page_final_controller.dart';

class HomePageFinalPage extends GetView<HomePageFinalController> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        actions: <Widget>[
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(right: 30),
                child: Image.asset('assets/images/icon_building.png'),
                height: 35,
              ),
              Container(
                width: screenSize.width * 0.72,
                child: Text(
                  'Vincom Lê Văn Việt',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.account_circle,
                  color: Colors.blue,
                  size: 30,
                ),
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Container(
                    width: 320,
                    margin: EdgeInsets.only(top: 10, left: 15, bottom: 15),
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Tìm kiếm...',
                        icon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 20,
                          top: 5,
                        ),
                        child: Image.asset('assets/images/icon_map.png'),
                        height: 40,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          'Bản đồ',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 15, left: 15),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/icon_coffee.png',
                          height: 50,
                        ),
                        Text(
                          'Cà phê',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/icon_milktea.png',
                          height: 50,
                        ),
                        Text(
                          'Trà sữa',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/icon_shopping.png',
                          height: 50,
                        ),
                        Text(
                          'Mua sắm',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/icon_restaurant.png',
                          height: 50,
                        ),
                        Text(
                          'Nhà hàng',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Column(
                      children: <Widget>[
                        Image.asset(
                          'assets/images/icon_cinema.png',
                          height: 50,
                        ),
                        Text(
                          'Xem phim',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'THƯƠNG HIỆU NỔI BẬT',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Xem tất cả',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() {
                var listStore = controller.listStore;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Wrap(
                        spacing: 18,
                        children: List.generate(listStore.length, (index) {
                          final store = listStore[index];
                          return Card(
                            elevation: 6,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 60,
                                  height: 60,
                                  child: Image.network(
                                    store.imageUrl ?? '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  width: 100,
                                  height: 35,
                                  child: Text(
                                    store.name ?? '',
                                    textAlign: TextAlign.center,
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
              Container(
                padding: EdgeInsets.only(left: 10, top: 15, bottom: 12),
                alignment: Alignment.centerLeft,
                child: Text(
                  'ƯU ĐÃI ĐẶC BIỆT',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              Obx(() {
                var listCoupon = controller.listCoupon;
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 290,
                    child: ListView.builder(
                      addSemanticIndexes: true,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: listCoupon.length,
                      itemBuilder: (BuildContext ctx, index) {
                        final coupon = listCoupon[index];
                        return Container(
                          margin: EdgeInsets.only(left: 5),
                          child: Card(
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 180,
                                  height: 180,
                                  child: Image.network(
                                    coupon.imageUrl ?? '',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    Container(
                                      width: 170,
                                      height: 100,
                                      // child: Text(
                                      //   '[${coupon.store?.name ?? ''}] ' +
                                      //       (coupon.description ?? ''),
                                      //   style: TextStyle(
                                      //     fontSize: 18,
                                      //     //fontWeight: FontWeight.w500
                                      //   ),
                                      // ),
                                      child: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                            text:
                                                '[${coupon.store?.name ?? ''}] ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.black),
                                          ),
                                          TextSpan(
                                            text: coupon.description ?? ' ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black),
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
