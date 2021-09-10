
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';

class LoginPhoneController extends GetxController {

  TextEditingController otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Share states across app
  final SharedStates sharedStates = Get.find();


  // code send to verify
  final codeVerifile = "".obs;

  // set code verify
  void setCodeVerify(String code){
    codeVerifile.value = code;
  }

  // phone of visitor
  final phoneNumber = "".obs;

  // set phone
  void setPhone(String phone){
    phoneNumber.value = phone;
  }

  void sendCodeToPhone(String phone) async {
    BotToast.showLoading();
    await _auth.verifyPhoneNumber(
      phoneNumber: '+84'+ phone,
      verificationCompleted: (phoneAuthCredential) {
        print('Nothing here guys => verifiCompleted');
      },
      verificationFailed: (verificationFailed) async {
        if(verificationFailed.message!.contains("We have blocked all requests from this device due to unusual activity. Try again later.")){
          BotToast.showText(text: "Bạn đã thử nhiều lần, vui lòng thử lại sau !",
              textStyle: TextStyle(fontSize: 16),
              duration: const Duration(seconds: 7));
        }
        if(verificationFailed.message!.contains("phone numbers are written in the format [+][country code][subscriber number including area code]")){
          BotToast.showText(text: "Sai định dạng. +84[SDT của bạn]",
              textStyle: TextStyle(fontSize: 16),
              duration: const Duration(seconds: 7));
        }
      },
      codeSent: (verificationId, resendingToken) async {
        // verificationID: nó là mã code gì đó dc gửi đi cho bên verifile xử lý
        setCodeVerify(verificationId);
        setPhone(phone);
        BotToast.closeAllLoading();
        Get.toNamed(Routes.phoneVerify);
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }

  void verifyCodeFromPhone(String code) async {

    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: codeVerifile.value, smsCode: code);
    try {
      BotToast.showLoading();
      final authCredential = await _auth.signInWithCredential(phoneAuthCredential);
      if(authCredential.user != null){
        BotToast.closeAllLoading();
        BotToast.showText(text: "Verification Success", duration: const Duration(seconds: 5));
        Get.toNamed(Routes.updateProfile);
        print('thông tin đăng nhập bằng sdt nè: ' +authCredential.user.toString() );
      }
    }on FirebaseAuthException catch (e) {
      BotToast.showText(text: "Error during process: " + e.message.toString(),
          textStyle: TextStyle(fontSize: 16),
          duration: const Duration(seconds: 7));
    }
  }

}
