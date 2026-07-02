import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../entities/stream_item_entity.dart';

/// Contract for home-screen data operations in the domain layer.
///
/// Implemented by [HomeRepositoryImpl]; swap the implementation to point at a
/// real REST endpoint without touching any domain or presentation code.
abstract class HomeRepository {
  /// Returns a filtered list of [StreamItemEntity] items for the feed grid.
  ///
  /// [category] filters by country/region label (e.g. `'India'`); pass `null`
  /// or `'Global'` to return all items.
  /// [tab] corresponds to the selected feed tab (`'Stream'`, `'Hot'`, `'Follow'`).
  Future<Either<Failure, List<StreamItemEntity>>> getStreamFeed({
    String? category,
    String? tab,
  });
}
