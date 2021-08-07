import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/login_phone/controllers/login_phone_controller.dart';

class LoginPhonePage extends GetView<LoginPhoneController> {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff2AD4D3),
          title: Text(
            'Đăng Nhập',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            padding: EdgeInsets.only(left: 10),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
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
                      SizedBox(height: 10),
                      Center(
                          child: Text('Nhập số điện thoại của bạn',
                        style: TextStyle(color: Colors.black87,fontSize: 20),
                      )),
                      Container(
                        margin: EdgeInsets.only(top: 30, right: 20, left: 20),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Nhập số điện thoại ',
                            hintStyle: TextStyle(color: Colors.black45),
                            prefix: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Text('+84'),
                            ),
                          ),
                          maxLength: 9,
                          keyboardType: TextInputType.number,
                          controller: phoneController,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      SizedBox(height: 29),
                      Container(
                        width: 293,
                        height: 65,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 63, vertical: 13,),
                          child: FlatButton(
                            onPressed: () {
                              controller.sendCodeToPhone(phoneController.text);
                            },
                            child: Text("Gửi SMS",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            color: Colors.blue,
                            textColor: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
    );
  }
}
