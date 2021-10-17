import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/pages/product_detail/controllers/product_detail_controller.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
  // int activeIndex = 0;
  final urlImages = [
    'https://cdn.jamja.vn/blog/wp-content/uploads/2017/10/bo-san-pham-tea-tree-cua-the-body-shop-12.jpg',
    'https://cochiskin.com/wp-content/uploads/2018/05/Tinh-dầu-tràm-trà-The-Body-Shop-‪Tea-Tree-Oil‬.jpg',
    'https://vn-test-11.slatic.net/p/e68fd21ee57840c804edce76afceb957.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // leading: ,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.chevron_left_outlined,
            color: Colors.black,
            size: 40,
          ),
        ),
        title: Text(
          'PRODUCT DETAILS',
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
          //Fab list
          fabButtons: <Widget>[buildVisitStore(), buildAddShoppingList()],
          colorStartAnimation: AppColors.primary,
          colorEndAnimation: Colors.pinkAccent,
          animatedIconData: AnimatedIcons.menu_close //To principal button
          ),
      body: SingleChildScrollView(
        child: Obx(() {
          if (controller.productDetails.value.id == null) {
            return Container(
              margin: EdgeInsets.only(top: screenSize.height * 0.4),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: screenSize.width,
                child: Obx(() {
                  return buildImage(
                      controller.productDetails.value.imageUrl ?? "");
                }),
              ),
              Container(
                height: 70,
                child: Obx(() {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20, top: 20),
                        width: 200,
                        child: Text(
                          controller.productDetails.value.name ?? "",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 22),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20, top: 23),
                        child: Text(
                          Formatter.price(
                              controller.productDetails.value.price),
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 17),
                        ),
                      )
                    ],
                  );
                }),
              ),
              Obx(() {
                final list =
                    controller.productDetails.value.inverseProductGroup;
                if (list == null || list.isEmpty) return Container();
                return Container(
                  margin: const EdgeInsets.only(right: 13, left: 13),
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 5,
                    right: 5,
                    bottom: 15,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin:
                            const EdgeInsets.only(top: 10, right: 13, left: 13),
                        padding: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 2,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black26, width: 1),
                          borderRadius: BorderRadius.circular(4),
                          color: AppColors.colorBlue,
                        ),
                        child: Container(
                          child: Text(
                            'Total 3 Items in combo',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              letterSpacing: 1,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final item = list[index];
                          return GestureDetector(
                            onTap: () => controller.gotoProductDetails(item.id),
                            child: Container(
                              margin: const EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(
                                      right: 10,
                                      left: 10,
                                    ),
                                    width: 80,
                                    height: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          item.imageUrl ?? '',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: screenSize.width * 0.65,
                                        child: Text(
                                          Formatter.shorten(item.name, 23),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 15),
                                        child: Text(
                                          Formatter.price(item.price),
                                          style: TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: list.length,
                      ),
                    ],
                  ),
                );
              }),
              Obx(() {
                return Container(
                  height: controller.webHeight.value,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.black26, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  margin: const EdgeInsets.only(
                      top: 8, right: 13, left: 13, bottom: 40),
                  padding: const EdgeInsets.all(5),
                  child: Stack(
                    children: [
                      Opacity(
                        opacity: controller.webLoading.isTrue ? 0 : 1,
                        child: WebView(
                          initialUrl: '',
                          onWebViewCreated:
                              (WebViewController webViewController) {
                            controller.loadWebView(webViewController);
                          },
                          onPageFinished: (some) {
                            controller.changeHeight();
                          },
                          javascriptMode: JavascriptMode.unrestricted,
                        ),
                      ),
                      if (controller.webLoading.isTrue)
                        Container(
                          height: screenSize.height,
                          child: Center(child: CircularProgressIndicator()),
                        )
                    ],
                  ),
                );
              })
            ],
          );
        }),
      ),
    );
  }

  Widget buildImage(String urlImage) => Container(
        //margin: EdgeInsets.symmetric(horizontal: 24),
        color: Colors.grey,
        child: Image.network(
          urlImage,
          fit: BoxFit.cover,
        ),
      );
  // Widget buildIndicator() => AnimatedSmoothIndicator(
  //       activeIndex: controller.activeIndex.value,
  //       count: urlImages.length,
  //       effect: JumpingDotEffect(
  //         dotWidth: 10,
  //         dotHeight: 10,
  //       ),
  //     );
  Widget buildVisitStore() => FloatingActionButton.extended(
        heroTag: "btn1",
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        onPressed: () {},
        foregroundColor: Colors.white,
        backgroundColor: AppColors.secondary,
        icon: Icon(
          Icons.directions,
          color: Colors.white,
        ),
        label: Text('DIRECTIONS'),
      );
  Widget buildAddShoppingList() => FloatingActionButton.extended(
        heroTag: "btn2",
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        onPressed: () {},
        foregroundColor: Colors.white,
        backgroundColor: AppColors.secondary,
        icon: Icon(
          Icons.add,
          color: Colors.white,
        ),
        label: Text('ADD SHOPPING LIST'),
      );
}
