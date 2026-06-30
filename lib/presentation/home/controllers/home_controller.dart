import 'package:get/get.dart';
import '../../../domain/entities/stream_item_entity.dart';
import '../../../domain/usecases/get_stream_feed.dart';

class HomeController extends GetxController {
  final GetStreamFeed getStreamFeedUseCase;

  HomeController(this.getStreamFeedUseCase);

  final RxInt selectedTabIndex = 0.obs;
  final RxString selectedCategory = 'Global'.obs;
  final RxInt selectedNavIndex = 0.obs;
  final RxList<StreamItemEntity> feedItems = <StreamItemEntity>[].obs;
  final RxBool isLoading = true.obs;

  final List<String> tabs = ['Stream', 'Hot', 'Follow'];
  final List<String> categories = [
    'Global',
    'India',
    'Philippines',
    'Brazil',
    'Japan',
    'Pakistan',
  ];

  @override
  void onInit() {
    super.onInit();
    loadFeed();
  }

  void selectTab(int index) {
    selectedTabIndex.value = index;
    loadFeed();
  }

  void selectCategory(String category) {
    selectedCategory.value = category;
    loadFeed();
  }

  void selectNav(int index) {
    selectedNavIndex.value = index;
  }

  Future<void> loadFeed() async {
    isLoading.value = true;
    final result = await getStreamFeedUseCase(
      FeedParams(
        category: selectedCategory.value,
        tab: tabs[selectedTabIndex.value],
      ),
    );
    result.fold(
      (failure) => Get.snackbar('Error', failure.message),
      (items) => feedItems.assignAll(items),
    );
    isLoading.value = false;
  }
}
