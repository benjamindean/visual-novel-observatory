import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../domain/vn/models/visual_novel.dart';

class VndbClient {
  static const String _baseUrl = 'https://api.vndb.org/kana';
  final http.Client _client;
  final String? _token;

  VndbClient({http.Client? client, String? token})
    : _client = client ?? http.Client(),
      _token = token;

  // Selected fields for listing and detail screens
  static const String _vnFields =
      'title, alttitle, aliases, extlinks{id,name,label,url}, description, rating, votecount, released, platforms, languages, length, length_minutes, '
      'image{url,dims,thumbnail,sexual}, developers{id,name,original}, tags{id,name,spoiler}, screenshots{url,dims,thumbnail,sexual}';

  /// Helper to send generic POST query to VNDB /vn endpoint
  Future<Map<String, dynamic>> _postVnQuery(Map<String, dynamic> body) async {
    final uri = Uri.parse('$_baseUrl/vn');

    final response = await _client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Token $_token',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>;
    } else {
      throw Exception(
        'Failed to query VNDB API: Code ${response.statusCode}\nBody: ${utf8.decode(response.bodyBytes)}',
      );
    }
  }

  /// Validate a token using the authinfo endpoint
  Future<Map<String, dynamic>> validateToken(String token) async {
    final uri = Uri.parse('$_baseUrl/authinfo');

    final response = await _client.get(
      uri,
      headers: {'Authorization': 'Token $token'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>;
    } else {
      throw Exception(
        'Invalid API token or connection error. Code: ${response.statusCode}',
      );
    }
  }

  /// Get popular visual novels (highest rated with substantial vote counts)
  Future<Map<String, dynamic>> getPopularVisualNovels({
    required int page,
    int resultsPerPage = 15,
  }) async {
    final body = {
      'filters': [
        'and',
        ['rating', '>=', 70],
        ['votecount', '>=', 50],
      ],
      'fields': _vnFields,
      'sort': 'rating',
      'reverse': true,
      'results': resultsPerPage,
      'page': page,
      'count': true,
    };

    final data = await _postVnQuery(body);
    final results = data['results'] as List? ?? [];
    final vns = results
        .map((e) => VisualNovel.fromJson(e as Map<String, dynamic>))
        .toList();
    final hasMore = data['more'] as bool? ?? false;

    return {'vns': vns, 'hasMore': hasMore};
  }

  /// Search visual novels by text query
  Future<Map<String, dynamic>> searchVisualNovels({
    required String query,
    required int page,
    int resultsPerPage = 15,
  }) async {
    final body = {
      'filters': ['search', '=', query],
      'fields': _vnFields,
      'results': resultsPerPage,
      'page': page,
      'count': true,
    };

    final data = await _postVnQuery(body);
    final results = data['results'] as List? ?? [];
    final vns = results
        .map((e) => VisualNovel.fromJson(e as Map<String, dynamic>))
        .toList();
    final hasMore = data['more'] as bool? ?? false;

    return {'vns': vns, 'hasMore': hasMore};
  }

  /// Get visual novels filtered by a tag ID (paginated)
  Future<Map<String, dynamic>> getVisualNovelsByTag({
    required String tagId,
    required int page,
    int resultsPerPage = 15,
  }) async {
    final body = {
      'filters': ['tag', '=', tagId],
      'fields': _vnFields,
      'sort': 'rating',
      'reverse': true,
      'results': resultsPerPage,
      'page': page,
      'count': true,
    };

    final data = await _postVnQuery(body);
    final results = data['results'] as List? ?? [];
    final vns = results
        .map((e) => VisualNovel.fromJson(e as Map<String, dynamic>))
        .toList();
    final hasMore = data['more'] as bool? ?? false;

    return {'vns': vns, 'hasMore': hasMore};
  }

  /// Get visual novels with custom filters and search query
  Future<Map<String, dynamic>> getVisualNovels({
    required List<dynamic> filters,
    required int page,
    int resultsPerPage = 15,
    String? sort,
    bool reverse = true,
  }) async {
    final body = {
      'filters': filters,
      'fields': _vnFields,
      'sort': ?sort,
      if (sort != null) 'reverse': reverse,
      'results': resultsPerPage,
      'page': page,
      'count': true,
    };

    final data = await _postVnQuery(body);
    final results = data['results'] as List? ?? [];

    final vns = results
        .map((e) => VisualNovel.fromJson(e as Map<String, dynamic>))
        .toList();
    final hasMore = data['more'] as bool? ?? false;

    return {'vns': vns, 'hasMore': hasMore};
  }

  /// Get details for a single visual novel by id
  Future<VisualNovel> getVisualNovelDetails(String id) async {
    final body = {
      'filters': ['id', '=', id],
      'fields': _vnFields,
    };

    final data = await _postVnQuery(body);
    final results = data['results'] as List? ?? [];

    if (results.isEmpty) {
      throw Exception('Visual novel with ID $id not found.');
    }

    return VisualNovel.fromJson(results.first as Map<String, dynamic>);
  }
}
