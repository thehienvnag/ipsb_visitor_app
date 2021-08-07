
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

  // code send to visitor phone
  final codeSend = "".obs;

  // set code send
  void setCodeSend(String code){
    codeSend.value = code;
  }

  // phone of visitor
  final phoneNumber = "".obs;

  // set phone
  void setPhone(String phone){
    phoneNumber.value = phone;
  }

  void sendCodeToPhone(String phone) async {
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
        setCodeSend(verificationId);
        setPhone(phone);
        Get.toNamed(Routes.phoneVerify);
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }

  void verifyCodeFromPhone() async {
    PhoneAuthCredential phoneAuthCredential =
    PhoneAuthProvider.credential(verificationId: codeSend.value, smsCode: otpController.text);
    try {
      final authCredential = await _auth.signInWithCredential(phoneAuthCredential);
      if(authCredential.user != null){
        BotToast.showText(text: "Đăng nhập thành công", duration: const Duration(seconds: 5));
        Get.toNamed(Routes.home);
        print('thông tin đăng nhập bằng sdt nè: ' +authCredential.user.toString() );
      }
    }on FirebaseAuthException catch (e) {
      BotToast.showText(text: "Error during process: " + e.message.toString(),
          textStyle: TextStyle(fontSize: 16),
          duration: const Duration(seconds: 7));
    }
  }

}
