import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:ipsb_visitor_app/src/models/account.dart';
import 'package:ipsb_visitor_app/src/services/api/account_service.dart';
import 'package:ipsb_visitor_app/src/services/storage/secure_storage.dart';

class AuthServices {
  /// Retry count
  static const retry = 3;

  /// [Rx<Account>] user information logged in to app
  static final userLoggedIn = Account().obs;

  static bool isLoggedIn() => userLoggedIn.value.id != null;

  static Future<bool> loginWithFirebase(User userCredentials) async {
    IAccountService _accountService = Get.find();
    final idToken = await userCredentials.getIdToken();
    final accountInfo = await _accountService.loginWithFirebase(idToken);
    return saveAuthInfo(accountInfo);
  }

  static Future<bool> loginWithPhone(String phone, String password) async {
    IAccountService _accountService = Get.find();
    final accountInfo = await _accountService.loginWithPhone(phone, password);
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
    Response res = await callback.call();
    if (res.unauthorized && await resfreshToken()) {
      res = await callback.call();
    }
    if (res.statusCode == HttpStatus.forbidden) {
      AuthServiceHelper.showForbiddenDialog();
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
      SecureStorage.save(
        SecureStorage.accountId,
        accountInfo.id.toString(),
      );
      return true;
    }
    return false;
  }

  /// Save auth info
  static void logout() {
    userLoggedIn.value = Account();
    SecureStorage.delete(SecureStorage.refreshTokenKey);
    SecureStorage.delete(SecureStorage.refreshTokenKey);
    SecureStorage.delete(SecureStorage.accountId);
  }

  static void initUserFromPrevLogin() async {
    IAccountService accountService = Get.find();
    String? idStr = await SecureStorage.read(SecureStorage.accountId);
    if (idStr == null) return;
    int id = int.parse(idStr);
    final accountInfo = await accountService.getById(id);
    saveAuthInfo(accountInfo);
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
