import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/models/floor_plan.dart';
import 'package:indoor_positioning_visitor/src/pages/home/controllers/home_controller.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/widgets/ticket_box.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class HomePage extends GetView<HomeController> {
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
            margin: EdgeInsets.only(left: 30, bottom: 130),
            width: screenSize.width,
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  barrierColor: Colors.transparent,
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return SlidingUpPanel(
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
                final store = listStore[index];
                final floorPlan = store.floorPlan;
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
                              store.imageUrl ?? '',
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
                                      floorPlan?.floorCode ?? 'L-NotSet',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    OutlinedButton(
                                      onPressed: () {},
                                      child: Icon(Icons.directions),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 20,
                                child: Text(
                                  store.description ?? 'Description not set',
                                  style: TextStyle(color: Colors.black87),
                                ),
                              ),
                              Text(
                                store.status ?? 'Status not set',
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                  onTap: () => controller.gotoCouponDetails(coupon),
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
                                                  child: Text('Xem chi tiết'),
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
}
