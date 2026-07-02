import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

/// Concrete implementation of [AuthRepository].
///
/// Acts as a thin bridge between the domain layer and [AuthRemoteDataSource].
/// Because [UserModel] extends [UserEntity], no explicit mapping is required.
class AuthRepositoryImpl implements AuthRepository {
  /// The data source injected at construction time (e.g. via [LoginBinding]).
  final AuthRemoteDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  bool get isSignedIn => dataSource.isSignedIn;

  @override
  Future<Either<Failure, UserEntity>> signInWithGoogle() {
    return dataSource.signInWithGoogle();
  }

  @override
  Future<void> signOut() {
    return dataSource.signOut();
  }
}
