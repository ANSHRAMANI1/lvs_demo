import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_colors.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 32),
                      Center(child: _LogoSection()),
                      const SizedBox(height: 28),
                      const _WelcomeText(),
                      const SizedBox(height: 28),
                      const _EmailField(),
                      const SizedBox(height: 16),
                      const _PasswordField(),
                      const SizedBox(height: 12),
                      const _ForgotPassword(),
                      const SizedBox(height: 28),
                      const _LoginButton(),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
          ),
          _SocialSection(controller: controller),
        ],
      ),
    );
  }
}

class _LogoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: AppColors.primaryGradient,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Image.asset(
          'assets/images/logo.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, trace) => const Icon(
            Icons.videocam_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }
}

class _WelcomeText extends StatelessWidget {
  const _WelcomeText();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome back! 👋',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1A1A1A),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Sign in to continue your live streaming journey.',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade500, height: 1.4),
        ),
      ],
    );
  }
}

class _EmailField extends StatelessWidget {
  const _EmailField();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email ID or Phone Number',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF333333)),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A1A)),
          decoration: InputDecoration(
            hintText: 'Enter Registered Email or Phone No.',
            hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _PasswordField extends StatefulWidget {
  const _PasswordField();

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Password',
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF333333)),
        ),
        const SizedBox(height: 8),
        TextField(
          obscureText: _obscure,
          style: const TextStyle(fontSize: 14, color: Color(0xFF1A1A1A)),
          decoration: InputDecoration(
            hintText: 'Enter your password',
            hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
            filled: true,
            fillColor: const Color(0xFFF5F5F5),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                _obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                color: Colors.grey.shade400,
                size: 20,
              ),
              onPressed: () => setState(() => _obscure = !_obscure),
            ),
          ),
        ),
      ],
    );
  }
}

class _ForgotPassword extends StatelessWidget {
  const _ForgotPassword();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: GestureDetector(
        onTap: () {},
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
            decoration: TextDecoration.underline,
            decorationColor: AppColors.primary,
          ),
        ),
      ),
    );
  }
}

// No observables used — plain widget, no Obx
class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.snackbar(
        'Login',
        'Please use "Continue with Google" to sign in.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColors.surface,
        colorText: Colors.white,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
      ),
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.35),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            'Login',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white, letterSpacing: 0.5),
          ),
        ),
      ),
    );
  }
}

// ClipPath gives this section a bounded layout — no overflow possible
class _SocialSection extends StatelessWidget {
  final LoginController controller;
  const _SocialSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: _WaveClipper(),
      child: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF7ED321), Color(0xFF4CAF50)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 44, 24, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'or continue with',
                  style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.85)),
                ),
                const SizedBox(height: 14),
                // Observable read directly inside Obx closure — proper GetX tracking
                Obx(() {
                  final isLoading = controller.isLoading.value;
                  return _SocialButton(
                    onTap: isLoading ? null : controller.signInWithGoogle,
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation(AppColors.primary),
                            ),
                          )
                        : const _GoogleContent(),
                  );
                }),
                const SizedBox(height: 10),
                const _SocialButton(onTap: null, child: _FacebookContent()),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(fontSize: 13, color: Colors.white.withValues(alpha: 0.8)),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  const _SocialButton({required this.onTap, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}

class _GoogleContent extends StatelessWidget {
  const _GoogleContent();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.network(
          'https://www.google.com/favicon.ico',
          width: 20,
          height: 20,
          errorBuilder: (context, error, trace) =>
              const Icon(Icons.g_mobiledata_rounded, color: Color(0xFF4285F4), size: 24),
        ),
        const SizedBox(width: 10),
        const Text(
          'Continue with Google',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF333333)),
        ),
      ],
    );
  }
}

class _FacebookContent extends StatelessWidget {
  const _FacebookContent();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.facebook_rounded, color: Color(0xFF1877F2), size: 22),
        SizedBox(width: 10),
        Text(
          'Continue with Facebook',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF333333)),
        ),
      ],
    );
  }
}

class _WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(0, 32)
      ..quadraticBezierTo(size.width * 0.25, 0, size.width * 0.5, 18)
      ..quadraticBezierTo(size.width * 0.75, 36, size.width, 10)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
