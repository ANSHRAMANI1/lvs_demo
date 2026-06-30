import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.email,
    required super.displayName,
    super.photoUrl,
  });

  factory UserModel.fromFirebase(String uid, String? email, String? displayName,
      String? photoUrl) {
    return UserModel(
      uid: uid,
      email: email ?? '',
      displayName: displayName ?? 'User',
      photoUrl: photoUrl,
    );
  }
}
