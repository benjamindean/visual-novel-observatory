import 'package:flutter_test/flutter_test.dart';
import 'package:visual_novel_observatory/auth/providers/auth_provider.dart';

void main() {
  group('AuthState', () {
    test('requires token, username, and user id to authenticate', () {
      expect(const AuthState().isAuthenticated, isFalse);
      expect(
        const AuthState(token: 'token', username: 'user').isAuthenticated,
        isFalse,
      );
      expect(
        const AuthState(
          token: 'token',
          username: 'user',
          userId: 'u1',
        ).isAuthenticated,
        isTrue,
      );
    });

    test('uses an immutable empty permissions default', () {
      const state = AuthState();

      expect(state.permissions, isEmpty);
      expect(
        () => state.permissions.add('listwrite'),
        throwsUnsupportedError,
      );
    });
  });
}
