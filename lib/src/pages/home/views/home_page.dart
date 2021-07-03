import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/home/controllers/home_controller.dart';
import 'package:indoor_positioning_visitor/src/widgets/custom_bottom_bar.dart';
import 'package:indoor_positioning_visitor/src/widgets/custom_search_bar.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: SafeArea(
          child: Container(
            height: 200,
            color: Colors.white,
            child: Stack(children: [
              Obx(() {
                final images = controller.listCoupon
                    .map((element) => element.imageUrl!)
                    .toList();
                if (images.isEmpty)
                  return Container(
                    color: Colors.grey.shade200,
                  );
                return CarouselSlider(
                  options: CarouselOptions(
                    height: 180.0,
                    viewportFraction: 1.03,
                  ),
                  items: images.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                          width: screenSize.width,
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
              Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: HomeSearchBar(),
                ),
              ),
            ]),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
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
                                      padding: const EdgeInsets.all(4),
                                      margin: const EdgeInsets.only(bottom: 7),
                                      child: Image.asset(
                                        item.imageUrl ?? '',
                                        height: 38,
                                        width: 38,
                                      ),
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(color: Colors.black12),
                                        borderRadius: BorderRadius.circular(7),
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
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Obx(() {
                        var listStore = controller.listStore;
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Wrap(
                                spacing: 18,
                                children: List.generate(6, (index) {
                                  final store = listStore[index];
                                  return Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(
                                            right: 5, bottom: 10),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          border:
                                              Border.all(color: Colors.black12),
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
                                      ),
                                    ],
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                BorderRadius.circular(8)),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Container(
                                            width: 170,
                                            height: 100,
                                            child: RichText(
                                              text: TextSpan(children: [
                                                TextSpan(
                                                  text:
                                                      '[${coupon.store?.name ?? ''}] ',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black),
                                                ),
                                                TextSpan(
                                                  text:
                                                      coupon.description ?? ' ',
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottombar(),
    );
  }
}
