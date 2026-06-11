import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/api/vndb_client.dart';

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

  @override
  AuthState build() {
    return AuthState();
  }

  Future<void> loadCachedAuth() async {
    final prefs = await SharedPreferences.getInstance();

    final cachedToken = prefs.getString(_tokenKey);
    final cachedUsername = prefs.getString(_usernameKey);
    final cachedUserId = prefs.getString(_userIdKey);
    final cachedPermissions = prefs.getStringList(_permissionsKey);

    if (cachedToken != null && cachedUsername != null && cachedUserId != null) {
      state = AuthState(
        token: cachedToken,
        username: cachedUsername,
        userId: cachedUserId,
        permissions: cachedPermissions ?? const [],
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

      final prefs = await SharedPreferences.getInstance();

      await prefs.setString(_tokenKey, token);
      await prefs.setString(_usernameKey, username);
      await prefs.setString(_userIdKey, userId);
      await prefs.setStringList(_permissionsKey, permissions);

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
        errorMessage: () => e.toString(),
      );

      return false;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_tokenKey);
    await prefs.remove(_usernameKey);
    await prefs.remove(_userIdKey);
    await prefs.remove(_permissionsKey);

    state = AuthState();
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
