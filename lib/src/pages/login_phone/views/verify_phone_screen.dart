import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/login_phone/controllers/login_phone_controller.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyPhoneScreen extends GetView<LoginPhoneController> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          //backgroundColor: Color(0xff2AD4D3),
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
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                SizedBox(height: 40),
                Center(
                  child: Text(
                    'Verification code has sent to ${controller.phoneNumber.value}. Please enter the text verification code.',
                    style: TextStyle(color: Colors.black87, fontSize: 16),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 60,
                  margin: EdgeInsets.only(
                    top: 30,
                  ),
                  child: PinCodeTextField(
                    appContext: context,
                    length: 6,
                    //obscureText: true,
                    //obscuringCharacter: '*',
                    // obscuringWidget: FlutterLogo(
                    //   size: 24,
                    // ),

                    blinkWhenObscuring: true,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      activeColor: Colors.purpleAccent,
                      inactiveFillColor: Colors.white,
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.grey.withOpacity(0.3),
                      inactiveColor: Colors.white,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: Duration(milliseconds: 300),
                    enableActiveFill: true,
                    // controller: textEditingController,
                    keyboardType: TextInputType.number,
                    boxShadows: [
                      BoxShadow(
                        offset: Offset(0, 1),
                        color: Colors.black12,
                        blurRadius: 10,
                      )
                    ],
                    onCompleted: (v) {
                      controller.verifyCodeFromPhone(v);
                    },
                    onChanged: (value) {
                      // print(value);
                    },
                  ),
                ),
                Container(
                    width: screenSize.width * 0.7,
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Did't receive the Code ?",
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller
                                .sendCodeToPhone(controller.phoneNumber.value);
                            BotToast.showText(
                                text: "Verifition Code Resend Successfull",
                                duration: const Duration(seconds: 5));
                          },
                          child: Text(
                            'Resend',
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                        ),
                      ],
                    )),
                Container(
                    width: screenSize.width * 0.9,
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "What do I do if I can't receive the SMS verification code ?  ",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "1. If your phone cannot receive the SMS verification code, please select Accept voice verification code and wait for the (+84) 931-182-303's call.",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "2. Receiving a voice verification call is free of charge verification.",
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ));
  }
}
