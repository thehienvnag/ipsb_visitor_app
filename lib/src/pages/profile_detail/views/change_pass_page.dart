import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/pages/profile_detail/controllers/profile_detail_controller.dart';
import 'package:ipsb_visitor_app/src/pages/update_infomation_signup/controllers/update_profile_controller.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';
import 'package:ipsb_visitor_app/src/utils/utils.dart';

class ChangePasswordPage extends GetView<ProfileDetailController> {
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
                'Change Password',
                style: TextStyle(color: Colors.black87),
              ),
            ],
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Get.back(closeOverlays: true);
            },
          ),
        ),
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.only(left: 16, top: 100, right: 16),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Column(children: [
              Obx(() {
                  return Container(
                    height: 48,
                    margin: EdgeInsets.only(top: 15, right: 20, left: 20),
                    child: TextField(
                      onChanged: (value) {
                        controller.setOldPassword(value);
                      },
                      obscureText: controller.isOldShowPass.value ? true : false,
                      decoration: InputDecoration(
                        border: new OutlineInputBorder(borderSide: new BorderSide(color: Colors.grey.withOpacity(0.6))),
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.changeOldShowPass();
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: controller.isOldShowPass.value
                                ? Colors.grey
                                : Colors.blue,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.vpn_key_outlined,
                          color: Colors.grey,
                        ),
                        hintText: 'Old Password',
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
                  onChanged: (value) {
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
                  onChanged: (value) {
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
              width: 150,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(AppColors.primary),
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
        ));
  }
}
