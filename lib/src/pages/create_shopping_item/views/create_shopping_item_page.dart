import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/pages/create_shopping_item/controllers/create_shopping_item_controller.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:ipsb_visitor_app/src/pages/create_shopping_item/views/select_product.dart';

class CreateShoppingItemPage extends GetView<CreateShoppingItemController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'Shopping Item',
            style: TextStyle(color: Colors.black),
          ),
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.chevron_left_outlined,
            color: Colors.black,
            size: 40,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 10),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border.all(color: Colors.grey.withOpacity(0.4), width: 0.5),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(top: 20, left: 35),
                    child: Text(
                      'Information: ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 25, left: 28, right: 28),
                  child: SelectProduct(
                    dataCallback: controller.loadProducts,
                    label: "Select product",
                    onSubmitted: (value) => print(value),
                  ),
                ),
                Container(
                  height: 43,
                  margin: EdgeInsets.only(top: 15, right: 30, left: 30),
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black12,
                      contentPadding: EdgeInsets.only(top: 5, left: 10),
                      hintText: 'Enter note for shopping item',
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: OutlinedButton(
                    style: ElevatedButton.styleFrom(primary: AppColors.primary),
                    onPressed: () {},
                    child: Text(
                      "Create",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
