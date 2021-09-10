import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/login_gmail/controllers/login_gmail_controller.dart';
import 'package:indoor_positioning_visitor/src/pages/login_phone/controllers/login_phone_controller.dart';

class LoginPhonePage extends GetView<LoginPhoneController> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          // backgroundColor: Color(0xff2AD4D3),
          backgroundColor: Colors.white,
          title: Text(
            'Sign Up',
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
          margin: EdgeInsets.only(left: 20,right: 20),
                color: Colors.white,
                width: screenSize.width*0.9,
                child: Column(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 30 , right: 20, left: 20),
                        child: Text('Enter mobile number to receive a verification code for free.',
                      style: TextStyle(color: Colors.black87,fontSize: 16),
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
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: screenSize.width*0.9,
                      height: 65,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 63, vertical: 13,),
                        child: FlatButton(
                          onPressed: () {
                            controller.sendCodeToPhone(phoneController.text);
                          },
                          child: Text("Send Verification Code",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          color: Colors.purple,
                          textColor: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Center(child: Text('You can also login with these methods',
                      style: TextStyle(fontSize: 15, color: Colors.black.withOpacity(0.8)),)),
                    SizedBox(height: 20),
                    Container(
                      width: screenSize.width*0.5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        onPressed: () {
                          LoginEmailController loginController = Get.find();
                          loginController.loginWithGoogle();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0,top: 8,bottom: 8),
                              child: Icon(FontAwesomeIcons.google,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(width: 5,),
                            Text('Sign up with Google'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Login means you agree ', style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.8)),),
                        Text('User Agreement ', style: TextStyle(fontSize: 14, color: Colors.blue.withOpacity(0.8)),),
                        Text('and ', style: TextStyle(fontSize: 14, color: Colors.black.withOpacity(0.8)),),
                        Text('Privacy Policy', style: TextStyle(fontSize: 14, color: Colors.blue.withOpacity(0.8)),),
                      ],
                    ),
                  ],
                ),
              )
    );
  }
}
