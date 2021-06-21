import 'package:flutter/material.dart';
import 'package:flutter_ticket_widget/flutter_ticket_widget.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';
import 'my_coupon_detail_page.dart';
import 'package:indoor_positioning_visitor/src/pages/my_coupons/controllers/my_coupon_controller.dart';

class MyCouponPage extends GetView<MyCouponController> {
  CouponInUse? model;
  List<CouponInUse> listCoupon = [];
  List<CouponInUse> listAllCoupon = [];
  List<CouponInUse> listExpireCoupon = [];
  List<CouponInUse> listCouponUsed = [];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leadingWidth: 0,
          title: Center(
              child: Text('Coupon của tôi', style: TextStyle(color: Colors.black),)),
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                child: Align(
                    alignment: Alignment.center,
                    child: Text('Tất cả',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7), fontSize: 18),
                    )),
              ),
              Tab(
                child: Align(
                    alignment: Alignment.center,
                    child: Text('Đã hết hạn',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7), fontSize: 18),
                    )),
              ),
              Tab(
                child: Align(
                    alignment: Alignment.center,
                    child: Text('Đã dùng',
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.7), fontSize: 18),
                    )),
              ),
            ],
          ),
        ),
        body: Container(
          color: Colors.grey.withOpacity(0.2),
          child: Obx(() {
            listCoupon = controller.listCoupon.value;
            return  TabBarView(
              children: [
                _AllCoupon(listCoupon, context, 'NotUse'),
                _ExpireCoupon(listCoupon, context, 'Expired'),
                _UsedCoupon(listCoupon, context, 'Used'),
              ],
            );
          })
        ),
        bottomNavigationBar: BottomNavigationBar(
          unselectedLabelStyle: TextStyle(color: Colors.grey),
          selectedLabelStyle: TextStyle(color: Color(0xff0DB5B4)),
          type: BottomNavigationBarType.fixed,
          currentIndex: 1,
          selectedItemColor: Color(0xff0DB5B4),
          unselectedItemColor: Color(0xffC4C4C4),
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home,
              ),
            ),
            BottomNavigationBarItem(
              label: 'My Coupons',
              icon: Icon(
                Icons.view_list,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Messenges',
              icon: Icon(
                Icons.notifications_active,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Account',
              icon: Icon(
                Icons.account_circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _AllCoupon(List<CouponInUse> allCoupon, BuildContext context, String status){
    final screenSize = MediaQuery.of(context).size;
    for(int i = 0; i < allCoupon.length; i++){
      if(allCoupon[i].status == status){
        listAllCoupon.add(allCoupon[i]);
      }
    }
    if(listAllCoupon.isEmpty) {
      return Container(
        child: Center(child: Text("Chưa lưu voucher nào !",style: TextStyle(fontSize: 20),)),
      );
    }
    return  Container(
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: listAllCoupon.length,
            itemBuilder: (BuildContext buildContext, int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyCouponDetailPage(listAllCoupon[index]),
                  ));
                },
                child: Container(
                  width: screenSize.width,
                  child: Column(
                      children: [
                        SizedBox(height: 15),
                        FlutterTicketWidget(
                          width: screenSize.width*0.9,
                          height: 130.0,
                          isCornerRounded: true,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.0, right: 20, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                      child: Image.network(
                                        listAllCoupon[index].imageUrl.toString(),
                                        width: 100,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: List.generate(
                                          screenSize.height*0.8 ~/ (10 + 5),
                                              (_) =>
                                              Container(
                                                width: 2,
                                                height: 2,
                                                color:  Colors.black38,
                                                margin: EdgeInsets.only(left: 2.5, right: 2.5),
                                              ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: MediaQuery.of(context).size.width * 0.45,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            listAllCoupon[index].name.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            height: 20,
                                            child: Text(
                                              listAllCoupon[index].description.toString(),
                                              style: TextStyle(color: Colors.black87),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(listAllCoupon[index].code.toString(),
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold)
                                              ),
                                              GestureDetector(
                                                onTap: (){
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => MyCouponDetailPage(listCoupon[index]),
                                                  ));
                                                },
                                                child: Text('  Xem chi tiết',
                                                    style: TextStyle(
                                                        color: Colors.blueAccent,
                                                        fontSize: 13)),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            height: 15,
                                            child: Text(
                                              'Ngày hết hạn: ' + listAllCoupon[index].expireDate.toString(),
                                              style: TextStyle(color: Colors.black87),
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
                        ),
                      ]
                  ),
                ),
              );
            }),
    );
  }
  Widget _ExpireCoupon(List<CouponInUse> allCoupon, BuildContext context, String status){
    final screenSize = MediaQuery.of(context).size;
    for(int i = 0; i < allCoupon.length; i++){
      if(allCoupon[i].status == status){
        listExpireCoupon.add(allCoupon[i]);
      }
    }
    if(listExpireCoupon.isEmpty) {
      return Container(
        child: Center(child: Text("Không có voucher hết hạn nào!",style: TextStyle(fontSize: 20),)),
      );
    }
    return  Container(
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: listExpireCoupon.length,
            itemBuilder: (BuildContext buildContext, int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MyCouponDetailPage(listExpireCoupon[index]),
                  ));
                },
                child: Container(
                  width: screenSize.width,
                  child: Column(
                      children: [
                        SizedBox(height: 15),
                        FlutterTicketWidget(
                          width: screenSize.width*0.9,
                          height: 130.0,
                          isCornerRounded: true,
                          child: Padding(
                            padding: EdgeInsets.only(top: 20.0, right: 20, left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                      child: Image.network(
                                        listExpireCoupon[index].imageUrl.toString(),
                                        width: 100,
                                        height: 80,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: List.generate(
                                          screenSize.height*0.8 ~/ (10 + 5),
                                              (_) =>
                                              Container(
                                                width: 2,
                                                height: 2,
                                                color:  Colors.black38,
                                                margin: EdgeInsets.only(left: 2.5, right: 2.5),
                                              ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: MediaQuery.of(context).size.width * 0.45,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            listExpireCoupon[index].name.toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Container(
                                            height: 20,
                                            child: Text(
                                              listExpireCoupon[index].description.toString(),
                                              style: TextStyle(color: Colors.black87),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(listExpireCoupon[index].code.toString(),
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.bold)
                                              ),
                                              GestureDetector(
                                                onTap: (){
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                    builder: (context) => MyCouponDetailPage(listCoupon[index]),
                                                  ));
                                                },
                                                child: Text('  Xem chi tiết',
                                                    style: TextStyle(
                                                        color: Colors.blueAccent,
                                                        fontSize: 15)),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            height: 15,
                                            child: Text(
                                              'Ngày hết hạn: ' + listExpireCoupon[index].expireDate.toString(),
                                              style: TextStyle(color: Colors.black87),
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
                        ),
                      ]
                  ),
                ),
              );
            }),
    );
  }
  Widget _UsedCoupon(List<CouponInUse> allCoupon, BuildContext context, String status){
    final screenSize = MediaQuery.of(context).size;
    for(int i = 0; i < allCoupon.length; i++){
      if(allCoupon[i].status == status){
        listCouponUsed.add(allCoupon[i]);
      }
    }
    if(listCouponUsed.isEmpty) {
      return Container(
        child: Center(child: Text("Chưa dùng voucher nào!",style: TextStyle(fontSize: 20),)),
      );
    }
    return  Container(
        child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: listCouponUsed.length,
              itemBuilder: (BuildContext buildContext, int index) {
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MyCouponDetailPage(listCouponUsed[index]),
                    ));
                  },
                  child: Container(
                    width: screenSize.width,
                    child: Column(
                        children: [
                          SizedBox(height: 15),
                          FlutterTicketWidget(
                            width: screenSize.width*0.9,
                            height: 130.0,
                            isCornerRounded: true,
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.0, right: 20, left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      ClipRRect(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(6),
                                        ),
                                        child: Image.network(
                                          listCouponUsed[index].imageUrl.toString(),
                                          width: 100,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Container(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: List.generate(
                                            screenSize.height*0.8 ~/ (10 + 5),
                                                (_) =>
                                                Container(
                                                  width: 2,
                                                  height: 2,
                                                  color:  Colors.black38,
                                                  margin: EdgeInsets.only(left: 2.5, right: 2.5),
                                                ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              listCouponUsed[index].name.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Container(
                                              height: 20,
                                              child: Text(
                                                listCouponUsed[index].description.toString(),
                                                style: TextStyle(color: Colors.black87),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                    listCouponUsed[index].code.toString(),
                                                    style: TextStyle(
                                                        color: Colors.green,
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.bold)
                                                ),
                                                GestureDetector(
                                                  onTap: (){
                                                    Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (context) => MyCouponDetailPage(listCouponUsed[index]),
                                                    ));
                                                  },
                                                  child: Text('  Xem chi tiết',
                                                      style: TextStyle(
                                                          color: Colors.blueAccent,
                                                          fontSize: 15)),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 5),
                                              height: 15,
                                              child: Text(
                                                'Ngày sử dụng: ' + listCouponUsed[index].applyDate.toString(),
                                                style: TextStyle(color: Colors.black87),
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
                          ),
                        ]
                    ),
                  ),
                );
              }),
    );
  }
}

