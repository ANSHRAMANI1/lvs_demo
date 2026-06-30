import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    // onReady fires after the first frame — navigator is guaranteed ready
    SchedulerBinding.instance.addPostFrameCallback((_) => _navigate());
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(milliseconds: 2200));
    final isSignedIn = FirebaseAuth.instance.currentUser != null;
    Get.offAllNamed(isSignedIn ? Routes.home : Routes.login);
  }
}
