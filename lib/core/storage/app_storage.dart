import 'dart:convert';

import 'package:hive_ce/hive_ce.dart';

import '../../vn/models/vn_ulist_entry.dart';
import '../../vn/models/vndb_label.dart';

class VnUlistEntryAdapter extends TypeAdapter<VnUlistEntry> {
  @override
  final int typeId = 1;

  @override
  VnUlistEntry read(BinaryReader reader) {
    final Map<dynamic, dynamic> rawMap = reader.readMap();
    final Map<String, dynamic> json = jsonDecode(jsonEncode(rawMap));

    return VnUlistEntry.fromJson(json);
  }

  @override
  void write(
    BinaryWriter writer,
    VnUlistEntry obj,
  ) {
    writer.writeMap(jsonDecode(jsonEncode(obj.toJson())));
  }
}

class VndbLabelAdapter extends TypeAdapter<VndbLabel> {
  @override
  final int typeId = 2;

  @override
  VndbLabel read(BinaryReader reader) {
    final Map<dynamic, dynamic> rawMap = reader.readMap();
    final Map<String, dynamic> json = jsonDecode(jsonEncode(rawMap));

    return VndbLabel.fromJson(json);
  }

  @override
  void write(BinaryWriter writer, VndbLabel obj) {
    writer.writeMap(obj.toJson());
  }
}

class AppStorage {
  AppStorage._();

  static late final Box _mainBox;
  static late final Box<VnUlistEntry> _libraryBox;
  static late final Box<VndbLabel> _labelsBox;

  /// Initialize storage and open necessary boxes.
  static Future<void> init() async {
    Hive.registerAdapter(VnUlistEntryAdapter());
    Hive.registerAdapter(VndbLabelAdapter());

    _mainBox = await Hive.openBox('visual_novel_observatory_box');
    _libraryBox = await Hive.openBox<VnUlistEntry>('visual_novel_library_box');
    _labelsBox = await Hive.openBox<VndbLabel>('visual_novel_labels_box');
  }

  /// The main settings and cache box.
  static Box get mainBox => _mainBox;

  /// The visual novel library entries box.
  static Box<VnUlistEntry> get libraryBox => _libraryBox;

  /// The visual novel ulist labels box.
  static Box<VndbLabel> get labelsBox => _labelsBox;
}
