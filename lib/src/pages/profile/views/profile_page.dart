import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';
import 'package:ipsb_visitor_app/src/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/pages/profile/controllers/profile_controller.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';
import 'package:ipsb_visitor_app/src/widgets/custom_bottom_bar.dart';

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
                  child: CircleAvatar(
                    backgroundImage: Utils.resolveNetworkImg(
                        imageUrl, 'assets/images/profile.png'),
                    radius: 100,
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
                  Text('My Account',
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
                  Text('Logout',
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
