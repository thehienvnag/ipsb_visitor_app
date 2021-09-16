import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/pages/update_infomation_signup/controllers/update_profile_controller.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';
import 'package:ipsb_visitor_app/src/utils/utils.dart';

class UpdateProfilePage extends GetView<UpdateProfileController> {
  final SharedStates sharedStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'Update Information',
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Obx(() {
                      String filePath = controller.filePath.value;

                      return Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Colors.white,
                          ),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 6,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 4))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: Utils.resolveFileImg(
                              filePath,
                              "assets/images/profile.png",
                            ),
                          ),
                        ),
                      );
                    }),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            controller.getImage();
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                              ),
                              color: Colors.grey,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
              Container(
                height: 48,
                margin: EdgeInsets.only(top: 60, right: 20, left: 20),
                child: TextField(
                  onSubmitted: (value) {
                    controller.setUserName(value);
                  },
                  decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                              color: Colors.grey.withOpacity(0.6))),
                      hintText: 'Enter your name',
                      hintStyle: TextStyle(color: Colors.black45),
                      prefixIcon: Icon(
                        Icons.person_pin_rounded,
                        color: Colors.grey,
                      )),
                  //controller: phoneController,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(4)),
              ),
              Obx(() {
                return Container(
                  height: 48,
                  margin: EdgeInsets.only(top: 15, right: 20, left: 20),
                  child: TextField(
                    onSubmitted: (value) {
                      controller.setPassword(value);
                    },
                    obscureText: controller.isShowPass.value ? true : false,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                              color: Colors.grey.withOpacity(0.6))),
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.changeShowPass();
                        },
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: controller.isShowPass.value
                              ? Colors.grey
                              : Colors.blue,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.vpn_key_outlined,
                        color: Colors.grey,
                      ),
                      hintText: 'New Password',
                      hintStyle: TextStyle(color: Colors.black45),
                    ),
                  ),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(4)),
                );
              }),
              Obx(() {
                return Container(
                  height: 48,
                  margin: EdgeInsets.only(top: 15, right: 20, left: 20),
                  child: TextField(
                    onSubmitted: (value) {
                      controller.setRePassword(value);
                    },
                    obscureText: controller.isRePass.value ? true : false,
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                              color: Colors.grey.withOpacity(0.6))),
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.changeShowRePass();
                        },
                        icon: Icon(
                          Icons.remove_red_eye,
                          color: controller.isRePass.value
                              ? Colors.grey
                              : Colors.blue,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.vpn_key_outlined,
                        color: Colors.grey,
                      ),
                      hintText: 'Re-type password',
                      hintStyle: TextStyle(color: Colors.black45),
                    ),
                  ),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(4)),
                );
              }),
              Container(
                margin: EdgeInsets.only(top: 35, right: 20, left: 20),
                height: 46,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primary),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    controller.checkRePassword();
                  },
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
