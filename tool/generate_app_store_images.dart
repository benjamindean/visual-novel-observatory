import 'dart:io';
import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

/// Run with:
/// flutter test tool/generate_app_store_images.dart
///
/// Edit this map to add images, text, background colors, and positions.
/// Colors use #RRGGBB or #RRGGBBAA. Positions accept pixels or percentages.
const appStoreImageConfig = <String, Object?>{
  'outputDirectory': 'screenshots/app_store',
  'defaultWidth': 1290,
  'defaultHeight': 2796,
  'images': <Map<String, Object?>>[
    <String, Object?>{
      'fileName': '01_explore.png',
      'background': '#061225',
      'layers': <Map<String, Object?>>[
        <String, Object?>{
          'type': 'text',
          'text': 'Explore',
          'color': '#EAFBFF',
          'align': 'center',
          'fontSize': 172,
          'fontWeight': 600,
          'position': <String, Object?>{
            'x': 96,
            'y': 170,
            'width': 1098,
          },
        },
        <String, Object?>{
          'type': 'text',
          'text': 'Over 40K visual novels from VNDB',
          'color': '#9EDFE4',
          'align': 'center',
          'fontSize': 76,
          'position': <String, Object?>{
            'x': 148,
            'y': 390,
            'width': 994,
          },
        },
        <String, Object?>{
          'type': 'image',
          'path': 'screenshots/danganronpa-dark.png',
          'fit': 'contain',
          'position': <String, Object?>{
            'x': 62,
            'y': 930,
            'width': 710,
            'height': 1544,
          },
        },
        <String, Object?>{
          'type': 'image',
          'path': 'screenshots/mystery-dark.png',
          'fit': 'contain',
          'position': <String, Object?>{
            'x': 518,
            'y': 805,
            'width': 710,
            'height': 1544,
          },
        },
      ],
    },
    <String, Object?>{
      'fileName': '02_sort_and_filter.png',
      'background': '#3C1C65',
      'layers': <Map<String, Object?>>[
        <String, Object?>{
          'type': 'text',
          'text': 'Sort and Filter',
          'color': '#F9F0FF',
          'align': 'center',
          'fontSize': 136,
          'fontWeight': 600,
          'position': <String, Object?>{
            'x': 80,
            'y': 170,
            'width': 1130,
          },
        },
        <String, Object?>{
          'type': 'text',
          'text':
              'Combine tags, languages, platforms, release windows, '
              'length, rating, votes, etc.',
          'color': '#D8C2F4',
          'align': 'center',
          'fontSize': 68,
          'position': <String, Object?>{
            'x': 126,
            'y': 370,
            'width': 1038,
          },
        },
        <String, Object?>{
          'type': 'image',
          'path': 'screenshots/search-dark.png',
          'fit': 'contain',
          'position': <String, Object?>{
            'x': 62,
            'y': 930,
            'width': 710,
            'height': 1544,
          },
        },
        <String, Object?>{
          'type': 'image',
          'path': 'screenshots/filters-screen-dark.png',
          'fit': 'contain',
          'position': <String, Object?>{
            'x': 518,
            'y': 805,
            'width': 710,
            'height': 1544,
          },
        },
      ],
    },
    <String, Object?>{
      'fileName': '03_theming.png',
      'background': '#8FD7FF',
      'layers': <Map<String, Object?>>[
        <String, Object?>{
          'type': 'text',
          'text': 'Theming',
          'color': '#05233B',
          'align': 'center',
          'fontSize': 162,
          'fontWeight': 600,
          'position': <String, Object?>{
            'x': 96,
            'y': 170,
            'width': 1098,
          },
        },
        <String, Object?>{
          'type': 'text',
          'text': 'Colorful themes with light and dark modes',
          'color': '#16496A',
          'align': 'center',
          'fontSize': 74,
          'position': <String, Object?>{
            'x': 148,
            'y': 390,
            'width': 994,
          },
        },
        <String, Object?>{
          'type': 'image',
          'path': 'screenshots/danganronpa-2-dark.png',
          'fit': 'contain',
          'position': <String, Object?>{
            'x': 62,
            'y': 930,
            'width': 710,
            'height': 1544,
          },
        },
        <String, Object?>{
          'type': 'image',
          'path': 'screenshots/saeko-light.png',
          'fit': 'contain',
          'position': <String, Object?>{
            'x': 518,
            'y': 805,
            'width': 710,
            'height': 1544,
          },
        },
      ],
    },
    <String, Object?>{
      'fileName': '04_library_management.png',
      'background': '#04BFD7',
      'layers': <Map<String, Object?>>[
        <String, Object?>{
          'type': 'text',
          'text': 'Library Management',
          'color': '#042A32',
          'align': 'center',
          'fontSize': 100,
          'fontWeight': 600,
          'position': <String, Object?>{
            'x': 45,
            'y': 170,
            'width': 1200,
          },
        },
        <String, Object?>{
          'type': 'text',
          'text':
              'Jump between reading statuses, revisit your wishlist, '
              'update labels, and record votes',
          'color': '#073F49',
          'align': 'center',
          'fontSize': 66,
          'position': <String, Object?>{
            'x': 126,
            'y': 370,
            'width': 1038,
          },
        },
        <String, Object?>{
          'type': 'image',
          'path': 'screenshots/kugayama-shiori-dark.png',
          'fit': 'contain',
          'position': <String, Object?>{
            'x': 62,
            'y': 930,
            'width': 710,
            'height': 1544,
          },
        },
        <String, Object?>{
          'type': 'image',
          'path': 'screenshots/wishlist-dark.png',
          'fit': 'contain',
          'position': <String, Object?>{
            'x': 518,
            'y': 805,
            'width': 710,
            'height': 1544,
          },
        },
      ],
    },
  ],
};

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = null;
  _registerPathProviderMock();

  test('generates app store images', () async {
    await AppStoreImageGenerator(
      config: appStoreImageConfig,
      outputOverride: Platform.environment['APP_STORE_OUTPUT'],
      onlyName: Platform.environment['APP_STORE_ONLY'],
    ).run();
  });
}

