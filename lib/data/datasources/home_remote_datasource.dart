import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../models/stream_item_model.dart';

abstract class HomeRemoteDataSource {
  Future<Either<Failure, List<StreamItemModel>>> getStreamFeed({
    String? category,
    String? tab,
  });
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  // Stubbed data — replace with real Dio call when API is available
  @override
  Future<Either<Failure, List<StreamItemModel>>> getStreamFeed({
    String? category,
    String? tab,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    final items = _dummyFeed.where((item) {
      if (category != null && category != 'Global') {
        return item.category == category;
      }
      return true;
    }).toList();

    return right(items);
  }

  static final _dummyFeed = [
    const StreamItemModel(
      id: '1',
      streamerName: 'Priya Sharma',
      thumbnailUrl: 'https://picsum.photos/seed/s1/300/400',
      countryFlag: '🇮🇳',
      viewerCount: 1243,
      isLive: true,
      category: 'India',
    ),
    const StreamItemModel(
      id: '2',
      streamerName: 'Maria Santos',
      thumbnailUrl: 'https://picsum.photos/seed/s2/300/400',
      countryFlag: '🇵🇭',
      viewerCount: 876,
      isLive: true,
      category: 'Philippines',
    ),
    const StreamItemModel(
      id: '3',
      streamerName: 'Carlos Silva',
      thumbnailUrl: 'https://picsum.photos/seed/s3/300/400',
      countryFlag: '🇧🇷',
      viewerCount: 2104,
      isLive: true,
      category: 'Brazil',
    ),
    const StreamItemModel(
      id: '4',
      streamerName: 'Yuki Tanaka',
      thumbnailUrl: 'https://picsum.photos/seed/s4/300/400',
      countryFlag: '🇯🇵',
      viewerCount: 543,
      isLive: false,
      category: 'Japan',
    ),
    const StreamItemModel(
      id: '5',
      streamerName: 'Aisha Khan',
      thumbnailUrl: 'https://picsum.photos/seed/s5/300/400',
      countryFlag: '🇵🇰',
      viewerCount: 3201,
      isLive: true,
      category: 'Pakistan',
    ),
    const StreamItemModel(
      id: '6',
      streamerName: 'Emma Wilson',
      thumbnailUrl: 'https://picsum.photos/seed/s6/300/400',
      countryFlag: '🇺🇸',
      viewerCount: 1890,
      isLive: true,
      category: 'Global',
    ),
    const StreamItemModel(
      id: '7',
      streamerName: 'Rina Patel',
      thumbnailUrl: 'https://picsum.photos/seed/s7/300/400',
      countryFlag: '🇮🇳',
      viewerCount: 720,
      isLive: true,
      category: 'India',
    ),
    const StreamItemModel(
      id: '8',
      streamerName: 'Sofia Garcia',
      thumbnailUrl: 'https://picsum.photos/seed/s8/300/400',
      countryFlag: '🇲🇽',
      viewerCount: 456,
      isLive: false,
      category: 'Global',
    ),
  ];
}
