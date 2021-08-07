import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';

class LoginEmailController extends GetxController {

  // Share states across app
  final SharedStates sharedStates = Get.find();

  GoogleSignIn? _googleSignIn;
  User? _user;

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
    } catch (e) {
      log(e.toString());
    }
    print("Thông tin nè: " +_user.toString());
    if(_user!.email!.isNotEmpty){
      BotToast.showText(text: "Đăng nhập thành công");
      sharedStates.user = _user;
      Get.toNamed(Routes.home);
    }else{
      Get.toNamed(Routes.login);
    }
   // return _user;
  }


  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
    await _googleSignIn!.signOut();
    BotToast.showText(text: "Đăng xuất thành công");
  }

}
