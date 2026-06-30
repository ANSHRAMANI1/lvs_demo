import 'package:get/get.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/usecases/sign_in_with_google.dart';
import '../../presentation/login/controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
    Get.lazyPut<AuthRepositoryImpl>(
      () => AuthRepositoryImpl(Get.find<AuthRemoteDataSource>()),
    );
    Get.lazyPut<SignInWithGoogle>(
      () => SignInWithGoogle(Get.find<AuthRepositoryImpl>()),
    );
    Get.lazyPut<LoginController>(
      () => LoginController(Get.find<SignInWithGoogle>()),
    );
  }
}
