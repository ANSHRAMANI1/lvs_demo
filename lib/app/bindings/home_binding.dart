import 'package:get/get.dart';
import '../../data/datasources/home_remote_datasource.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/usecases/get_stream_feed.dart';
import '../../presentation/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeRemoteDataSource>(() => HomeRemoteDataSourceImpl());
    Get.lazyPut<HomeRepositoryImpl>(
      () => HomeRepositoryImpl(Get.find<HomeRemoteDataSource>()),
    );
    Get.lazyPut<GetStreamFeed>(
      () => GetStreamFeed(Get.find<HomeRepositoryImpl>()),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(Get.find<GetStreamFeed>()),
    );
  }
}
