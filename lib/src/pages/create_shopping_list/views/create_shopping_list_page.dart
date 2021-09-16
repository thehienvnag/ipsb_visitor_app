import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/pages/create_shopping_list/controllers/create_shopping_list_controller.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';

import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_plus/dropdown_plus.dart';

class CreateShoppingListPage extends GetView<CreateShoppingListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.colorBlue,
        title: Container(
          alignment: Alignment.center,
          child: Text('Create Shopping List'),
        ),
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Add List Name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 43,
            margin: EdgeInsets.only(top: 5, right: 30, left: 30),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[300],
                contentPadding: EdgeInsets.only(top: 5, left: 10),
                hintText: 'Input list name',
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(5)),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Add Building Name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 45,
            margin: EdgeInsets.only(top: 10, left: 24, right: 24),
            child: TextDropdownFormField(
              options: ["Male", "Female"],
              decoration: InputDecoration(
                  fillColor: Colors.grey[300],
                  filled: true,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  labelStyle: TextStyle(color: Colors.black87, fontSize: 18),
                  labelText: "Select building"),
              dropdownHeight: 120,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Shopping Date',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 43,
            margin: EdgeInsets.only(top: 5, right: 30, left: 30),
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              //border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(6),
              color: Colors.grey[300],
            ),
            child: DateTimePicker(
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.event,
                  color: Colors.black,
                ),
              ),
              initialValue: DateTime.now().toString(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              selectableDayPredicate: (date) {
                // Disable weekend days to select from the calendar
                if (date.weekday == 6 || date.weekday == 7) {
                  return false;
                }
                return true;
              },
              onChanged: (val) => print(val),
              validator: (val) {
                print(val);
                return null;
              },
              onSaved: (val) => print(val),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Text(
              'Set Priority',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 40),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        //border: Border.all(color: Colors.black26, width: 1),
                        shape: BoxShape.circle,
                        color: Color(0xff64B0E7),
                      ),
                    ),
                    Container(
                      child: Text(
                        'High',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      //border: Border.all(color: Colors.black26, width: 1),
                      shape: BoxShape.circle,
                      color: Color(0xff57E770),
                    ),
                  ),
                  Text(
                    'Medium',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(right: 40),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        //border: Border.all(color: Colors.black26, width: 1),
                        shape: BoxShape.circle,
                        color: Color(0xffFFB547),
                      ),
                    ),
                    Text(
                      'Low',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 30),
            child: OutlinedButton(
              style: ElevatedButton.styleFrom(primary: AppColors.primary),
              onPressed: () {},
              child: Text(
                "Create List",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