void _registerPathProviderMock() {
  const channel = MethodChannel('plugins.flutter.io/path_provider');

  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(channel, (call) async {
        final directory = Directory(
          '${Directory.systemTemp.path}/visual_novel_observatory_app_store',
        );

        if (!directory.existsSync()) {
          directory.createSync(recursive: true);
        }

        return switch (call.method) {
          'getApplicationSupportDirectory' => directory.path,
          'getTemporaryDirectory' => directory.path,
          'getApplicationDocumentsDirectory' => directory.path,
          _ => null,
        };
      });
}

class AppStoreImageGenerator {
  const AppStoreImageGenerator({
    required this.config,
    this.outputOverride,
    this.onlyName,
  });

  final Map<String, Object?> config;
  final String? outputOverride;
  final String? onlyName;

  Future<void> run() async {
    final outputDirectory = Directory(
      outputOverride ?? _string(config['outputDirectory']),
    );
    final imageConfigs = _list(config['images']);

    if (!outputDirectory.existsSync()) {
      outputDirectory.createSync(recursive: true);
    }

    for (final imageConfig in imageConfigs) {
      final page = _map(imageConfig);
      final fileName = _string(page['fileName']);

      if (onlyName != null && onlyName != fileName) {
        continue;
      }

      final bytes = await _renderPage(page);
      final outputFile = File('${outputDirectory.path}/$fileName');

      outputFile.writeAsBytesSync(bytes);
      stdout.writeln('Generated ${outputFile.path}');
    }
  }

  Future<List<int>> _renderPage(Map<String, Object?> page) async {
    final width = _int(page['width'], fallback: _int(config['defaultWidth']));
    final height = _int(
      page['height'],
      fallback: _int(config['defaultHeight']),
    );
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);

    _paintBackground(
      canvas: canvas,
      size: Size(width.toDouble(), height.toDouble()),
      background: page['background'] ?? config['background'],
    );

    for (final layerConfig in _list(page['layers'])) {
      final layer = _map(layerConfig);
      final type = _string(layer['type']);

      switch (type) {
        case 'image':
          await _drawImageLayer(canvas, layer, width, height);
        case 'rect':
          _drawRectLayer(canvas, layer, width, height);
        case 'text':
          await _drawTextLayer(canvas, layer, width, height);
        default:
          throw ArgumentError('Unsupported layer type: $type');
      }
    }

    final picture = recorder.endRecording();
    final image = await picture.toImage(width, height);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    image.dispose();
    picture.dispose();

