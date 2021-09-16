import 'package:visitor_app/src/services/global_states/auth_services.dart';
import 'package:visitor_app/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:visitor_app/src/pages/profile/controllers/profile_controller.dart';
import 'package:visitor_app/src/routes/routes.dart';
import 'package:visitor_app/src/services/global_states/shared_states.dart';
import 'package:visitor_app/src/widgets/custom_bottom_bar.dart';

class ProfilePage extends GetView<ProfileController> {
  final SharedStates sharedStates = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          SizedBox(height: 10.0 * 5),
          Obx(() {
            String imageUrl = AuthServices.userLoggedIn.value.imageUrl ?? "";
            String name =
                AuthServices.userLoggedIn.value.name ?? "User profile";
            return Column(
              children: <Widget>[
                Container(
                  height: 10.0 * 10,
                  width: 10.0 * 10,
                  margin: EdgeInsets.only(top: 10.0 * 3),
                  child: Stack(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: Utils.resolveNetworkImg(
                            imageUrl, 'assets/images/profile.png'),
                        radius: 100,
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.profileDetail);
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.black26, width: 1.5)),
                            child: Center(
                              heightFactor: 10.0 * 1.5,
                              widthFactor: 10.0 * 1.5,
                              child: Icon(
                                Icons.edit,
                                // color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    )),
              ],
            );
          }),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.profileDetail);
            },
            child: Container(
              height: 55,
              margin: EdgeInsets.symmetric(
                horizontal: 30,
              ).copyWith(
                bottom: 20,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.account_circle,
                    size: 25,
                    color: const Color(0xff344CDD),
                  ),
                  SizedBox(width: 15),
                  Text('Tài khoản của tôi',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      )),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              height: 55,
              margin: EdgeInsets.symmetric(horizontal: 30).copyWith(bottom: 20),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.help,
                    size: 25,
                    color: const Color(0xff344CDD),
                  ),
                  SizedBox(width: 15),
                  Text('Trợ giúp và hỗ trợ',
                      style: TextStyle(
                        fontSize: 10.0 * 1.7,
                        fontWeight: FontWeight.w500,
                      )),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              height: 55,
              margin: EdgeInsets.symmetric(
                horizontal: 30,
              ).copyWith(
                bottom: 20,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.policy,
                    size: 25,
                    color: const Color(0xff344CDD),
                  ),
                  SizedBox(width: 15),
                  Text('Điều khoản & chính sách',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      )),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed(Routes.setting);
            },
            child: Container(
              height: 55,
              margin: EdgeInsets.symmetric(
                horizontal: 30,
              ).copyWith(bottom: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.settings,
                    size: 25,
                    color: const Color(0xff344CDD),
                  ),
                  SizedBox(width: 15),
                  Text('Cài đặt',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      )),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              await controller.logOut();
            },
            child: Container(
              height: 55,
              margin: EdgeInsets.symmetric(
                horizontal: 30,
              ).copyWith(
                bottom: 20,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.logout,
                    size: 25,
                    color: const Color(0xff344CDD),
                  ),
                  SizedBox(width: 15),
                  Text('Đăng xuất',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      )),
                  Spacer(),
                  Icon(
                    Icons.arrow_forward,
                    size: 25,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottombar(),
    );
  }
}
