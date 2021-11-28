import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/product.dart';
import 'package:ipsb_visitor_app/src/services/api/product_service.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductDetailController extends GetxController {
  IProductService _productService = Get.find();
  late WebViewController webViewController;
  final webHeight = 100.0.obs;
  final webLoading = true.obs;

  final activeIndex = 0.obs;
  final productDetails = Product().obs;

  @override
  void onInit() {
    super.onInit();
    loadProductDetails();
  }

  void loadProductDetails() {
    final idStr = Get.parameters["productId"] ?? "24";
    int? id = int.tryParse(idStr);
    if (id == null) return;
    loadProductById(id);
  }

  Future<void> loadProductById(int id) async {
    final productFound = await _productService.getProductById(id);
    if (productFound != null) {
      productDetails.value = productFound;
    }
  }

  void loadWebView(WebViewController controller) async {
    webViewController = controller;
    final filePath = 'assets/templates/product_detail.txt';
    final contentPosition = '@PRODUCT_CONTENT';
    String template = await rootBundle.loadString(filePath);
    String content = template.replaceFirst(
      contentPosition,
      productDetails.value.description ?? "",
    );
    await controller.loadUrl(Uri.dataFromString(
      content,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    ).toString());
  }

  void changeHeight() async {
    try {
      const scrollHeightJs = "document.documentElement?.scrollHeight;";

      double height = double.parse(
        await webViewController.evaluateJavascript(scrollHeightJs),
      );
      webHeight.value = height + 10;
      Future.delayed(
          Duration(milliseconds: 2000), () => webLoading.value = false);
    } catch (e) {}
  }

  void gotoProductDetails(int? id) async {
    if (id == null) return;
    await loadProductById(id);
    loadWebView(webViewController);
  }
}
