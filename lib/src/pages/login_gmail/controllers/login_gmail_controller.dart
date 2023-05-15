import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';
import 'package:ipsb_visitor_app/src/services/global_states/shared_states.dart';
import 'package:ipsb_visitor_app/src/utils/firebase_helper.dart';

class LoginEmailController extends GetxController {
  // Share states across app
  final SharedStates sharedStates = Get.find();

  GoogleSignIn? _googleSignIn;

  // Show password
  final isShowPass = true.obs;

  // Save change show password
  void changeIshowPass() {
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
        accessToken: googleSignInAuthentication.accessToken,
      );

      UserCredential result =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (result.user != null) {
        /// Login with firebase
        bool successLogin = await AuthServices.loginWithFirebase(result.user!);
        if (successLogin) {
          FirebaseHelper helper = new FirebaseHelper();
          await helper.subscribeToTopic(
              "account_id_" + AuthServices.userLoggedIn.value.id.toString());
          BotToast.showText(text: "Sign In Successfull");
          Get.back();
        } else {
          BotToast.showText(text: "Sign In Failed");
        }
      }
    } catch (e) {
      log("Lỗi: " + e.toString());
      BotToast.showText(text: "Sign In Failed");
    }
    BotToast.closeAllLoading();
  }

  void checkLoginWithPhoneAndPass(String phone, String pass) async {
    try {
      if (phone.isEmpty || pass.isEmpty) {
        BotToast.showText(
            text: "Required Information!",
            textStyle: TextStyle(fontSize: 16),
            duration: const Duration(seconds: 7));
        return;
      }
      BotToast.showLoading();
      bool successLogin = await AuthServices.loginWithPhone(phone, pass);
      if (successLogin) {
        FirebaseHelper helper = new FirebaseHelper();
        await helper.subscribeToTopic(
            "account_id_" + AuthServices.userLoggedIn.value.id.toString());
        BotToast.showText(text: "Sign In Successfull");
        Get.back();
      } else {
        BotToast.showText(
            text: "Your phone or password wrong ! Login In Failed");
      }
    } catch (e) {
      log("Lỗi: " + e.toString());
      BotToast.showText(text: "Your phone or password wrong ! Login In Failed");
    }
    BotToast.closeAllLoading();
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    if ((await _googleSignIn?.isSignedIn()) ?? false) {
      await _googleSignIn?.signOut();
    }
    BotToast.showText(text: "Logout Successfully");
  }
}
