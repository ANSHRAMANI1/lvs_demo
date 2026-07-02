import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

/// Controller for the splash screen.
///
/// Waits for the logo animation to finish, then checks for an active Firebase
/// session and routes the user to either [Routes.home] or [Routes.login].
class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    _navigate();
  }

  Future<void> _navigate() async {
    // Hold the splash long enough for the scale+fade animation to complete.
    await Future.delayed(const Duration(milliseconds: 2200));
    final isSignedIn = FirebaseAuth.instance.currentUser != null;
    Get.offAllNamed(isSignedIn ? Routes.home : Routes.login);
  }
}
