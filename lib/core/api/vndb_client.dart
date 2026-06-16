import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../vn/models/visual_novel.dart';

class VndbClient {
  static const String _baseUrl = 'https://api.vndb.org/kana';
  final Dio _dio;
  final String? _token;

  VndbClient({Dio? dio, String? token}) : _dio = dio ?? Dio(), _token = token {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.headers = {
      'Content-Type': 'application/json',
      if (_token != null) 'Authorization': 'Token $_token',
    };

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          debugPrint('--> ${options.method} ${options.uri}');

          return handler.next(options);
        },
        onResponse: (response, handler) {
          debugPrint(
            '<-- [${response.statusCode}] ${response.requestOptions.method} ${response.requestOptions.uri}',
          );

          return handler.next(response);
        },
        onError: (dioError, handler) {
          debugPrint(
            '<-- ERROR: ${dioError.message} for ${dioError.requestOptions.method} ${dioError.requestOptions.uri}',
          );

          return handler.next(dioError);
        },
      ),
    );
  }

  // Lightweight fields for list queries (home, search, library)
  static const String _vnFields =
      'title,alttitle,aliases,description,rating,votecount,released,platforms,languages,length,length_minutes,'
      'image{url,dims,thumbnail,sexual,violence},'
      'extlinks{id,name,label,url},'
      'developers{id,name,original},'
      'tags{id,name,spoiler,rating,category},'
      'screenshots{url,dims,thumbnail,sexual,violence},'
      'relations{id,relation,relation_official,title,image{url,dims,sexual,violence}}';

  /// Helper to send generic POST query to VNDB /vn endpoint
  Future<Map<String, dynamic>> _postVnQuery(Map<String, dynamic> body) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>('/vn', data: body);

      if (response.statusCode == 200 && response.data != null) {
        return response.data!;
      } else {
        throw Exception(
          'Failed to query VNDB API: Code ${response.statusCode}\nBody: ${response.data}',
        );
      }
    } on DioException catch (e) {
      throw Exception(
        'Failed to query VNDB API: ${e.message}\nBody: ${e.response?.data}',
      );
    }
  }

  /// Validate a token using the authinfo endpoint
  Future<Map<String, dynamic>> validateToken(String token) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '/authinfo',
        options: Options(headers: {'Authorization': 'Token $token'}),
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data!;
      } else {
        throw Exception(
          'Invalid API token or connection error. Code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception('Invalid API token or connection error: ${e.message}');
    }
  }

  /// Fetch relations for a given visual novel ID
  Future<List<Map<String, dynamic>>> getRelations(String vnId) async {
    final body = {
      'filters': ['id', '=', vnId],
      'fields':
          'relations{id, relation, relation_official, title, alttitle, image{url,dims,sexual,violence}, rating, votecount, released, platforms, languages, length, length_minutes, description, screenshots{url,dims,thumbnail,sexual,violence}}',
    };

    final response = await _postVnQuery(body);
    final results = response['results'] as List? ?? [];

    if (results.isEmpty) {
      return const [];
    }

    final vnData = results.first as Map<String, dynamic>;
    final relationsList = vnData['relations'] as List? ?? [];

    return relationsList.map((e) => e as Map<String, dynamic>).toList();
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

  Future<Map<String, dynamic>> getVisualNovels({
    required List<dynamic> filters,
    required int page,
    int resultsPerPage = 22,
    String? sort,
    bool reverse = true,
  }) async {
    final body = {
      'filters': filters,
      'fields': _vnFields,
      'sort': sort,
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

  Future<List<Map<String, dynamic>>> getUserListLabels() async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/ulist_labels');

      if (response.statusCode == 200 && response.data != null) {
        final labels = response.data!['labels'] as List? ?? [];

        return labels
            .map((e) => e as Map<String, dynamic>)
            .where((e) => e['id'] != 7)
            .toList();
      } else {
        throw Exception(
          'Failed to get ulist labels: Code ${response.statusCode}\nBody: ${response.data}',
        );
      }
    } on DioException catch (e) {
      throw Exception(
        'Failed to get ulist labels: ${e.message}\nBody: ${e.response?.data}',
      );
    }
  }

  Future<void> updateUserListEntry({
    required String vnId,
    int? vote,
    bool updateVote = false,
    List<int>? labels,
    bool updateLabels = false,
  }) async {
    final body = <String, dynamic>{};

    if (updateVote) {
      body['vote'] = vote;
    }

    if (updateLabels) {
      body['labels'] = labels ?? <int>[];
    }

    try {
      final response = await _dio.patch<dynamic>('/ulist/$vnId', data: body);

      if (response.statusCode == null ||
          response.statusCode! < 200 ||
          response.statusCode! >= 300) {
        throw Exception(
          'Failed to update ulist entry: Code ${response.statusCode}\nBody: ${response.data}',
        );
      }
    } on DioException catch (e) {
      throw Exception(
        'Failed to update ulist entry: ${e.message}\nBody: ${e.response?.data}',
      );
    }
  }

  Future<Map<String, dynamic>> getUserList({
    required String user,
    required int page,
    int resultsPerPage = 100,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/ulist',
        data: {
          'user': user,
          'fields': 'id, vote, labels{id}, vn{$_vnFields}',
          'results': resultsPerPage,
          'page': page,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data!;
      } else {
        throw Exception(
          'Failed to query ulist: Code ${response.statusCode}\nBody: ${response.data}',
        );
      }
    } on DioException catch (e) {
      throw Exception(
        'Failed to query ulist: ${e.message}\nBody: ${e.response?.data}',
      );
    }
  }

  Future<Map<String, dynamic>> getTagsPage({
    required int page,
    int resultsPerPage = 100,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        '/tag',
        data: {
          'fields': 'id, name, description, category',
          'results': resultsPerPage,
          'page': page,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return response.data!;
      } else {
        throw Exception(
          'Failed to query tags: Code ${response.statusCode}\nBody: ${response.data}',
        );
      }
    } on DioException catch (e) {
      throw Exception(
        'Failed to query tags: ${e.message}\nBody: ${e.response?.data}',
      );
    }
  }
}
