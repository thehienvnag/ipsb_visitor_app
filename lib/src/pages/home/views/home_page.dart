import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/floor_plan.dart';
import 'package:indoor_positioning_visitor/src/pages/home/controllers/home_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends GetView<HomeController> {
  final storePanelController = PanelController();
  final couponPanelController = PanelController();
  final double tabBarHeight = 80;

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
                    controller.changeSearchValue(value);
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
                      onPressed: () {
                        controller.changeSearchValue("");
                      },
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
      body: SlidingUpPanel(
        controller: storePanelController,
        isDraggable: false,
        backdropOpacity: 0,
        minHeight: 0,
        maxHeight: MediaQuery.of(context).size.height,
        defaultPanelState: PanelState.CLOSED,
        panelBuilder: (scrollController) => buildStorePanel(
          scrollController: scrollController,
          panelController: storePanelController,
        ),
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
      ),
      floatingActionButton: Obx(() {
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
                      controller: couponPanelController,
                      maxHeight: 190,
                      panelBuilder: (scrollController) => buildCouponPanel(
                        scrollController: scrollController,
                        panelController: couponPanelController,
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
                primary: Colors.blue,
                onPrimary: Colors.red,
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

  Widget buildStorePanel({
    required PanelController panelController,
    required ScrollController scrollController,
  }) {
    return Container(
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
                ClipOval(
                  child: Material(
                    color: Colors.grey.shade300,
                    // Button color
                    child: InkWell(
                      splashColor: Colors.blueAccent, // Splash color
                      onTap: () {
                        panelController.close();
                        controller.changeSearchValue('');
                      },
                      child: SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(Icons.close),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(child: Obx(() {
            var listStore = controller.listStore;
            if (listStore.isEmpty) {
              return Container();
            }
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
                              listStore[index].imageUrl ?? '',
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
                                width: MediaQuery.of(context).size.width * 0.60,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      listStore[index].floorPlan?.floorCode ??
                                          'L-NotSet',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                  listStore[index].description ??
                                      'Description not set',
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ),
                              Text(listStore[index].status ?? 'Status not set',
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
    );
  }

  Widget buildCouponPanel({
    required PanelController panelController,
    required ScrollController scrollController,
  }) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          Expanded(child: Obx(() {
            var listCoupon = controller.listCoupon;
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
                        width: MediaQuery.of(context).size.width * 0.80,
                        height: 120,
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
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
                                  listCoupon[index].imageUrl ?? '',
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              padding: const EdgeInsets.only(top: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: 27,
                                    child: Text(
                                      listCoupon[index].name ?? '',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
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
                                      Text(
                                        listCoupon[index].code ?? '',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '      Xem chi tiết',
                                        style: TextStyle(
                                          color: Colors.blueAccent,
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
                    ],
                  ),
                );
              },
            );
          })),
        ],
      ),
    );
  }
}
