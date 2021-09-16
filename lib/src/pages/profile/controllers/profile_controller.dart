import 'package:bot_toast/bot_toast.dart';
import 'package:visitor_app/src/services/global_states/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:visitor_app/src/routes/routes.dart';

class ProfileController extends GetxController {
  Future<void> logOut() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    if (AuthServices.isLoggedIn()) {
      await FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut();
      AuthServices.logout();
      BotToast.showText(text: "Đăng xuất thành công");
    }
    Get.toNamed(Routes.home);
  }
}
