import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../core/usecases/usecase.dart';
import '../../../domain/usecases/sign_in_with_google.dart';

/// Controller for the login screen.
///
/// Exposes [isLoading] for the UI to show a spinner during authentication, and
/// [signInWithGoogle] which delegates to the use-case and handles the result.
class LoginController extends GetxController {
  /// Use-case injected via [LoginBinding].
  final SignInWithGoogle signInWithGoogleUseCase;

  LoginController(this.signInWithGoogleUseCase);

  /// `true` while the Google Sign-In flow is in progress.
  final RxBool isLoading = false.obs;

  /// Triggers the Google Sign-In flow.
  ///
  /// On success, replaces the navigation stack with [Routes.home].
  /// On failure, shows a snackbar with the error message.
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
