import '../../../core/api/vndb_client.dart';
import '../models/visual_novel.dart';

class VnRepository {
  final VndbClient _client;

  VnRepository(this._client);

  Future<Map<String, dynamic>> getPopularVisualNovels({
    required int page,
    int resultsPerPage = 15,
  }) {
    return _client.getPopularVisualNovels(
      page: page,
      resultsPerPage: resultsPerPage,
    );
  }

  Future<Map<String, dynamic>> searchVisualNovels({
    required String query,
    required int page,
    int resultsPerPage = 15,
  }) {
    return _client.searchVisualNovels(
      query: query,
      page: page,
      resultsPerPage: resultsPerPage,
    );
  }

  Future<Map<String, dynamic>> getVisualNovelsByTag({
    required String tagId,
    required int page,
    int resultsPerPage = 15,
  }) {
    return _client.getVisualNovelsByTag(
      tagId: tagId,
      page: page,
      resultsPerPage: resultsPerPage,
    );
  }

  Future<Map<String, dynamic>> getVisualNovels({
    required List<dynamic> filters,
    required int page,
    int resultsPerPage = 15,
    String? sort,
    bool reverse = true,
  }) {
    return _client.getVisualNovels(
      filters: filters,
      page: page,
      resultsPerPage: resultsPerPage,
      sort: sort,
      reverse: reverse,
    );
  }

  Future<VisualNovel> getVisualNovelDetails(String id) {
    return _client.getVisualNovelDetails(id);
  }
}
