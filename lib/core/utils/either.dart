/// Functional error-handling type that holds either a [Left] (failure)
/// or a [Right] (success) value, eliminating the need for try/catch at
/// every call site.
sealed class Either<L, R> {
  const Either();

  /// `true` when this instance carries a failure value.
  bool get isLeft => this is Left<L, R>;

  /// `true` when this instance carries a success value.
  bool get isRight => this is Right<L, R>;

  /// Unwraps the value by applying [onLeft] for failures or [onRight] for
  /// successes, returning the result of whichever branch runs.
  T fold<T>(T Function(L) onLeft, T Function(R) onRight) {
    if (this is Left<L, R>) return onLeft((this as Left<L, R>).value);
    return onRight((this as Right<L, R>).value);
  }
}

/// The failure (left) branch of [Either].
final class Left<L, R> extends Either<L, R> {
  final L value;
  const Left(this.value);
}

/// The success (right) branch of [Either].
final class Right<L, R> extends Either<L, R> {
  final R value;
  const Right(this.value);
}

/// Convenience constructor for the failure branch.
Either<L, R> left<L, R>(L value) => Left(value);

/// Convenience constructor for the success branch.
Either<L, R> right<L, R>(R value) => Right(value);
