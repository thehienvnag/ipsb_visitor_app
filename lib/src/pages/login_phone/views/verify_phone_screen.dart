import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/login_phone/controllers/login_phone_controller.dart';

class VerifyPhoneScreen extends GetView<LoginPhoneController> {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
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
                      SizedBox(height: 40),
                      Center(
                          child: Text('Nhập mã xác nhận được gửi về số điện thoại',
                        style: TextStyle(color: Colors.black87,fontSize: 16),
                      )),
                      Center(
                          child: Container(
                        margin: EdgeInsets.only(top: 20, left: 80),
                        child: Row(
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 15),
                                child: Text(
                                  '+84 '+ controller.phoneNumber.value,
                                  style: TextStyle(
                                    color: Color(0xff2AD4D3),
                                    fontSize: 20
                                  ),
                                )),
                          ],
                        ),
                      )),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 45,
                        margin: EdgeInsets.only(top: 30, right: 10, left: 10),
                        child: TextField(
                          controller: otpController,
                          keyboardType: TextInputType.number,
                          cursorHeight: 25,
                          cursorWidth: 3,
                          cursorColor: Colors.lightBlueAccent,
                          decoration: InputDecoration(
                            hintText: 'Nhập mã xác nhận ở điện thoại',
                            hintStyle: TextStyle(color: Colors.black45),
                            contentPadding: EdgeInsets.only(top: 3, left: 10),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 35,
                        padding: EdgeInsets.only(top: 7),
                        child: FlatButton(
                          onPressed: (){
                            controller.verifyCodeFromPhone();
                          },
                          child: Text(
                            "Xác thực",
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white,fontSize: 18),
                          ),
                          textColor: Colors.white,
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xff2AD4D3),
                            borderRadius: BorderRadius.circular(4)),
                      ),
                      Container(
                        width: screenSize.width*0.6,
                          margin: EdgeInsets.only(top: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text('Tôi chưa nhận được mã ?  ',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                                ),
                              Text('Gửi lại',
                                style: TextStyle(fontSize: 18, color: Colors.blue),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ));
  }
}
