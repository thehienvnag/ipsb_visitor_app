import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:indoor_positioning_visitor/src/models/account.dart';
import 'package:indoor_positioning_visitor/src/services/api/account_service.dart';
import 'package:indoor_positioning_visitor/src/services/storage/secure_storage.dart';

class AuthServices {
  /// Retry count
  static const retry = 3;

  /// [Rx<Account>] user information logged in to app
  static final userLoggedIn = Account().obs;

  static bool isLoggedIn() => userLoggedIn.value.id != null;

  static Future<bool> loginWithFirebase(User userCredentials) async {
    print(await userCredentials.getIdToken());
    IAccountService _accountService = Get.find();
    final idToken = await userCredentials.getIdToken();
    final accountInfo = await _accountService.loginWithFirebase(idToken);
    return saveAuthInfo(accountInfo);
  }

  static Future<String> getAuthHeader() async {
    String? accessToken = isLoggedIn()
        ? userLoggedIn.value.accessToken
        : await SecureStorage.read(SecureStorage.accessTokenKey);
    return 'Bearer ${accessToken ?? ''}';
  }

  static Future<Response> handleUnauthorized(
    Future<Response> Function() callback,
  ) async {
    late Response res;
    int currentRetry = retry;
    for (int i = currentRetry; i > 0; i--) {
      res = await callback.call();
      if (!res.unauthorized) {
        if (res.statusCode == HttpStatus.forbidden) {
          AuthServiceHelper.showForbiddenDialog();
        }
        break;
      }
      print("Unauthorized, retryCount: $i");
      if (await resfreshToken()) break;
    }
    return res;
  }

  /// Refresh token
  static Future<bool> resfreshToken() async {
    IAccountService _accountService = Get.find();
    final refreshToken =
        await SecureStorage.read(SecureStorage.refreshTokenKey);
    if (refreshToken != null) {
      final account = await _accountService.refreshToken(refreshToken);
      return saveAuthInfo(account);
    }
    return false;
  }

  /// Save auth info
  static bool saveAuthInfo(Account? accountInfo) {
    if (accountInfo != null) {
      userLoggedIn.value = accountInfo;
      SecureStorage.save(
        SecureStorage.refreshTokenKey,
        accountInfo.refreshToken,
      );
      SecureStorage.save(
        SecureStorage.refreshTokenKey,
        accountInfo.refreshToken,
      );
      return true;
    }
    return false;
  }
}

class AuthServiceHelper {
  /// Phone key data post
  static const String phoneKey = "phone";

  /// Email key data post
  static const String emailKey = "email";

  /// Idtoken data post
  static const String idTokenKey = "idToken";

  static void showForbiddenDialog() {
    Get.dialog(AlertDialog(
      title: Text("Error"),
      content: Text("Resource access is forbidden!"),
      actions: [
        ElevatedButton(
          onPressed: () => Get.back(),
          child: Text("OK"),
        )
      ],
    ));
  }
}