    if (byteData == null) {
      throw StateError('Could not encode rendered image.');
    }

    return byteData.buffer.asUint8List();
  }

  void _paintBackground({
    required Canvas canvas,
    required Size size,
    required Object? background,
  }) {
    final paint = Paint()
      ..color = background == null
          ? _color('#000000')
          : _color(_string(background));

    canvas.drawRect(Offset.zero & size, paint);
  }

  Future<void> _drawImageLayer(
    Canvas canvas,
    Map<String, Object?> layer,
    int canvasWidth,
    int canvasHeight,
  ) async {
    final path = _string(layer['path']);
    final sourceFile = File(path);

    if (!sourceFile.existsSync()) {
      throw ArgumentError('Image file does not exist: $path');
    }

    final image = await _decodeImage(sourceFile.readAsBytesSync());
    final position = _position(layer, canvasWidth, canvasHeight);
    final fit = _string(layer['fit'], fallback: 'contain');
    final destination = _fitRect(
      sourceSize: Size(
        image.width.toDouble(),
        image.height.toDouble(),
      ),
      target: position.rect,
      fit: fit,
    );
    final cornerRadius = _double(layer['cornerRadius'], fallback: 72);
    final shadow = Paint()
      ..color = Colors.black.withValues(alpha: 0.22)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 24);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        destination.shift(const Offset(0, 18)),
        Radius.circular(cornerRadius),
      ),
      shadow,
    );

    canvas.save();
    canvas.clipRRect(
      RRect.fromRectAndRadius(
        destination,
        Radius.circular(cornerRadius),
      ),
      doAntiAlias: true,
    );
    canvas.drawImageRect(
      image,
      Rect.fromLTWH(
        0,
        0,
        image.width.toDouble(),
        image.height.toDouble(),
      ),
      destination,
      Paint()..filterQuality = FilterQuality.high,
    );
    canvas.restore();
    image.dispose();
  }

  void _drawRectLayer(
    Canvas canvas,
    Map<String, Object?> layer,
    int canvasWidth,
    int canvasHeight,
  ) {
    final position = _position(layer, canvasWidth, canvasHeight);
    final radius = _double(layer['radius'], fallback: 0);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        position.rect,
        Radius.circular(radius),
      ),
      Paint()..color = _color(_string(layer['color'])),
    );
  }

  Future<void> _drawTextLayer(
    Canvas canvas,
    Map<String, Object?> layer,
    int canvasWidth,
    int canvasHeight,
  ) async {
    final position = _position(
      layer,
      canvasWidth,
      canvasHeight,
      requireHeight: false,
    );
    final fontSize = _double(layer['fontSize'], fallback: 48);
    final fontWeight = FontWeight.values.firstWhere(
      (weight) => weight.value == _int(layer['fontWeight'], fallback: 400),
      orElse: () => FontWeight.w400,
    );
    final style = GoogleFonts.openSans(
      color: _color(_string(layer['color'], fallback: '#FFFFFF')),
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: _double(layer['lineHeight'], fallback: 1.16),
      letterSpacing: 0,
    );
    final textAlign = switch (_string(layer['align'], fallback: 'left')) {
      'center' => TextAlign.center,
      'right' => TextAlign.right,
      _ => TextAlign.left,
    };

    await GoogleFonts.pendingFonts();

    final painter =
        TextPainter(
          text: TextSpan(
            text: _string(layer['text']),
            style: style,
          ),
          textAlign: textAlign,
          textDirection: TextDirection.ltr,
        )..layout(
          minWidth: position.width.toDouble(),
          maxWidth: position.width.toDouble(),
        );

    painter.paint(canvas, Offset(position.x.toDouble(), position.y.toDouble()));
  }

  Rect _fitRect({
    required Size sourceSize,
    required Rect target,
    required String fit,
  }) {
    return switch (fit) {
      'fill' => target,
      'cover' => _coverRect(sourceSize: sourceSize, target: target),
      'contain' => _containRect(sourceSize: sourceSize, target: target),
      _ => throw ArgumentError('Unsupported image fit: $fit'),
    };
  }

  Rect _containRect({
    required Size sourceSize,
    required Rect target,
  }) {
    final scale = math.min(
      target.width / sourceSize.width,
      target.height / sourceSize.height,
    );
    final width = sourceSize.width * scale;
    final height = sourceSize.height * scale;
    final left = target.left + ((target.width - width) / 2);
    final top = target.top + ((target.height - height) / 2);

    return Rect.fromLTWH(left, top, width, height);
  }

  Rect _coverRect({
    required Size sourceSize,
    required Rect target,
  }) {
    final scale = math.max(
      target.width / sourceSize.width,
      target.height / sourceSize.height,
    );
    final width = sourceSize.width * scale;
    final height = sourceSize.height * scale;
    final left = target.left + ((target.width - width) / 2);
    final top = target.top + ((target.height - height) / 2);

    return Rect.fromLTWH(left, top, width, height);
  }

  ResolvedPosition _position(
    Map<String, Object?> layer,
    int canvasWidth,
    int canvasHeight, {
    bool requireHeight = true,
  }) {
    final position = _map(layer['position']);
    final x = _dimension(position['x'], canvasWidth, fallback: 0);
    final y = _dimension(position['y'], canvasHeight, fallback: 0);
    final width = _dimension(
      position['width'],
      canvasWidth,
      fallback: canvasWidth - x,
    );
    final height = _dimension(
      position['height'],
      canvasHeight,
      fallback: requireHeight ? canvasHeight - y : 1,
    );

    return ResolvedPosition(
      x: x,
      y: y,
      width: math.max(1, width),
      height: math.max(1, height),
    );
  }
}

