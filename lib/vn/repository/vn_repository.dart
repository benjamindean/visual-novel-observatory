import '../../core/api/vndb_client.dart';
import '../models/visual_novel.dart';

import '../models/vndb_label.dart';
import '../models/vn_ulist_entry.dart';

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

  Future<List<VndbLabel>> getUserListLabels() async {
    final list = await _client.getUserListLabels();

    return list.map((e) => VndbLabel.fromJson(e)).toList();
  }

  Future<VnUlistEntry?> getUserListEntry(String vnId) async {
    final data = await _client.getUserListEntry(vnId);

    if (data == null) {
      return null;
    }

    return VnUlistEntry.fromJson(data);
  }

  Future<void> updateUserListEntry({
    required String vnId,
    int? vote,
    bool updateVote = false,
    List<int>? labels,
    bool updateLabels = false,
  }) {
    return _client.updateUserListEntry(
      vnId: vnId,
      vote: vote,
      updateVote: updateVote,
      labels: labels,
      updateLabels: updateLabels,
    );
  }

  Future<Map<String, dynamic>> getUserList({
    required int page,
    int resultsPerPage = 100,
  }) {
    return _client.getUserList(page: page, resultsPerPage: resultsPerPage);
  }

  Future<Map<String, dynamic>> getTagsPage({
    required int page,
    int resultsPerPage = 100,
  }) {
    return _client.getTagsPage(page: page, resultsPerPage: resultsPerPage);
  }
}
