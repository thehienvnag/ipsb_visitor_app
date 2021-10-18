import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/pages/product_detail/controllers/product_detail_controller.dart';
import 'package:ipsb_visitor_app/src/utils/formatter.dart';
import 'package:animated_floating_buttons/animated_floating_buttons.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductDetailPage extends GetView<ProductDetailController> {
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
          'Product Details',
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
                          height: 80,
                          child: Center(
                            child: Container(
                              height: 30,
                              width: 30,
                              child: CircularProgressIndicator(),
                            ),
                          ),
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
