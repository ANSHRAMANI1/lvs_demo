import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../../domain/entities/stream_item_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource dataSource;

  HomeRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, List<StreamItemEntity>>> getStreamFeed({
    String? category,
    String? tab,
  }) {
    return dataSource.getStreamFeed(category: category, tab: tab);
  }
}
