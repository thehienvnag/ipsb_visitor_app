import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/models/store.dart';
import 'package:indoor_positioning_visitor/src/pages/home/controllers/home_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends GetView<HomeController> {
  final panelController = PanelController();
  final double tabBarHeight = 80;
  List<Store> listStore =[];
  List<Coupon> listCoupon = [];
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    TextEditingController _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 0,
        title: Row(
          children: [
            Container(
              margin: EdgeInsets.only(top: 12),
              height: 40,
              width: screenSize.width * 0.63,
              color: Color(0xffF2F2F2),
              child: Container(
                height: 42,
                width: screenSize.width * 0.93,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(3),
                ),
                child:
                Obx(() {
                  return TextFormField(
                    onFieldSubmitted: (value) {
                      controller.changeSearchValue(value);
                      _controller.text = value;
                    } ,
                    cursorColor: Colors.black,
                    cursorHeight: 22,
                    cursorWidth: 1,
                    //controller: _controller,
                    // initialValue: _controller.value.text,
                    decoration: new InputDecoration(
                      prefixIcon: Icon(Icons.search_rounded, color: Color(0xff0DB5B4)),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only( left: 15, bottom: 17, top: 11, right: 15),
                      hintText: 'Tìm kiếm ...',
                      hintStyle: TextStyle(color: Colors.grey),
                      labelStyle: TextStyle(color: Colors.black),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.clear, color: Color(0xff0DB5B4)),
                        onPressed: () {
                          controller.changeSearchValue("");
                          _controller.clear();
                        } ,
                      ),),

                  );
                }) ,
                ),
              ),
            Container(
              margin: EdgeInsets.only(top: 12, left: 10),
              height: 40,
              width: screenSize.width * 0.27,
              color: Color(0xffF2F2F2),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Obx(() {
                  return DropdownButton<Floor>(
                    onChanged: controller.changeSelectedFloor,
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 25,
                    ),
                    value: controller.selectedFloor.value,
                    items: controller.listFloorPlan.map((e) {
                      return DropdownMenuItem(
                        value: e,
                        child: Text(e.name),
                      );
                    }).toList(),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      body: Obx(() {
        if (controller.searchValue.isEmpty) {
          return Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://genk.mediacdn.vn/2018/3/14/photo-1-1521033482343809363991.png'),
                fit: BoxFit.cover,
              ),
            ),
          );
        }
        return SlidingUpPanel(
          controller: panelController,
          backdropOpacity: 0,
          boxShadow: null,
          color: Colors.transparent,
          //maxHeight: MediaQuery.of(context).size.height - tabBarHeight, kéo full lên trên lúc search
          panelBuilder: (scrollController) => buildSlidingPanel(
            scrollController: scrollController,
            panelController: panelController,
          ),
          backdropEnabled: false,
          body: Container(
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://genk.mediacdn.vn/2018/3/14/photo-1-1521033482343809363991.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }),
      floatingActionButton:
      Obx(() {
        if (controller.searchValue.isEmpty) {
          return Container(
            alignment: Alignment.bottomLeft,
            margin: EdgeInsets.only(left: 30, bottom: 80),
            width: screenSize.width,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  barrierColor: Colors.transparent,
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return SlidingUpPanel(
                      //margin: EdgeInsets.only(top: screenSize.height * 0.65),
                      controller: panelController,
                      maxHeight: MediaQuery.of(context).size.height - 400,
                      panelBuilder: (scrollController) => buildSlidingPanelCoupon(
                        scrollController: scrollController,
                        panelController: panelController,
                      ),
                      color: Colors.transparent,
                      onPanelClosed: () => Navigator.of(context).pop(),
                      defaultPanelState: PanelState.OPEN,
                    );
                  },
                );
              },
              child: Icon(Icons.card_giftcard_sharp, color: Colors.white),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                primary: Colors.blue, // <-- Button color
                onPrimary: Colors.red, // <-- Splash color
              ),
            ),
          );
        }
        return SizedBox();
      }),
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: TextStyle(color: Colors.grey),
        selectedLabelStyle: TextStyle(color: Color(0xff0DB5B4)),
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
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
    );
  }

  Widget buildSlidingPanel({
    required PanelController panelController,
    required ScrollController scrollController,
  }) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(tabBarHeight - 20),
          child: GestureDetector(
            onTap: panelController.open,
            child: AppBar(
              backgroundColor: Colors.white,
              title: Container(
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 60,
                height: 8,
              ),
              centerTitle: true,
              bottom: TabBar(
                indicatorColor: Colors.black12,
                tabs: [
                  Tab(
                      child: Text(
                    'Kết quả tìm kiếm',
                    style: TextStyle(color: Colors.black, fontSize: 22),
                  )),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(child: Obx(() {
              listStore = controller.listStore.value;
              return ListView.builder(
                itemCount: listStore.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => StoreDetailScreen(id: model.id.toString()),
                    //     ),
                    //   );
                    // },
                    child: Container(
                       //color: Colors.red,
                      margin: EdgeInsets.only(top: 13),
                      padding: EdgeInsets.only(left: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 90,
                            child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                              child: Image.network(
                                listStore[index].image,
                                width: 110,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        listStore[index].name +
                                            " - L" +
                                            listStore[index].floorNum,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Container(
                                          child: Icon(
                                        Icons.directions,
                                        size: 33,
                                      )),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 20,
                                  child: Text(
                                    listStore[index].des,
                                    style: TextStyle(color: Colors.black87),
                                  ),
                                ),
                                Text(listStore[index].status,
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ],
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

  Widget buildSlidingPanelCoupon({
    required PanelController panelController,
    required ScrollController scrollController,
  }) {
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(tabBarHeight - 20),
          child: GestureDetector(
            onTap: panelController.open,
            child: AppBar(
              backgroundColor: Colors.white,
              title: Container(
                margin: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8),
                ),
                width: 60,
                height: 8,
              ),
              centerTitle: true,
              bottom: TabBar(
                indicatorColor: Colors.black12,
                tabs: [
                  Tab(
                      child: Text(
                        'Ưu đãi nỗi bật cho bạn',
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      )),
                ],
              ),
            ),
          ),
        ),
        body: Row(
          children: [
            Expanded(child: Obx(() {
              listCoupon = controller.listCoupon.value;
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: listCoupon.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => StoreDetailScreen(id: model.id.toString()),
                    //     ),
                    //   );
                    // },
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          height: 100,
                          margin: const EdgeInsets.all(10.0),
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 90,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                  child: Image.network(
                                    listCoupon[index].imageUrl.toString(),
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width * 0.45,
                                      height: 27,
                                      child: Text(
                                        listCoupon[index].name.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Container(
                                      height: 25,
                                      child: Text(
                                        listCoupon[index].description.toString(),
                                        style: TextStyle(color: Colors.black87),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(listCoupon[index].code.toString(),
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold)
                                        ),
                                        Text('      Xem chi tiết',
                                            style: TextStyle(
                                                color: Colors.blueAccent,
                                                fontSize: 15)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

class Floor {
  var name;
  var floorNum;

  Floor({
    this.name,
    this.floorNum,
  });
}


