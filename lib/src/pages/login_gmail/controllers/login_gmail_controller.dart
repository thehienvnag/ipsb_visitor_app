import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';

class LoginEmailController extends GetxController {

  // Share states across app
  final SharedStates sharedStates = Get.find();

  GoogleSignIn? _googleSignIn;
  User? _user;

  // Show password
  final isShowPass = true.obs;

  // Save change show password
  void changeIshowPass(){
    isShowPass.value = !isShowPass.value;
  }

  void loginWithGoogle() async {
    try {
      BotToast.showLoading();
      _googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn!.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      UserCredential result = await FirebaseAuth.instance.signInWithCredential(credential);

      _user = result.user;
      BotToast.closeAllLoading();
      if(_user.toString().isNotEmpty){
        BotToast.showText(text: "Sign In Successfull");
        sharedStates.user = _user;
        Get.toNamed(Routes.home);
      }else{
        Get.toNamed(Routes.login);
      }
    } catch (e) {
      log("Lỗi: "+ e.toString());
      BotToast.closeAllLoading();
      BotToast.showText(text: "Sign In Failed");
      Get.toNamed(Routes.login);
    }
    print("Thông tin nè: " +_user.toString());
  }

  void checkLoginWithPhoneAndPass(String phone, String pass){
    try{
      BotToast.showLoading();
      if(phone.isNotEmpty && pass.isNotEmpty){
        // lưu DB and User here

        BotToast.closeAllLoading();
        BotToast.showText(text: "Sign In Successfull",
            textStyle: TextStyle(fontSize: 16),
            duration: const Duration(seconds: 5));
        //Get.toNamed(Routes.home);
      }else{
        BotToast.showText(text: "Required Information!",
            textStyle: TextStyle(fontSize: 16),
            duration: const Duration(seconds: 7));
        BotToast.closeAllLoading();
      }
    }catch (e) {
      log("Lỗi: "+ e.toString());
      BotToast.closeAllLoading();
      BotToast.showText(text: "Your phone or password wrong ! Login In Failed");
      Get.toNamed(Routes.login);
    }
  }


  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn!.signOut();
    BotToast.showText(text: "Logout Successfully");
  }

}