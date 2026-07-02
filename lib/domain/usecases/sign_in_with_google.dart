import '../../core/errors/failures.dart';
import '../../core/usecases/usecase.dart';
import '../../core/utils/either.dart';
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

/// Use-case that triggers the Google Sign-In flow.
///
/// Takes no input ([NoParams]) and returns the authenticated [UserEntity]
/// on success or an [AuthFailure] on cancellation / error.
class SignInWithGoogle extends UseCase<UserEntity, NoParams> {
  /// The auth repository injected at construction time.
  final AuthRepository repository;

  SignInWithGoogle(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(NoParams params) {
    return repository.signInWithGoogle();
  }
}
