import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../../core/utils/either.dart';
import '../entities/stream_item_entity.dart';
import '../repositories/home_repository.dart';

class FeedParams {
  final String? category;
  final String? tab;
  const FeedParams({this.category, this.tab});
}

class GetStreamFeed extends UseCase<List<StreamItemEntity>, FeedParams> {
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
