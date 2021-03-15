/// Describes an action that can be performed in the application. An action can consist of
/// many different individual pieces of code but should always be kept to what the implementing
/// classes name indicates.
abstract class LogicAction<T> {
  Future<T> run();
}
