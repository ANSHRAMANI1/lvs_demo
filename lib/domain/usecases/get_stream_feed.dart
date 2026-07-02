import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../../core/utils/either.dart';
import '../entities/stream_item_entity.dart';
import '../repositories/home_repository.dart';

/// Input parameters for [GetStreamFeed].
class FeedParams {
  /// Active category filter (e.g. `'India'`). `null` / `'Global'` = no filter.
  final String? category;

  /// Active tab label (`'Stream'`, `'Hot'`, or `'Follow'`).
  final String? tab;

  const FeedParams({this.category, this.tab});
}

/// Use-case that fetches and filters the live-stream feed.
///
/// Called each time the user switches tabs or selects a country chip.
class GetStreamFeed extends UseCase<List<StreamItemEntity>, FeedParams> {
  /// The home repository injected at construction time.
  final HomeRepository repository;

  GetStreamFeed(this.repository);

  @override
  Future<Either<Failure, List<StreamItemEntity>>> call(FeedParams params) {
    return repository.getStreamFeed(
      category: params.category,
      tab: params.tab,
    );
  }
}
