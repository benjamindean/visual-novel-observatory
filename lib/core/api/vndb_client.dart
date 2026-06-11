import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../vn/models/visual_novel.dart';

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
      'image{url,dims,thumbnail,sexual}, developers{id,name,original}, tags{id,name,spoiler,rating}, screenshots{url,dims,thumbnail,sexual}';

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

  /// Fetch user list custom and system labels
  Future<List<Map<String, dynamic>>> getUserListLabels() async {
    final uri = Uri.parse('$_baseUrl/ulist_labels');

    final response = await _client.get(
      uri,
      headers: {if (_token != null) 'Authorization': 'Token $_token'},
    );

    if (response.statusCode == 200) {
      final data =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      final labels = data['labels'] as List? ?? [];

      return labels.map((e) => e as Map<String, dynamic>).toList();
    } else {
      throw Exception(
        'Failed to get ulist labels: Code ${response.statusCode}\nBody: ${utf8.decode(response.bodyBytes)}',
      );
    }
  }

  /// Get user list entry for a specific visual novel
  Future<Map<String, dynamic>?> getUserListEntry(String vnId) async {
    final uri = Uri.parse('$_baseUrl/ulist');

    final response = await _client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Token $_token',
      },
      body: jsonEncode({
        'filters': ['id', '=', vnId],
        'fields': 'id, vote, labels{id}',
      }),
    );

    if (response.statusCode == 200) {
      final data =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;

      final results = data['results'] as List? ?? [];

      if (results.isNotEmpty) {
        return results.first as Map<String, dynamic>;
      }

      return null;
    } else {
      throw Exception(
        'Failed to query ulist entry: Code ${response.statusCode}\nBody: ${utf8.decode(response.bodyBytes)}',
      );
    }
  }

  /// Update user list entry with vote and labels
  Future<void> updateUserListEntry({
    required String vnId,
    int? vote,
    bool updateVote = false,
    List<int>? labels,
    bool updateLabels = false,
  }) async {
    final uri = Uri.parse('$_baseUrl/ulist/$vnId');

    final body = <String, dynamic>{};

    if (updateVote) {
      body['vote'] = vote;
    }

    if (updateLabels) {
      body['labels'] = labels ?? <int>[];
    }

    final response = await _client.patch(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Token $_token',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
        'Failed to update ulist entry: Code ${response.statusCode}\nBody: ${utf8.decode(response.bodyBytes)}',
      );
    }
  }

  /// Get user list entries (paginated)
  Future<Map<String, dynamic>> getUserList({
    required int page,
    int resultsPerPage = 100,
  }) async {
    final uri = Uri.parse('$_baseUrl/ulist');

    final response = await _client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Token $_token',
      },
      body: jsonEncode({
        'fields': 'id, vote, labels{id}',
        'results': resultsPerPage,
        'page': page,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>;
    } else {
      throw Exception(
        'Failed to query ulist: Code ${response.statusCode}\nBody: ${utf8.decode(response.bodyBytes)}',
      );
    }
  }

  /// Get tags page from VNDB database
  Future<Map<String, dynamic>> getTagsPage({
    required int page,
    int resultsPerPage = 100,
  }) async {
    final uri = Uri.parse('$_baseUrl/tag');

    final response = await _client.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        if (_token != null) 'Authorization': 'Token $_token',
      },
      body: jsonEncode({
        'fields': 'id, name, description, category',
        'results': resultsPerPage,
        'page': page,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes))
          as Map<String, dynamic>;
    } else {
      throw Exception(
        'Failed to query tags: Code ${response.statusCode}\nBody: ${utf8.decode(response.bodyBytes)}',
      );
    }
  }
}
