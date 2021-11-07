import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/pages/profile_detail/controllers/profile_detail_controller.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';

class ProfileDetailPage extends GetView<ProfileDetailController> {
  final SharedStates sharedStates = Get.find();
  bool showPassword = false;
  String? accountId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back(closeOverlays: true);
          },
        ),
        elevation: 1,
        title: Column(
          children: [
            Text(
              'PROFILE',
              style: TextStyle(color: Colors.black87),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Get.toNamed(Routes.changePassword);
            },
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: Text('Change password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AuthServices.isLoggedIn()
                                ? NetworkImage(
                                    AuthServices.userLoggedIn.value.imageUrl!,
                                  )
                                : NetworkImage(
                                    'https://mcss.co.za/images/Member-Login.jpg'),
                          ),
                        )),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                          ),
                        )),
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              buildTextField(
                  "Name",
                  AuthServices.isLoggedIn()
                      ? AuthServices.userLoggedIn.value.name.toString()
                      : "Not sigin",
                  false),
              buildTextField(
                  "Email",
                  AuthServices.isLoggedIn()
                      ? AuthServices.userLoggedIn.value.email.toString()
                      : "Not sigin",
                  false),
              buildTextField(
                  "Phone",
                  AuthServices.isLoggedIn()
                      ? AuthServices.userLoggedIn.value.phone.toString()
                      : "Not sigin",
                  false),
              SizedBox(
                height: 35,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 63,
                    vertical: 13,
                  ),
                  child: SizedBox(
                    width: 167,
                    height: 19,
                    child: Text(
                      "SAVE",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    color: Color(0xff2AD4D3),
                    borderRadius: BorderRadius.circular(4)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          obscureText: isPasswordTextField ? showPassword : false,
          decoration: InputDecoration(
              suffixIcon: isPasswordTextField
                  ? IconButton(
                      onPressed: () {
                        // setState(() {
                        //   showPassword = !showPassword;
                        // });
                      },
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                    )
                  : null,
              contentPadding: EdgeInsets.only(bottom: 3),
              labelText: labelText,
              labelStyle: TextStyle(
                fontSize: 18,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              hintText: placeholder,
              hintStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              )),
        ),
      ),
    );
  }
}
