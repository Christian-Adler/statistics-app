class ApiException implements Exception {
  final String _message;

  ApiException(this._message);

  @override
  String toString() {
    Type t = ApiException;
    return '$t: $message';
  }

  String get message {
    return _message;
  }
}
