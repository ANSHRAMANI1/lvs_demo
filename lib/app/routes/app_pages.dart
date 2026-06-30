import 'package:get/get.dart';
import '../bindings/home_binding.dart';
import '../bindings/login_binding.dart';
import '../bindings/splash_binding.dart';
import '../../presentation/home/views/home_view.dart';
import '../../presentation/login/views/login_view.dart';
import '../../presentation/splash/views/splash_view.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
}
