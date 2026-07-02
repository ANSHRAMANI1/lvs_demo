import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../core/errors/failures.dart';
import '../../core/utils/either.dart';
import '../models/user_model.dart';

/// Contract for remote authentication operations (data layer).
abstract class AuthRemoteDataSource {
  /// Launches the Google Sign-In flow and signs the credential into Firebase.
  Future<Either<Failure, UserModel>> signInWithGoogle();

  /// Clears both the Firebase Auth session and the Google account token.
  Future<void> signOut();

  /// `true` when a Firebase session is currently active.
  bool get isSignedIn;
}

/// Firebase + Google Sign-In implementation of [AuthRemoteDataSource].
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  bool get isSignedIn => _auth.currentUser != null;

  @override
  Future<Either<Failure, UserModel>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User dismissed the account picker without selecting an account.
        return left(const AuthFailure('Sign-in cancelled by user'));
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user!;

      return right(UserModel.fromFirebase(
        user.uid,
        user.email,
        user.displayName,
        user.photoURL,
      ));
    } catch (e) {
      return left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<void> signOut() async {
    // Sign out from both services concurrently to avoid partial state.
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}
