import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
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
