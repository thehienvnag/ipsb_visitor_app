import 'package:bot_toast/bot_toast.dart';
import 'package:ipsb_visitor_app/src/services/global_states/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ipsb_visitor_app/src/routes/routes.dart';
import 'package:ipsb_visitor_app/src/utils/firebase_helper.dart';

class ProfileController extends GetxController {
  Future<void> logOut() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();
    if (AuthServices.isLoggedIn()) {
      await FirebaseAuth.instance.signOut();
      try {
        await _googleSignIn.signOut();
      } catch (Exception) {}

      FirebaseHelper helper = new FirebaseHelper();
      await helper.unsubscribeFromTopic(
          "account_id_" + AuthServices.userLoggedIn.value.id.toString());
      AuthServices.logout();
      BotToast.showText(text: "Logout Success");
    }
    Get.offNamed(Routes.home);
  }
}
