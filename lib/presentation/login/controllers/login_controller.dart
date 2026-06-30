import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/usecases/sign_in_with_google.dart';

class LoginController extends GetxController {
  final SignInWithGoogle signInWithGoogleUseCase;

  LoginController(this.signInWithGoogleUseCase);

  final RxBool isLoading = false.obs;

  Future<void> signInWithGoogle() async {
    isLoading.value = true;
    final result = await signInWithGoogleUseCase(NoParams());
    result.fold(
      (failure) {
        Get.snackbar(
          'Login Failed',
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color(0xFF1E1E1E),
          colorText: const Color(0xFFFFFFFF),
          margin: const EdgeInsets.all(16),
          borderRadius: 12,
        );
      },
      (user) => Get.offAllNamed(Routes.home),
    );
    isLoading.value = false;
  }
}
