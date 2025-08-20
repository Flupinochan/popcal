abstract class AppException implements Exception {
  const AppException(this.message, [this.cause]);

  final Exception? cause;
  final String message;

  @override
  String toString() => message;
}
