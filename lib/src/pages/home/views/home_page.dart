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
                    if (states.building.value.id != null)
                      Obx(() {
                        return Container(
                          height: controller.showSlider.value
                              ? screenSize.height * 0.439
                              : screenSize.height * 0.181,
                          width: screenSize.width,
                          color: Colors.white,
                        );
                      }),
                    if (states.building.value.id != null)
                      Container(
                        // margin: const EdgeInsets.only(top: 202),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(color: Colors.grey.shade200),
                          ),
                        ),
                        height: screenSize.height * 0.194,
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
                                if (list.isEmpty)
                                  return CircularProgressIndicator();
                                return Expanded(
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: 5,
                                    itemBuilder: (context, index) {
                                      final item = list[index];
                                      return Container(
                                        height: screenSize.height * 0.0775,
                                        width: screenSize.width * 0.243,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              width: screenSize.width * 0.133,
                                              height:
                                                  screenSize.height * 0.0646,
                                              padding: const EdgeInsets.all(4),
                                              margin: const EdgeInsets.only(
                                                  bottom: 7),
                                              child: Image(
                                                image:
                                                    CachedNetworkImageProvider(
                                                        item.imageUrl ?? ""),
                                                width: 38,
                                                height: 38,
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
                    if (states.building.value.id != null)
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
                                if (listStore.isEmpty)
                                  return Center(
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                int storeCount =
                                    listStore.length > 9 ? 9 : listStore.length;
                                return Wrap(
                                  direction: Axis.horizontal,
                                  alignment: WrapAlignment.spaceAround,
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
                                                  width:
                                                      screenSize.width * 0.146,
                                                  height:
                                                      screenSize.height * 0.077,
                                                  child: CachedNetworkImage(
                                                    imageUrl:
                                                        store.imageUrl ?? '',
                                                    fit: BoxFit.contain,
                                                  ),
                                                ),
                                                Container(
                                                  margin:
                                                      EdgeInsets.only(top: 10),
                                                  width:
                                                      screenSize.width * 0.243,
                                                  height:
                                                      screenSize.height * 0.045,
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
                    if (states.building.value.id != null)
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
                                height: screenSize.height * 0.232,
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
                                          width: screenSize.width * 0.85,
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
                            if (listBuilding.isEmpty)
                              return CircularProgressIndicator();
                            return Container(
                              margin: states.building.value.id == null
                                  ? const EdgeInsets.only(top: 70)
                                  : null,
                              child: ListView.separated(
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
                                        height: screenSize.height * 0.13,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: screenSize.height * 0.13,
                                              width: screenSize.width * 0.33,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          building.imageUrl ??
                                                              ''),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            Container(
                                              width: screenSize.width * 0.61,
                                              child: ListTile(
                                                title: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      Formatter.shorten(
                                                        building.name,
                                                        12,
                                                      ),
                                                      style: TextStyle(
                                                          fontSize: 16),
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
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              top: 7),
                                                      child: Text(
                                                        '${building.distanceTo?.toStringAsFixed(1) ?? ""} (km)',
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
                                  }),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Obx(() {
                return Container(
                  height: controller.showSlider.value &&
                          states.building.value.id != null
                      ? screenSize.height * 0.251
                      : screenSize.height * 0.123,
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
              if (states.building.value.id != null)
                Positioned(
                  top: 105,
                  left: 0,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    width: screenSize.width,
                    height: screenSize.height * 0.31,
                    child: Obx(() {
                      if (!controller.showSlider.value) {
                        return Container();
                      }
                      final images = controller.listCoupon
                          .map((element) => element.imageUrl!)
                          .toList();
                      if (images.isEmpty)
                        return Container(
                          child: Center(child: CircularProgressIndicator()),
                          color: Colors.transparent,
                        );
                      return CarouselSlider(
                        options: CarouselOptions(
                          height: screenSize.height * 0.31,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          initialPage: 2,
                          autoPlay: true,
                        ),
                        items: images.map((img) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: screenSize.width * 0.85,
                                height: screenSize.height * 0.31,
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
                child: Obx(() {
                  return UserWelcome(
                    currentPosition: controller.currentAddress.value,
                  );
                }),
              ),
              Container(
                margin: const EdgeInsets.only(top: 55),
                child: HomeSearchBar(),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottombar(),
      );
    });
  }
}
