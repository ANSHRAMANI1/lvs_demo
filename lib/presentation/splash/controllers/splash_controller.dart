import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 2200));
    final isSignedIn = FirebaseAuth.instance.currentUser != null;
    Get.offAllNamed(isSignedIn ? Routes.home : Routes.login);
  }
}
