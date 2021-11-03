import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/pages/home/controllers/home_controller.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:ipsb_visitor_app/src/widgets/custom_bottom_bar.dart';
import 'package:ipsb_visitor_app/src/widgets/custom_search_bar.dart';
import 'package:ipsb_visitor_app/src/widgets/ticket_box.dart';
import 'package:ipsb_visitor_app/src/widgets/user_welcome.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Obx(() {
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                  children: [
                    Obx(() {
                      return Container(
                        height: controller.showSlider.value ? 340 : 140,
                        width: screenSize.width,
                        color: Colors.white,
                      );
                    }),
                    Container(
                      // margin: const EdgeInsets.only(top: 202),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(color: Colors.grey.shade200),
                        ),
                      ),
                      height: 150,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'CATEGORIES',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Container(
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'View more >>',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(
                            () {
                              final list = controller.listCategories;
                              if (list.isEmpty) return Text('Loading');
                              return Expanded(
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    final item = list[index];
                                    return Container(
                                      height: 60,
                                      width: 100,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            width: 55,
                                            height: 50,
                                            padding: const EdgeInsets.all(4),
                                            margin: const EdgeInsets.only(
                                                bottom: 7),
                                            child: Image.asset(
                                              item.imageUrl ?? '',
                                              height: 38,
                                              width: 38,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black12),
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                            ),
                                          ),
                                          Text(
                                            item.name ?? '',
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'OUTSTANDING STORES',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Container(
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'View more >>',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: screenSize.width,
                            margin: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            child: Obx(() {
                              var listStore = controller.listStore;
                              int storeCount =
                                  listStore.length > 9 ? 9 : listStore.length;

                              return Wrap(
                                direction: Axis.horizontal,
                                alignment: WrapAlignment.spaceBetween,
                                children: List.generate(storeCount, (index) {
                                  final store = listStore[index];
                                  return GestureDetector(
                                    onTap: () =>
                                        controller.goToStoreDetails(store.id),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              right: 5, bottom: 15),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6, vertical: 2),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black12),
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
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                width: 100,
                                                height: 35,
                                                child: Text(
                                                  store.name ?? '',
                                                  textAlign: TextAlign.center,
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
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'OUTSTANDING COUPONS',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Container(
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'View more >>',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(() {
                            var listCoupon = controller.listCoupon;
                            return Container(
                              height: 180,
                              margin: const EdgeInsets.only(left: 5),
                              child: ListView.builder(
                                addSemanticIndexes: true,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: listCoupon.length,
                                itemBuilder: (BuildContext ctx, index) {
                                  final coupon = listCoupon[index];
                                  return GestureDetector(
                                    onTap: () =>
                                        controller.goToCouponDetails(coupon),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      child: TicketBox.small(
                                        width: 350,
                                        imgUrl: coupon.imageUrl!,
                                        storeName: coupon.store?.name,
                                        name: coupon.name,
                                        description: coupon.description,
                                        amount: coupon.amount,
                                        couponTypeId: coupon.couponTypeId,
                                        expireDate: coupon.expireDate,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15),
                      padding: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'NEARBY BUILDINGS',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                              Container(
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    'View more >>',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Obx(() {
                            var listBuilding = controller.listBuilding;
                            return ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: listBuilding.length,
                                separatorBuilder: (context, index) => Divider(
                                      height: 20,
                                      thickness: 1,
                                      indent: 15,
                                      endIndent: 15,
                                    ),
                                itemBuilder: (context, index) {
                                  final building = listBuilding[index];
                                  // controller.getDistanceBetweenTwoLocation(building.address.toString());
                                  // String distance = controller.distanceTwoPoin.value.toString();
                                  return GestureDetector(
                                    onTap: () =>
                                        controller.gotoDetails(building.id),
                                    child: Container(
                                      height: 100,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 100,
                                            width: screenSize.width * 0.33,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                    building.imageUrl ?? ''),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                          ),
                                          Container(
                                            width: screenSize.width * 0.6,
                                            child: ListTile(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    Formatter.shorten(
                                                        building.name, 14),
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                ],
                                              ),
                                              subtitle: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 7),
                                                    child: Text(
                                                      Formatter.shorten(
                                                          building.address),
                                                      //'50 Lê Văn Việt | 3km'
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                return Container(
                  height: controller.showSlider.value ? 195 : 95,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColors.gradientColor,
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(0.5, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp,
                    ),
                  ),
                );
              }),
              Positioned(
                top: 105,
                left: 0,
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: screenSize.width,
                  height: 240,
                  child: Obx(() {
                    if (!controller.showSlider.value) {
                      return Container();
                    }
                    final images = controller.listCoupon
                        .map((element) => element.imageUrl!)
                        .toList();
                    if (images.isEmpty)
                      return Container(
                        color: Colors.grey.shade200,
                      );
                    return CarouselSlider(
                      options: CarouselOptions(
                        height: 240,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        initialPage: 2,
                        autoPlay: true,
                      ),
                      items: images.map((img) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: 350,
                              height: 240,
                              margin: const EdgeInsets.only(
                                bottom: 30,
                                right: 15,
                                left: 15,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                image: DecorationImage(
                                  alignment: Alignment.center,
                                  image: CachedNetworkImageProvider(img),
                                  fit: BoxFit.cover,
                                  scale: 0.95,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    );
                  }),
                ),
              ),
              Positioned(
                top: 7,
                width: screenSize.width,
                child: UserWelcome(),
              ),
              Container(
                margin: const EdgeInsets.only(top: 55),
                child:
                    HomeSearchBar(buildingName: controller.buildingName.value),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottombar(),
      );
    });
  }
}
