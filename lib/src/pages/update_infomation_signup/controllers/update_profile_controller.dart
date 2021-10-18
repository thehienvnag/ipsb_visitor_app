import 'package:bot_toast/bot_toast.dart';
import 'package:ipsb_visitor_app/src/services/api/account_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';

class UpdateProfileController extends GetxController {
  final SharedStates sharedStates = Get.find();
  final IAccountService accountService = Get.find();

  ImagePicker _imagePicker = Get.find();
  final filePath = ''.obs;

  // Pick Image of visitor
  Future<void> getImage() async {
    final picked = await _imagePicker.pickImage(source: ImageSource.gallery);
    filePath.value = picked?.path ?? '';
  }

  // User login with phone
  User? user;

  // password of visitor
  final password = "".obs;

  // set password
  void setPassword(String pass) {
    password.value = pass;
  }

  // RePassword of visitor
  final rePassword = "".obs;

  // set rePassword
  void setRePassword(String rePass) {
    rePassword.value = rePass;
  }

  // userName of visitor
  final userName = "".obs;

  // set userName
  void setUserName(String name) {
    userName.value = name;
  }

  // Image of visitor
  final image = "".obs;

  // set userName
  void setImage(String imageUrl) {
    image.value = imageUrl;
  }

  // Show password
  final isShowPass = true.obs;

  // Change show password
  void changeShowPass() {
    isShowPass.value = !isShowPass.value;
  }

  // Show Repassword
  final isRePass = true.obs;

  // Change show Repassword
  void changeShowRePass() {
    isRePass.value = !isRePass.value;
  }

  void checkRePassword() async {
    if (!AuthServices.isLoggedIn()) return;
    if (userName.value.isNotEmpty &&
        password.value.isNotEmpty &&
        rePassword.value.isNotEmpty &&
        filePath.isNotEmpty) {
      BotToast.showLoading();
      if (password.value == rePassword.value) {
        int id = AuthServices.userLoggedIn.value.id!;
        bool result = await accountService.updateProfile(
          id,
          {
            "name": userName.value,
            "password": password.value,
          },
          filePath.value,
        );
        if (result) {
          BotToast.showText(
            text: "Sign Up Success",
            duration: const Duration(seconds: 4),
          );
          Get.toNamed(Routes.home);
        }
      } else {
        BotToast.showText(
            text: "Your passord not match ! Please try again",
            textStyle: TextStyle(fontSize: 16),
            duration: const Duration(seconds: 7));
      }
      BotToast.closeAllLoading();
    } else {
      BotToast.showText(
          text: "Required Information!",
          textStyle: TextStyle(fontSize: 16),
          duration: const Duration(seconds: 5));
    }
  }
}
