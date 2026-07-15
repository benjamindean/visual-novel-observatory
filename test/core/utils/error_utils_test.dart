import 'package:flutter_test/flutter_test.dart';
import 'package:visual_novel_observatory/core/utils/error_utils.dart';

void main() {
  group('cleanErrorMessage', () {
    test('maps common network errors to an actionable message', () {
      const networkErrors = [
        'SocketException: Failed host lookup',
        'DioExceptionType.connectionTimeout',
        'Network is unreachable',
        'Connection timed out',
      ];

      for (final error in networkErrors) {
        expect(
          cleanErrorMessage(error),
          'Connection failed. Please check your internet connection and try again.',
        );
      }
    });

    test('maps authentication, missing resource, and rate limit errors', () {
      expect(
        cleanErrorMessage('401 Unauthorized'),
        'Authentication failed. Please check your API token and try again.',
      );
      expect(
        cleanErrorMessage('404 not found'),
        'Requested resource not found.',
      );
      expect(
        cleanErrorMessage('429 rate limit exceeded'),
        'Too many requests. Please wait a moment and try again.',
      );
    });

    test('unwraps useful Exception messages', () {
      expect(
        cleanErrorMessage(Exception('Something specific happened')),
        'Something specific happened',
      );
      expect(
        cleanErrorMessage(Exception('Failed to query VNDB API: bad response')),
        'Failed to load visual novels from VNDB. Please try again.',
      );
    });

    test('does not expose unknown exception details', () {
      expect(
        cleanErrorMessage(StateError('secret implementation detail')),
        'An unexpected error occurred. Please try again.',
      );
    });
  });
}
