import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';


class UpdateProfileController extends GetxController {
  final SharedStates sharedStates = Get.find();

  ImagePicker _imagePicker = Get.find();
  final filePath = ''.obs;

  // Pick Image of visitor
  Future<void> getImage() async {
    final picked = await _imagePicker.getImage(source: ImageSource.gallery);
    filePath.value = picked?.path ?? '';
  }

  // User login with phone
  User? user;

  // password of visitor
  final password = "".obs;

  // set password
  void setPassword(String pass){
    password.value = pass;
  }
  // RePassword of visitor
  final rePassword = "".obs;

  // set rePassword
  void setRePassword(String RePass){
    rePassword.value = RePass;
  }

  // userName of visitor
  final userName = "".obs;

  // set userName
  void setUserName(String name){
    userName.value = name;
  }

  // Image of visitor
  final image = "".obs;

  // set userName
  void setImage(String imageUrl){
    image.value = imageUrl;
  }

  // Show password
  final isShowPass = true.obs;

  // Change show password
  void changeShowPass(){
    isShowPass.value = !isShowPass.value;
  }

  // Show Repassword
  final isRePass = true.obs;

  // Change show Repassword
  void changeShowRePass(){
    isRePass.value = !isRePass.value;
  }

  void checkRePassword(){
    if(userName.value.isNotEmpty && password.value.isNotEmpty && rePassword.value.isNotEmpty ){
      BotToast.showLoading();
      if(password.value.endsWith(rePassword.value)){
        // set thông tin gồm tên, phone, pass và lưu xuống DB
        //
        //
        BotToast.showText(text: "Sign Up Success", duration: const Duration(seconds: 5));
        Get.toNamed(Routes.home);
      }else{
        BotToast.showText(text: "Your passord not match ! Please try again",
            textStyle: TextStyle(fontSize: 16),
            duration: const Duration(seconds: 7));
      }
      BotToast.closeAllLoading();
    }else{
      BotToast.showText(text: "Required Information!",
          textStyle: TextStyle(fontSize: 16),
          duration: const Duration(seconds: 5));
    }
  }

}
