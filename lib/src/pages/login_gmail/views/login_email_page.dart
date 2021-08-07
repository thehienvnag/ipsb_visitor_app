import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/pages/login_gmail/controllers/login_gmail_controller.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';


class LoginEmailPage extends GetView<LoginEmailController> {
  final SharedStates sharedStates = Get.find();
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          Image(
              width: screenSize.width,  height: screenSize.height,
              image: NetworkImage("https://officespace.vn/wp-content/uploads/2018/08/cho-thue-van-phong-toa-lotte-hanoi-5.jpg")),
          Container(
            margin: EdgeInsets.only(top: 100),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 90,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: 290,
                        height: 200,
                        child:
                        Image(image: NetworkImage("https://f8.photo.talk.zdn.vn/1651828501473160221/656b4d00bdca4a9413db.jpg")),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          'Giúp việc mua sắm trở lên tiện lợi hơn',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),
                  GestureDetector(
                      onTap: () {
                        controller.loginWithGoogle();
                      },
                      child: GestureDetector(
                        child: Container(
                          height: 45,
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.google,
                                size: 10.0 * 2.5,
                                color: Colors.red.withOpacity(0.6),
                              ),
                              SizedBox(width: 30),
                              Text(
                                'Đăng nhập với Google',
                                style: TextStyle(color: Colors.black87,fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: (){
                      Get.toNamed(Routes.loginPhone);
                    },
                    child: GestureDetector(
                      child: Container(
                        height: 45,
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        color: Colors.white,
                        child: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.phone,
                              size: 10.0 * 2.5,
                              color: Colors.lightBlue.withOpacity(0.6),
                            ),
                            SizedBox(width: 30),
                            Text(
                              'Đăng nhập với số điện thoại',
                              style: TextStyle(color: Colors.black87,fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
