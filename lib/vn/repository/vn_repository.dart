import '../../core/api/vndb_client.dart';
import '../models/visual_novel.dart';
import '../models/vndb_label.dart';
import '../models/vn_character.dart';
import '../models/vn_release.dart';

class VnRepository {
  final VndbClient _client;

  VnRepository(this._client);

  Future<Map<String, dynamic>> searchVisualNovels({
    required String query,
    required int page,
    int resultsPerPage = 15,
    bool disableExplicitContentFilter = false,
  }) {
    return _client.searchVisualNovels(
      query: query,
      page: page,
      resultsPerPage: resultsPerPage,
      disableExplicitContentFilter: disableExplicitContentFilter,
    );
  }

  Future<Map<String, dynamic>> getVisualNovelsByTag({
    required String tagId,
    required int spoilerLevel,
    required int page,
    int resultsPerPage = 15,
    bool disableExplicitContentFilter = false,
  }) {
    return _client.getVisualNovelsByTag(
      tagId: tagId,
      spoilerLevel: spoilerLevel,
      page: page,
      resultsPerPage: resultsPerPage,
      disableExplicitContentFilter: disableExplicitContentFilter,
    );
  }

  Future<Map<String, dynamic>> getVisualNovelsByDeveloper({
    required String developerId,
    required int page,
    int resultsPerPage = 15,
    bool disableExplicitContentFilter = false,
  }) {
    return _client.getVisualNovelsByDeveloper(
      developerId: developerId,
      page: page,
      resultsPerPage: resultsPerPage,
      disableExplicitContentFilter: disableExplicitContentFilter,
    );
  }

  Future<Map<String, dynamic>> getVisualNovels({
    required List<dynamic> filters,
    required int page,
    int resultsPerPage = 15,
    String? sort,
    bool reverse = true,
    bool disableExplicitContentFilter = false,
  }) {
    return _client.getVisualNovels(
      filters: filters,
      page: page,
      resultsPerPage: resultsPerPage,
      sort: sort,
      reverse: reverse,
      disableExplicitContentFilter: disableExplicitContentFilter,
    );
  }

  Future<VisualNovel> getVisualNovelDetails(
    String vnId, {
    bool disableExplicitContentFilter = false,
  }) {
    return _client.getVisualNovelDetails(
      vnId,
      disableExplicitContentFilter: disableExplicitContentFilter,
    );
  }

  Future<VnCharacter> getCharacterDetails(String characterId) async {
    final data = await _client.getCharacterDetails(characterId);

    return VnCharacter.fromJson(data);
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

  Future<List<VnRelease>> getReleases(String vnId) async {
    final list = await _client.getReleases(vnId);

    return list.map((e) => VnRelease.fromJson(e)).toList();
  }
}