class ResolvedPosition {
  const ResolvedPosition({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  final int x;
  final int y;
  final int width;
  final int height;

  Rect get rect => Rect.fromLTWH(
    x.toDouble(),
    y.toDouble(),
    width.toDouble(),
    height.toDouble(),
  );
}

Future<ui.Image> _decodeImage(List<int> bytes) async {
  final codec = await ui.instantiateImageCodec(Uint8List.fromList(bytes));
  final frame = await codec.getNextFrame();

  codec.dispose();

  return frame.image;
}

Color _color(String value) {
  final normalized = value.trim().replaceFirst('#', '');

  if (normalized.length != 6 && normalized.length != 8) {
    throw ArgumentError('Expected #RRGGBB or #RRGGBBAA color: $value');
  }

  final r = int.parse(normalized.substring(0, 2), radix: 16);
  final g = int.parse(normalized.substring(2, 4), radix: 16);
  final b = int.parse(normalized.substring(4, 6), radix: 16);
  final a = normalized.length == 8
      ? int.parse(normalized.substring(6, 8), radix: 16)
      : 255;

  return Color.fromARGB(a, r, g, b);
}

Map<String, Object?> _map(Object? value) {
  if (value is Map<String, Object?>) {
    return value;
  }

  if (value is Map) {
    return value.cast<String, Object?>();
  }

  throw ArgumentError('Expected a map, got ${value.runtimeType}');
}

List<Object?> _list(Object? value) {
  if (value is List<Object?>) {
    return value;
  }

  if (value is List) {
    return value.cast<Object?>();
  }

  throw ArgumentError('Expected a list, got ${value.runtimeType}');
}

String _string(Object? value, {String? fallback}) {
  if (value == null && fallback != null) {
    return fallback;
  }

  if (value is String) {
    return value;
  }

  throw ArgumentError('Expected a string, got ${value.runtimeType}');
}

int _int(Object? value, {int? fallback}) {
  if (value == null && fallback != null) {
    return fallback;
  }

  if (value is int) {
    return value;
  }

  if (value is num) {
    return value.round();
  }

  throw ArgumentError('Expected a number, got ${value.runtimeType}');
}

double _double(Object? value, {required double fallback}) {
  if (value == null) {
    return fallback;
  }

  if (value is num) {
    return value.toDouble();
  }

  throw ArgumentError('Expected a number, got ${value.runtimeType}');
}

int _dimension(Object? value, int total, {required int fallback}) {
  if (value == null) {
    return fallback;
  }

  if (value is num) {
    return value.round();
  }

  if (value is String && value.trim().endsWith('%')) {
    final percent = double.parse(
      value.trim().substring(0, value.trim().length - 1),
    );

    return (total * (percent / 100)).round();
  }

  if (value is String) {
    return double.parse(value).round();
  }

  throw ArgumentError('Expected pixel or percentage dimension, got $value');
}
