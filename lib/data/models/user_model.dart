import '../../domain/entities/user_entity.dart';

/// Data-layer representation of a user.
///
/// Extends [UserEntity] so it can be passed directly to the domain layer
/// without an extra mapping step.
class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.displayName,
    super.photoUrl,
  });

  /// Constructs a [UserModel] from raw Firebase Auth fields.
  ///
  /// Nullable Firebase values are coerced to safe defaults so the rest of
  /// the app can treat [email] and [displayName] as non-null.
  factory UserModel.fromFirebase(
    String uid,
    String? email,
    String? displayName,
    String? photoUrl,
  ) {
    return UserModel(
      uid: uid,
      email: email ?? '',
      displayName: displayName ?? 'User',
      photoUrl: photoUrl,
    );
  }
}
