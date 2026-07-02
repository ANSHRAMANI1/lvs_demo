import '../errors/failures.dart';
import '../utils/either.dart';

/// Contract every use-case must satisfy.
///
/// [T] is the success type; [Params] carries the input data.
/// Returns [Either<Failure, T>] so callers handle errors without try/catch.
abstract class UseCase<T, Params> {
  /// Executes the use-case with the given [params].
  Future<Either<Failure, T>> call(Params params);
}

/// Placeholder used when a use-case requires no input parameters.
class NoParams {}
