import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/common/constants.dart';
import 'package:indoor_positioning_visitor/src/models/account.dart';
import 'package:indoor_positioning_visitor/src/models/building.dart';
import 'package:indoor_positioning_visitor/src/models/coupon.dart';
import 'package:indoor_positioning_visitor/src/models/coupon_in_use.dart';
import 'package:indoor_positioning_visitor/src/pages/login_gmail/controllers/login_gmail_controller.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class SharedStates extends GetxService {
  /// selected bottom bar index
  final bottomBarSelectedIndex = 0.obs;

  // Coupon
  final coupon = Coupon().obs;

  // Coupon
  final couponInUse = CouponInUse().obs;

  // Building
  final building =
      Building(id: 12, name: "Đại học FPT thành phố Hồ Chí Minh").obs;

  // User login in app
  User? user;

  /// Account info
  final userLoggedIn = Account().obs;

  // Function call login screen
  void bottomSheet(context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController passController = TextEditingController();
    LoginEmailController loginController = Get.find();
    Size screenSize = MediaQuery.of(context).size;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.4,
                      ),
                      Text("Login",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.black.withOpacity(0.8),
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: screenSize.width * 0.26,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 18,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, right: 20, left: 20),
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Enter Mobile Number',
                          hintStyle: TextStyle(color: Colors.black45),
                          prefixIcon: Icon(
                            Icons.phone,
                            color: Colors.grey,
                          )),
                      maxLength: 10,
                      keyboardType: TextInputType.number,
                      controller: phoneController,
                    ),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(4)),
                  ),
                  Obx(() {
                    return Container(
                      margin: EdgeInsets.only(right: 20, left: 20),
                      child: TextField(
                        obscureText:
                            loginController.isShowPass.value ? true : false,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () {
                              loginController.changeIshowPass();
                            },
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: loginController.isShowPass.value
                                  ? Colors.grey
                                  : Colors.blue,
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(color: Colors.black45),
                        ),
                        controller: passController,
                      ),
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(4)),
                    );
                  }),
                  Container(
                    margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          width: 140,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.purpleAccent,
                            ),
                            onPressed: () {
                              Get.toNamed(Routes.loginPhone);
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 140,
                          child: OutlinedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(
                                        color: Colors.purpleAccent, width: 2)),
                              ),
                            ),
                            onPressed: () {
                              loginController.checkLoginWithPhoneAndPass(
                                  phoneController.value.text,
                                  passController.value.text);
                            },
                            child: Text('Login'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      SizedBox(
                        width: screenSize.width * 0.55,
                      ),
                      Text('Forgot Password ?',
                          style: TextStyle(fontSize: 15, color: Colors.blue)),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                      child: Text(
                    'You can also login with these methods',
                    style: TextStyle(
                        fontSize: 15, color: Colors.black.withOpacity(0.8)),
                  )),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.4),
                        child: Icon(
                          FontAwesomeIcons.facebookF,
                          color: Colors.blue,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          LoginEmailController loginController = Get.find();
                          loginController.loginWithGoogle();
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(0.4),
                          child: Icon(
                            FontAwesomeIcons.google,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(0.4),
                          child: Icon(
                            FontAwesomeIcons.twitter,
                            color: Colors.blue,
                          )),
                      CircleAvatar(
                          backgroundColor: Colors.grey.withOpacity(0.4),
                          child: Icon(
                            FontAwesomeIcons.line,
                            color: Colors.green,
                          )),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Login means you agree ',
                        style: TextStyle(
                            fontSize: 14, color: Colors.black.withOpacity(0.8)),
                      ),
                      Text(
                        'User Agreement ',
                        style: TextStyle(
                            fontSize: 14, color: Colors.blue.withOpacity(0.8)),
                      ),
                      Text(
                        'and ',
                        style: TextStyle(
                            fontSize: 14, color: Colors.black.withOpacity(0.8)),
                      ),
                      Text(
                        'Privacy Policy',
                        style: TextStyle(
                            fontSize: 14, color: Colors.blue.withOpacity(0.8)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void logout() {
    Get.toNamed(Routes.home);
  }

  // new version no context
  void showLoginBottomSheet() {
    TextEditingController phoneController = TextEditingController();
    TextEditingController passController = TextEditingController();
    LoginEmailController loginController = Get.put(LoginEmailController());
    Get.bottomSheet(
      SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: <Widget>[
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                    ),
                    Text("Login",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 110,
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 25,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 10, right: 20, left: 20),
                  child: TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter Mobile Number',
                        hintStyle: TextStyle(color: Colors.black45),
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Colors.grey,
                        )),
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    controller: phoneController,
                  ),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(4)),
                ),
                Obx(() {
                  return Container(
                    margin: EdgeInsets.only(right: 20, left: 20),
                    child: TextField(
                      obscureText:
                          loginController.isShowPass.value ? true : false,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            loginController.changeIshowPass();
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: loginController.isShowPass.value
                                ? Colors.grey
                                : Colors.blue,
                          ),
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        hintText: 'Enter Password',
                        hintStyle: TextStyle(color: Colors.black45),
                      ),
                      controller: passController,
                    ),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(4)),
                  );
                }),
                Container(
                  margin: EdgeInsets.only(top: 20, right: 20, left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: 140,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: AppColors.primary,
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.loginPhone);
                          },
                          child: Text(
                            'Sign Up',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 140,
                        child: OutlinedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                  side: BorderSide(
                                      color: Colors.purpleAccent, width: 2)),
                            ),
                          ),
                          onPressed: () {
                            loginController.checkLoginWithPhoneAndPass(
                                phoneController.value.text,
                                passController.value.text);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(color: AppColors.primary),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      width: 220,
                    ),
                    Text('Forgot Password ?',
                        style:
                            TextStyle(fontSize: 15, color: AppColors.primary)),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                    child: Text(
                  'You can also login with these methods',
                  style: TextStyle(
                      fontSize: 15, color: Colors.black.withOpacity(0.8)),
                )),
                SizedBox(height: 20),
                SignInButton(
                  Buttons.GoogleDark,
                  text: "Sign up with Google",
                  onPressed: () {
                    LoginEmailController loginController = Get.find();
                    loginController.loginWithGoogle();
                  },
                ),
                SizedBox(height: 20),
                Container(
                  width: 300,
                  margin: const EdgeInsets.only(bottom: 15),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'You agree ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black.withOpacity(0.8),
                        ),
                      ),
                      TextSpan(
                        text: 'User Agreement ',
                        style: TextStyle(
                            fontSize: 14, color: Colors.blue.withOpacity(0.8)),
                      ),
                      TextSpan(
                        text: 'and ',
                        style: TextStyle(
                            fontSize: 14, color: Colors.black.withOpacity(0.8)),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                            fontSize: 14, color: Colors.blue.withOpacity(0.8)),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierColor: Colors.transparent,
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(width: 0.5, color: Colors.grey),
      ),
      enableDrag: false,
    );
  }
}
