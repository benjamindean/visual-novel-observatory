import '../../core/api/vndb_client.dart';
import '../models/vndb_label.dart';
import '../models/vn_relation.dart';

class VnRepository {
  final VndbClient _client;

  VnRepository(this._client);

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

  Future<List<VndbLabel>> getUserListLabels() async {
    final list = await _client.getUserListLabels();

    return list.map((e) => VndbLabel.fromJson(e)).toList();
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
    required String user,
    required int page,
    int resultsPerPage = 100,
  }) {
    return _client.getUserList(
      user: user,
      page: page,
      resultsPerPage: resultsPerPage,
    );
  }

  Future<Map<String, dynamic>> getTagsPage({
    required int page,
    int resultsPerPage = 100,
  }) {
    return _client.getTagsPage(page: page, resultsPerPage: resultsPerPage);
  }

  Future<List<VnRelation>> getRelations(String vnId) async {
    final list = await _client.getRelations(vnId);

    return list.map((e) => VnRelation.fromJson(e)).toList();
  }
}
