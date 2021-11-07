import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ipsb_visitor_app/src/models/coupon_in_use.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/services/api/account_service.dart';
import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';


class ProfileDetailController extends GetxController {
  final IAccountService accountService = Get.find();

  // password of visitor
  final oldPassword = "".obs;

  // set password
  void setOldPassword(String pass) {
    oldPassword.value = pass;
  }

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

  // Show old password
  final isOldShowPass = true.obs;

  // Change show old password
  void changeOldShowPass() {
    isOldShowPass.value = !isOldShowPass.value;
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
    if (oldPassword.value.isNotEmpty && password.value.isNotEmpty && rePassword.value.isNotEmpty ) {
      BotToast.showLoading();
      if (password.value == rePassword.value) {
        int id = AuthServices.userLoggedIn.value.id!;
        bool result = await accountService.changePassword(
          id,
          {
            "accountId" : id.toString(),
            "oldPassword": oldPassword.value,
            "newPassword": password.value,
          },
        );
        if (result) {
          BotToast.showText(
            contentColor: Color(0xff64B0E7),
            text: "Change Success",
            textStyle: TextStyle(fontSize: 16,color: Color(0xfffcfcfc)),
            duration: const Duration(seconds: 4),
          );
          Get.toNamed(Routes.home);
        }else{
          BotToast.showText(
            contentColor: Color(0xffea2727),
            text: "Change Failed",
            textStyle: TextStyle(fontSize: 16,color: Color(0xfffcfcfc)),
            duration: const Duration(seconds: 4),
          );
        }
      } else {
        BotToast.showText(
            contentColor: Color(0xff64B0E7),
            text: "Your new passord not match ! Please try again",
            textStyle: TextStyle(fontSize: 16,color: Color(0xfffcfcfc)),
            duration: const Duration(seconds: 7));
      }
      BotToast.closeAllLoading();
    } else {
      BotToast.showText(
        contentColor: Color(0xffea2727),
          text: "Required Information!",
          textStyle: TextStyle(fontSize: 16,color: Color(0xfffcfcfc)),
          duration: const Duration(seconds: 5));
    }
  }
  void gotoChagePassPage() {
    Get.toNamed(Routes.changePassword);
  }
}
