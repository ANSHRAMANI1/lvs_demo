import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    final isSignedIn = FirebaseAuth.instance.currentUser != null;
    if (isSignedIn) {
      Get.offAllNamed(Routes.home);
    } else {
      Get.offNamed(Routes.login);
    }
  }
}
