import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/common/constants.dart';
import 'package:ipsb_visitor_app/src/pages/login_gmail/controllers/login_gmail_controller.dart';
import 'package:ipsb_visitor_app/src/pages/login_phone/controllers/login_phone_controller.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginPhonePage extends GetView<LoginPhoneController> {
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Text(
            'Sign In',
            style: TextStyle(color: Colors.black),
          ),
          leading: IconButton(
            padding: EdgeInsets.only(left: 10),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          color: Colors.white,
          width: screenSize.width * 0.9,
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 30, right: 20, left: 20),
                  child: Text(
                    'Enter mobile number to receive a verification code for free.',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  )),
              Container(
                margin: EdgeInsets.only(top: 30, right: 20, left: 20),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter Mobile Number',
                    hintStyle: TextStyle(color: Colors.black45),
                    prefixIcon: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  controller: phoneController,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(4)),
              ),
              SizedBox(height: 10),
              Container(
                width: screenSize.width * 0.9,
                height: 65,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 63,
                    vertical: 13,
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: AppColors.primary),
                    onPressed: () {
                      controller.sendCodeToPhone(phoneController.text);
                    },
                    child: Text(
                      "Send Verification Code",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              Center(
                  child: Text(
                'You can also login with these methods',
                style: TextStyle(
                    fontSize: 15, color: Colors.black.withOpacity(0.8)),
              )),
              SizedBox(height: 20),
              SignInButton(
                Buttons.GoogleDark,
                text: "Sign in with Google",
                onPressed: () {
                  LoginEmailController loginController = Get.find();
                  loginController.loginWithGoogle();
                },
              ),
              SizedBox(height: 20),
              Container(
                width: 300,
                margin: const EdgeInsets.only(left: 15, bottom: 15),
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
        ));
  }
}
