import 'package:equatable/equatable.dart';

/// Core user representation in the domain layer.
///
/// Contains only the fields the app actually needs; all Firebase-specific
/// types are stripped away so the domain stays framework-agnostic.
class UserEntity extends Equatable {
  /// Firebase UID — stable, unique identifier for the account.
  final String uid;

  /// Primary email address associated with the Google account.
  final String email;

  /// Human-readable name shown in the UI.
  final String displayName;

  /// Remote URL of the Google profile photo. May be `null` when unavailable.
  final String? photoUrl;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.displayName,
    this.photoUrl,
  });

  @override
  List<Object?> get props => [uid, email, displayName, photoUrl];
}
