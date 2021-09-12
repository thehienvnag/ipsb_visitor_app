import 'package:indoor_positioning_visitor/src/common/endpoints.dart';
import 'package:indoor_positioning_visitor/src/models/account.dart';

import 'base_service.dart';

mixin IAccountService {
  Future<Account?> loginWithFirebase(String idToken);
  Future<Account?> refreshToken(String refreshToken);
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
    return postPure(Endpoints.loginFirebase, {"idToken": idToken});
  }

  @override
  Future<Account?> refreshToken(String refreshToken) {
    return postPure(Endpoints.refreshToken, {"refreshToken": refreshToken});
  }
}
