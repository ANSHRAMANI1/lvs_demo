import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../entities/stream_item_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<StreamItemEntity>>> getStreamFeed({
    String? category,
    String? tab,
  });
}
