import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../data/datasources/auth_remote_datasource.dart';
import '../../../domain/entities/stream_item_entity.dart';
import '../../../domain/usecases/get_stream_feed.dart';

class HomeController extends GetxController {
  final GetStreamFeed getStreamFeedUseCase;
  final AuthRemoteDataSource _authDataSource = AuthRemoteDataSourceImpl();

  HomeController(this.getStreamFeedUseCase);

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Future<void> signOut() async {
    await _authDataSource.signOut();
    Get.offAllNamed(Routes.login);
  }

  final RxInt selectedTabIndex = 0.obs;
  final RxString selectedCategory = 'Global'.obs;
  final RxInt selectedNavIndex = 0.obs;
  final RxList<StreamItemEntity> feedItems = <StreamItemEntity>[].obs;
  final RxBool isLoading = true.obs;

  final List<String> tabs = ['Stream', 'Hot', 'Follow'];

  final List<Map<String, String>> categories = [
    {'label': 'Global', 'flag': '🌐'},
    {'label': 'India', 'flag': '🇮🇳'},
    {'label': 'Philippines', 'flag': '🇵🇭'},
    {'label': 'Brazil', 'flag': '🇧🇷'},
    {'label': 'Japan', 'flag': '🇯🇵'},
    {'label': 'Pakistan', 'flag': '🇵🇰'},
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

  void selectCategory(String label) {
    selectedCategory.value = label;
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
