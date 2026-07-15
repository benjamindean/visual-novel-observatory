import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visual_novel_observatory/core/api/vndb_client.dart';

void main() {
  late Dio dio;
  late RecordingHttpClientAdapter adapter;

  setUp(() {
    dio = Dio();
    adapter = RecordingHttpClientAdapter();
    dio.httpClientAdapter = adapter;
  });

  tearDown(() {
    dio.close(force: true);
  });

  test('configures the VNDB endpoint and token header', () {
    VndbClient(dio: dio, token: 'secret-token');

    expect(dio.options.baseUrl, 'https://api.vndb.org/kana');
    expect(dio.options.headers['Content-Type'], 'application/json');
    expect(dio.options.headers['Authorization'], 'Token secret-token');
  });

  test('search sends pagination and parses VNDB results', () async {
    adapter.enqueueJson({
      'results': [
        {
          'id': 'v17',
          'title': 'Ever17',
          'rating': 85,
          'image': {
            'url': 'https://example.test/cover.jpg',
            'dims': [600, 900],
            'sexual': 0.1,
            'violence': 0.2,
          },
        },
      ],
      'more': true,
    });
    final client = VndbClient(dio: dio);

    final result = await client.searchVisualNovels(
      query: 'Ever17',
      page: 3,
      resultsPerPage: 20,
    );

    final request = adapter.requests.single;
    final body = request.data as Map<String, dynamic>;
    final vns = result['vns'] as List;

    expect(request.path, '/vn');
    expect(body['filters'], ['search', '=', 'Ever17']);
    expect(body['page'], 3);
    expect(body['results'], 20);
    expect(body['count'], isTrue);
    expect(result['hasMore'], isTrue);
    expect(vns.single.id, 'v17');
    expect(vns.single.rating, 8.5);
  });

  test('safe search applies request-level content predicates', () async {
    adapter.enqueueJson({'results': [], 'more': false});
    final client = VndbClient(dio: dio);

    await client.searchVisualNovels(
      query: 'test',
      page: 1,
      disableExplicitContentFilter: true,
    );

    final body = adapter.requests.single.data as Map<String, dynamic>;
    final filters = body['filters'] as List;

    expect(filters.first, 'and');
    expect(filters[1], ['search', '=', 'test']);
    expect(
      filters,
      contains(
        equals([
          'tag',
          '=',
          ['g235', 2, 0],
        ]),
      ),
    );
  });

  test('details reports a missing visual novel', () async {
    adapter.enqueueJson({'results': []});
    final client = VndbClient(dio: dio);

    await expectLater(
      client.getVisualNovelDetails('v404'),
      throwsA(
        isA<Exception>().having(
          (error) => error.toString(),
          'message',
          contains('Visual novel not found'),
        ),
      ),
    );
  });

  test('wraps unsuccessful VNDB responses with endpoint context', () async {
    adapter.enqueueJson({'error': 'server failure'}, statusCode: 500);
    final client = VndbClient(dio: dio);

    await expectLater(
      client.searchVisualNovels(query: 'test', page: 1),
      throwsA(
        isA<Exception>().having(
          (error) => error.toString(),
          'message',
          contains('Failed to query VNDB API'),
        ),
      ),
    );
  });
}

class RecordingHttpClientAdapter implements HttpClientAdapter {
  final List<RequestOptions> requests = [];
  final List<ResponseBody> _responses = [];

  void enqueueJson(
    Map<String, dynamic> body, {
    int statusCode = 200,
  }) {
    _responses.add(
      ResponseBody.fromString(
        jsonEncode(body),
        statusCode,
        headers: {
          Headers.contentTypeHeader: [Headers.jsonContentType],
        },
      ),
    );
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);

    if (_responses.isEmpty) {
      throw StateError('No response queued for ${options.uri}.');
    }

    return _responses.removeAt(0);
  }

  @override
  void close({bool force = false}) {}
}
