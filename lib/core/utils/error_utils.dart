String cleanErrorMessage(dynamic error) {
  final String errorString = error.toString();

  if (errorString.contains('Failed host lookup') ||
      errorString.contains('SocketException') ||
      errorString.contains('connection error') ||
      errorString.contains('Connection timed out') ||
      errorString.contains('Network is unreachable') ||
      errorString.contains('DioExceptionType.connectionTimeout') ||
      errorString.contains('DioExceptionType.receiveTimeout') ||
      errorString.contains('DioExceptionType.sendTimeout')) {
    return 'Connection failed. Please check your internet connection and try again.';
  }

  if (errorString.contains('401') ||
      errorString.contains('Unauthorized') ||
      errorString.contains('Invalid API token')) {
    return 'Authentication failed. Please check your API token and try again.';
  }

  if (errorString.contains('404') || errorString.contains('not found')) {
    return 'Requested resource not found.';
  }

  if (errorString.contains('rate limit') || errorString.contains('429')) {
    return 'Too many requests. Please wait a moment and try again.';
  }

  if (errorString.startsWith('Exception: ')) {
    final message = errorString.substring('Exception: '.length);

    if (message.isNotEmpty) {
      if (message.contains('Failed to query VNDB API')) {
        return 'Failed to load visual novels from VNDB. Please try again.';
      }

      return message;
    }
  }

  return 'An unexpected error occurred. Please try again.';
}
