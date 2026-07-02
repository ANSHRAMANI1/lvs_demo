import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../app/routes/app_routes.dart';
import '../../../data/datasources/auth_remote_datasource.dart';
import '../../../domain/entities/stream_item_entity.dart';
import '../../../domain/usecases/get_stream_feed.dart';

/// Controller for the home screen.
///
/// Manages reactive state for the feed grid, tab/category selection, and
/// bottom-nav index. Also exposes [signOut] for the Profile tab.
class HomeController extends GetxController {
  /// Use-case injected via [HomeBinding].
  final GetStreamFeed getStreamFeedUseCase;

  final AuthRemoteDataSource _authDataSource = AuthRemoteDataSourceImpl();

  HomeController(this.getStreamFeedUseCase);

  /// The currently signed-in Firebase user (used by [ProfileTab]).
  User? get currentUser => FirebaseAuth.instance.currentUser;

  // ── Observable state ──────────────────────────────────────────────────────

  /// Index of the selected feed tab (Stream / Hot / Follow).
  final RxInt selectedTabIndex = 0.obs;

  /// Label of the selected country/category chip.
  final RxString selectedCategory = 'Global'.obs;

  /// Index of the selected bottom-navigation item.
  final RxInt selectedNavIndex = 0.obs;

  /// Current list of stream items shown in the grid.
  final RxList<StreamItemEntity> feedItems = <StreamItemEntity>[].obs;

  /// `true` while the feed is being fetched.
  final RxBool isLoading = true.obs;

  // ── Static data ───────────────────────────────────────────────────────────

  /// Labels for the horizontal feed tabs.
  final List<String> tabs = ['Stream', 'Hot', 'Follow'];

  /// Country/category chips rendered below the tab row.
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

  // ── Actions ───────────────────────────────────────────────────────────────

  /// Switches the active feed tab and refreshes the grid.
  void selectTab(int index) {
    selectedTabIndex.value = index;
    loadFeed();
  }

  /// Switches the active category chip and refreshes the grid.
  void selectCategory(String label) {
    selectedCategory.value = label;
    loadFeed();
  }

  /// Updates the active bottom-nav index (drives tab screen visibility).
  void selectNav(int index) {
    selectedNavIndex.value = index;
  }

  /// Fetches the feed from the use-case using the current tab/category filters.
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

  /// Signs the user out and navigates back to [Routes.login].
  Future<void> signOut() async {
    await _authDataSource.signOut();
    Get.offAllNamed(Routes.login);
  }
}
