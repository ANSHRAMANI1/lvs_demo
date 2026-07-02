import 'package:equatable/equatable.dart';

/// Base class for all domain-level failures.
///
/// Failures are typed error values returned from use-cases instead of
/// throwing exceptions, keeping error handling explicit in the call-site.
abstract class Failure extends Equatable {
  /// Human-readable description of what went wrong.
  final String message;
  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

/// Failure produced when Firebase / Google authentication fails or is
/// cancelled by the user.
class AuthFailure extends Failure {
  const AuthFailure(super.message);
}

/// Failure produced when a remote API call returns a non-2xx response.
class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

/// Failure produced when the device has no internet connectivity.
class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}
