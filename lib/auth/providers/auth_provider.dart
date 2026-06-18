import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/storage/app_storage.dart';
import '../../core/api/vndb_client.dart';
import '../../core/utils/error_utils.dart';

class AuthState {
  final String? token;
  final String? username;
  final String? userId;
  final List<String> permissions;
  final bool isValidating;
  final String? errorMessage;

  AuthState({
    this.token,
    this.username,
    this.userId,
    this.permissions = const [],
    this.isValidating = false,
    this.errorMessage,
  });

  bool get isAuthenticated =>
      token != null && username != null && userId != null;

  AuthState copyWith({
    String? Function()? token,
    String? Function()? username,
    String? Function()? userId,
    List<String>? permissions,
    bool? isValidating,
    String? Function()? errorMessage,
  }) {
    return AuthState(
      token: token != null ? token() : this.token,
      username: username != null ? username() : this.username,
      userId: userId != null ? userId() : this.userId,
      permissions: permissions ?? this.permissions,
      isValidating: isValidating ?? this.isValidating,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }
}

class AuthNotifier extends Notifier<AuthState> {
  static const String _tokenKey = 'vndb_api_token';
  static const String _usernameKey = 'vndb_username';
  static const String _userIdKey = 'vndb_user_id';
  static const String _permissionsKey = 'vndb_permissions';
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  AuthState build() {
    return AuthState();
  }

  Future<void> loadCachedAuth() async {
    final box = AppStorage.mainBox;

    final legacyToken = box.get(_tokenKey) as String?;
    String? secureToken;

    try {
      secureToken = await _secureStorage.read(key: _tokenKey);
    } catch (error, stackTrace) {
      developer.log(
        'Failed to read VNDB token from secure storage.',
        name: 'AuthNotifier',
        error: error,
        stackTrace: stackTrace,
      );
    }

    final cachedToken = secureToken ?? legacyToken;
    final cachedUsername = box.get(_usernameKey) as String?;
    final cachedUserId = box.get(_userIdKey) as String?;
    final cachedPermissions = box.get(_permissionsKey) as List<dynamic>?;

    if (secureToken == null && legacyToken != null) {
      try {
        await _secureStorage.write(key: _tokenKey, value: legacyToken);
        await box.delete(_tokenKey);
      } catch (error, stackTrace) {
        developer.log(
          'Failed to migrate VNDB token to secure storage.',
          name: 'AuthNotifier',
          error: error,
          stackTrace: stackTrace,
        );
      }
    }

    if (cachedToken != null && cachedUsername != null && cachedUserId != null) {
      state = AuthState(
        token: cachedToken,
        username: cachedUsername,
        userId: cachedUserId,
        permissions: cachedPermissions?.cast<String>() ?? const [],
      );
    }
  }

  Future<bool> login(String token) async {
    state = state.copyWith(isValidating: true, errorMessage: () => null);

    final client = VndbClient();

    try {
      final authInfo = await client.validateToken(token);

      final username = authInfo['username'] as String? ?? 'Unknown User';
      final userId = authInfo['id'] as String? ?? 'unknown';
      final permissions = List<String>.from(
        authInfo['permissions'] as List? ?? [],
      );

      final box = AppStorage.mainBox;

      await _secureStorage.write(key: _tokenKey, value: token);
      await box.delete(_tokenKey);
      await box.put(_usernameKey, username);
      await box.put(_userIdKey, userId);
      await box.put(_permissionsKey, permissions);

      state = AuthState(
        token: token,
        username: username,
        userId: userId,
        permissions: permissions,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isValidating: false,
        errorMessage: () => cleanErrorMessage(e),
      );

      return false;
    }
  }

  Future<void> logout() async {
    final box = AppStorage.mainBox;

    try {
      await _secureStorage.delete(key: _tokenKey);
    } catch (error, stackTrace) {
      developer.log(
        'Failed to delete VNDB token from secure storage.',
        name: 'AuthNotifier',
        error: error,
        stackTrace: stackTrace,
      );
    }

    await box.delete(_tokenKey);
    await box.delete(_usernameKey);
    await box.delete(_userIdKey);
    await box.delete(_permissionsKey);

    await AppStorage.libraryBox.clear();
    await AppStorage.labelsBox.clear();

    state = AuthState();
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
