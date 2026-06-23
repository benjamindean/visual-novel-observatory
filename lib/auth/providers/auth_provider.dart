import 'dart:developer' as developer;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/api/vndb_client.dart';
import '../../core/storage/app_storage.dart';

class AuthState {
  const AuthState({
    this.token,
    this.username,
    this.userId,
    this.permissions = const [],
  });

  final String? token;
  final String? username;
  final String? userId;
  final List<String> permissions;

  bool get isAuthenticated {
    return token != null && username != null && userId != null;
  }
}

class AuthNotifier extends AsyncNotifier<AuthState> {
  static const String _tokenKey = 'vndb_api_token';
  static const String _usernameKey = 'vndb_username';
  static const String _userIdKey = 'vndb_user_id';
  static const String _permissionsKey = 'vndb_permissions';
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  @override
  AuthState build() {
    return ref.read(initialAuthStateProvider);
  }

  static Future<AuthState> loadInitialState() => _loadStoredAuth();

  Future<void> connect(String token) async {
    final authState = await _authenticateToken(token);
    final userId = authState.userId;

    if (userId == null) {
      throw StateError('VNDB did not return a user id for this token.');
    }

    await _saveAuth(authState);

    state = AsyncData(authState);
  }

  Future<void> disconnect() async {
    await _clearAuth();

    state = const AsyncData(AuthState());
  }

  static Future<AuthState> _loadStoredAuth() async {
    final box = AppStorage.mainBox;

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

    final cachedUsername = box.get(_usernameKey) as String?;
    final cachedUserId = box.get(_userIdKey) as String?;
    final cachedPermissions = box.get(_permissionsKey) as List<dynamic>?;

    if (secureToken == null || cachedUsername == null || cachedUserId == null) {
      return const AuthState();
    }

    return AuthState(
      token: secureToken,
      username: cachedUsername,
      userId: cachedUserId,
      permissions: cachedPermissions?.cast<String>() ?? const [],
    );
  }

  Future<AuthState> _authenticateToken(String token) async {
    final client = VndbClient();
    final authInfo = await client.validateToken(token);

    final username = authInfo['username'] as String? ?? 'Unknown User';
    final userId = authInfo['id'] as String?;
    final permissions = List<String>.from(
      authInfo['permissions'] as List? ?? [],
    );

    return AuthState(
      token: token,
      username: username,
      userId: userId,
      permissions: permissions,
    );
  }

  Future<void> _saveAuth(AuthState authState) async {
    final token = authState.token;
    final username = authState.username;
    final userId = authState.userId;

    if (token == null || username == null || userId == null) {
      throw StateError('Cannot persist an incomplete VNDB auth state.');
    }

    final box = AppStorage.mainBox;

    await _secureStorage.write(key: _tokenKey, value: token);
    await box.put(_usernameKey, username);
    await box.put(_userIdKey, userId);
    await box.put(_permissionsKey, authState.permissions);
  }

  Future<void> _clearAuth() async {
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

    await box.delete(_usernameKey);
    await box.delete(_userIdKey);
    await box.delete(_permissionsKey);

    await AppStorage.libraryBox.clear();
    await AppStorage.labelsBox.clear();
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);

final initialAuthStateProvider = Provider<AuthState>((ref) {
  return const AuthState();
});
