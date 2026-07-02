import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../entities/user_entity.dart';

/// Contract for authentication operations in the domain layer.
///
/// Implemented by [AuthRepositoryImpl] in the data layer; depends only on
/// domain types so the domain stays independent of Firebase.
abstract class AuthRepository {
  /// Launches the Google Sign-In flow and returns the authenticated
  /// [UserEntity] on success, or an [AuthFailure] if the flow fails or is
  /// cancelled.
  Future<Either<Failure, UserEntity>> signInWithGoogle();

  /// Signs the current user out of both Firebase Auth and Google Sign-In.
  Future<void> signOut();

  /// `true` when a Firebase session is currently active.
  bool get isSignedIn;
}
