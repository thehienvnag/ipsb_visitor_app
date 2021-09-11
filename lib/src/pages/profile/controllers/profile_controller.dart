import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:indoor_positioning_visitor/src/routes/routes.dart';
import 'package:indoor_positioning_visitor/src/services/global_states/shared_states.dart';

class ProfileController extends GetxController {
  // Share states across app
  final SharedStates sharedStates = Get.find();

  Future<void> logOut() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    if (sharedStates.user != null) {
      await FirebaseAuth.instance.signOut();
      await _googleSignIn.signOut();
      sharedStates.user = null;
      BotToast.showText(text: "Đăng xuất thành công");
    }
    Get.toNamed(Routes.home);
  }
}
