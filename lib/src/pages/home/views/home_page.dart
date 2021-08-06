import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/home/controllers/home_controller.dart';
import 'package:indoor_positioning_visitor/src/utils/formatter.dart';
import 'package:indoor_positioning_visitor/src/widgets/custom_bottom_bar.dart';
import 'package:indoor_positioning_visitor/src/widgets/custom_search_bar.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Obx(() {
      return Scaffold(
        // appBar: PreferredSize(
        //   preferredSize:
        //       Size.fromHeight(controller.showSlider.value ? 180 : 77),
        //   child: Material(
        //     elevation: 4,
        //     child: SafeArea(
        //       child: ,
        //     ),
        //   ),
        // ),
        body: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: controller.scrollController,
                child: Column(
                  children: [
                    Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 202),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Danh mục sản phẩm',
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
                                        'Xem thêm >>',
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
                                                padding:
                                                    const EdgeInsets.all(4),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Thương hiệu nổi bật',
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
                                        'Xem thêm >>',
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
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Obx(() {
                                  var listStore = controller.listStore;
                                  int storeCount = listStore.length > 9
                                      ? 9
                                      : listStore.length;

                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Wrap(
                                          spacing: 18,
                                          children: List.generate(storeCount,
                                              (index) {
                                            final store = listStore[index];
                                            return GestureDetector(
                                              onTap: () => controller
                                                  .goToStoreDetails(store.id),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            right: 5,
                                                            bottom: 10),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 6,
                                                            vertical: 2),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Colors.black12),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Container(
                                                          width: 60,
                                                          height: 60,
                                                          child: Image.network(
                                                            store.imageUrl ??
                                                                '',
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 10),
                                                          width: 100,
                                                          height: 35,
                                                          child: Text(
                                                            store.name ?? '',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ],
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
                              ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Ưu đãi nổi bật',
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
                                        'Xem thêm >>',
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
                                  height: 280,
                                  child: ListView.builder(
                                    addSemanticIndexes: true,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: listCoupon.length,
                                    itemBuilder: (BuildContext ctx, index) {
                                      final coupon = listCoupon[index];
                                      return GestureDetector(
                                        onTap: () => controller
                                            .goToCouponDetails(coupon),
                                        child: Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Card(
                                            child: Column(
                                              children: [
                                                Container(
                                                  height: 180,
                                                  width: 180,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                          coupon.imageUrl ?? '',
                                                        ),
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                ),
                                                Row(
                                                  children: <Widget>[
                                                    Container(
                                                      width: 170,
                                                      height: 60,
                                                      child: RichText(
                                                        text:
                                                            TextSpan(children: [
                                                          TextSpan(
                                                            text:
                                                                '[${coupon.store?.name ?? ''}] ',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          TextSpan(
                                                            text: coupon
                                                                    .description ??
                                                                ' ',
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                        ]),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Container(
                                                  width: 170,
                                                  child: RichText(
                                                    text: TextSpan(children: [
                                                      TextSpan(
                                                        text: 'Expire: ',
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      TextSpan(
                                                        text: Formatter.date(
                                                            coupon.expireDate),
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                              ],
                                            ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 10),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Tòa nhà gần bạn',
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
                                        'Xem thêm >>',
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
                                    separatorBuilder: (context, index) =>
                                        Divider(
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
                                                width: screenSize.width * 0.38,
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image: NetworkImage(
                                                        building.imageUrl ??
                                                            ''),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              Container(
                                                width: screenSize.width * 0.55,
                                                child: ListTile(
                                                  title: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Text(
                                                        Formatter.shorten(
                                                            building.name, 14),
                                                        style:
                                                            TextStyle(fontSize: 16),
                                                      ),
                                                     // Text(controller.getDistanceDisplay(building.address.toString())
                                                     //        , style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14))

                                                    ],
                                                  ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 7),
                                                        child: Text(
                                                          Formatter.shorten(
                                                              building.address),
                                                          //'50 Lê Văn Việt | 3km'
                                                          style: TextStyle(
                                                              fontSize: 16),
                                                        ),
                                                      ),
                                                      Container(
                                                        margin: const EdgeInsets
                                                            .only(top: 10),
                                                        child: RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text:
                                                                    'Đang hoạt động',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .blueAccent,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text:
                                                                    ' 7h00 - 21h30',
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black87,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
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
                  ],
                ),
              ),
              Positioned(
                child: Container(
                  height: controller.showSlider.value ? 200 : 77,
                  color: Colors.green.shade100,
                  child: Stack(children: [
                    Obx(() {
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
                          height: 200.0,
                          viewportFraction: 1.4,
                        ),
                        items: images.map((i) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: screenSize.width * 1.01,
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(i),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    }),
                  ]),
                ),
              ),
              HomeSearchBar(buildingName: controller.buildingName.value)
            ],
          ),
        ),
        bottomNavigationBar: CustomBottombar(),
      );
    });
  }
}
