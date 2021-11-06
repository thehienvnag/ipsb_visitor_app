import 'package:ipsb_visitor_app/src/common/endpoints.dart';
import 'package:ipsb_visitor_app/src/models/account.dart';

import 'base_service.dart';

mixin IAccountService {
  Future<Account?> loginWithFirebase(String idToken);
  Future<Account?> loginWithPhone(String phone, String password);
  Future<Account?> refreshToken(String refreshToken);
  Future<bool> changePassword(int accountId, String newPassword);
  Future<Account?> getById(int id);
  Future<bool> updateProfile(int id, Map<String, String> data, String filePath);
}

class AccountService extends BaseService<Account> with IAccountService {
  @override
  String endpoint() {
    return Endpoints.accounts;
  }

  @override
  Account fromJson(Map<String, dynamic> json) {
    return Account.fromJson(json);
  }

  @override
  Future<Account?> loginWithFirebase(String idToken) async {
    return postNoAuth(Endpoints.loginFirebase, {"idToken": idToken});
  }

  @override
  Future<Account?> refreshToken(String refreshToken) {
    return postNoAuth(Endpoints.refreshToken, {"refreshToken": refreshToken});
  }

  @override
  Future<Account?> getById(int id) {
    return getByIdBase(id);
  }

  @override
  Future<bool> updateProfile(
      int id, Map<String, String> data, String filePath) {
    return putWithOneFileBase(data, filePath, id);
  }

  @override
  Future<Account?> loginWithPhone(String phone, String password) {
    return postNoAuth(Endpoints.loginPhone, {
      "phone": phone,
      "password": password,
    });
  }

  @override
  Future<bool> changePassword(int accountId, String newPassword) {
    return putPure(Endpoints.changePassword, {
      "accountId": accountId,
      "password": newPassword,
    });
  }
}
