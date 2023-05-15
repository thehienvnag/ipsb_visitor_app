import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/pages/create_shopping_list/controllers/create_shopping_list_controller.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:ipsb_visitor_app/src/pages/create_shopping_list/views/select_building.dart';

class CreateShoppingListPage extends GetView<CreateShoppingListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          alignment: Alignment.center,
          child: Text(
            'Create Shopping List',
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
      body: SingleChildScrollView(
        child: Column(
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
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Container(
                    height: 43,
                    margin: EdgeInsets.only(top: 15, right: 30, left: 30),
                    child: TextField(
                      onChanged: (val) =>
                          controller.shoppingListName.value = val,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black12,
                        contentPadding: EdgeInsets.only(top: 5, left: 10),
                        hintText: 'Input list name',
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25, left: 28, right: 28),
                    child: SelectBuilding(
                      dataCallback: controller.loadBuilding,
                      label: "Select building",
                      onSubmitted: (value) =>
                          controller.setShoppingBuilding(value),
                    ),
                  ),
                  Container(
                    height: 43,
                    margin: EdgeInsets.only(top: 25, right: 30, left: 30),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.black12,
                    ),
                    child: DateTimePicker(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        icon: Icon(
                          Icons.event,
                          color: Colors.black,
                        ),
                        hintText: "Choose shopping date",
                      ),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      onChanged: (val) => controller.shoppingDate.value = val,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 30),
                    child: OutlinedButton(
                      style:
                          ElevatedButton.styleFrom(primary: AppColors.primary),
                      onPressed: () => controller.submitForm(),
                      child: Text(
                        "Create List",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
