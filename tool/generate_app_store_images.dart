import 'dart:io';
import 'dart:math' as math;

import 'package:image/image.dart' as img;

/// Run with:
/// dart run tool/generate_app_store_images.dart
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
          'fontScale': 3.4,
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
          'fontScale': 1.5,
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
            'x': 108,
            'y': 760,
            'width': 650,
            'height': 1413,
          },
        },
        <String, Object?>{
          'type': 'image',
          'path': 'screenshots/mystery-dark.png',
          'fit': 'contain',
          'position': <String, Object?>{
            'x': 508,
            'y': 650,
            'width': 650,
            'height': 1413,
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
          'fontScale': 2.7,
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
          'fontScale': 1.35,
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
            'x': 108,
            'y': 760,
            'width': 650,
            'height': 1413,
          },
        },
        <String, Object?>{
          'type': 'image',
          'path': 'screenshots/filters-screen-dark.png',
          'fit': 'contain',
          'position': <String, Object?>{
            'x': 508,
            'y': 650,
            'width': 650,
            'height': 1413,
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
          'fontScale': 3.2,
          'position': <String, Object?>{
            'x': 96,
            'y': 170,
            'width': 1098,
          },
        },
        <String, Object?>{
          'type': 'text',
          'text': 'Colorful themes. Light and dark modes',
          'color': '#16496A',
          'align': 'center',
          'fontScale': 1.45,
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
            'x': 108,
            'y': 760,
            'width': 650,
            'height': 1413,
          },
        },
        <String, Object?>{
          'type': 'image',
          'path': 'screenshots/saeko-light.png',
          'fit': 'contain',
          'position': <String, Object?>{
            'x': 508,
            'y': 650,
            'width': 650,
            'height': 1413,
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
          'fontScale': 2.35,
          'position': <String, Object?>{
            'x': 72,
            'y': 170,
            'width': 1146,
          },
        },
        <String, Object?>{
          'type': 'text',
          'text':
              'Jump between reading statuses, revisit your wishlist, '
              'update labels, and record votes',
          'color': '#073F49',
          'align': 'center',
          'fontScale': 1.3,
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
            'x': 108,
            'y': 760,
            'width': 650,
            'height': 1413,
          },
        },
        <String, Object?>{
          'type': 'image',
          'path': 'screenshots/wishlist-dark.png',
          'fit': 'contain',
          'position': <String, Object?>{
            'x': 508,
            'y': 650,
            'width': 650,
            'height': 1413,
          },
        },
      ],
    },
  ],
};

Future<void> main(List<String> args) async {
  final outputOverride = _argValue(args, '--output');
  final onlyName = _argValue(args, '--only');
  final generator = AppStoreImageGenerator(
    config: appStoreImageConfig,
    outputOverride: outputOverride,
    onlyName: onlyName,
  );

  await generator.run();
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

      final image = _renderPage(page);
      final outputFile = File('${outputDirectory.path}/$fileName');

      outputFile.writeAsBytesSync(img.encodePng(image));
      stdout.writeln('Generated ${outputFile.path}');
    }
  }

  img.Image _renderPage(Map<String, Object?> page) {
    final width = _int(page['width'], fallback: _int(config['defaultWidth']));
    final height = _int(
      page['height'],
      fallback: _int(config['defaultHeight']),
    );
    final canvas = img.Image(
      width: width,
      height: height,
      numChannels: 4,
    );

    _paintBackground(canvas, page['background'] ?? config['background']);

    for (final layerConfig in _list(page['layers'])) {
      final layer = _map(layerConfig);
      final type = _string(layer['type']);

      switch (type) {
        case 'image':
          _drawImageLayer(canvas, layer);
        case 'rect':
          _drawRectLayer(canvas, layer);
        case 'text':
          _drawTextLayer(canvas, layer);
        default:
          throw ArgumentError('Unsupported layer type: $type');
      }
    }

    return canvas;
  }

  void _paintBackground(img.Image canvas, Object? background) {
    if (background == null) {
      img.fill(
        canvas,
        color: _color('#000000'),
      );
      return;
    }

    if (background is String) {
      img.fill(
        canvas,
        color: _color(background),
      );
      return;
    }

    final map = _map(background);
    final type = _string(map['type']);

    if (type != 'verticalGradient') {
      throw ArgumentError('Unsupported background type: $type');
    }

    final from = _color(_string(map['from']));
    final to = _color(_string(map['to']));

    for (var y = 0; y < canvas.height; y += 1) {
      final amount = canvas.height <= 1 ? 0.0 : y / (canvas.height - 1);

      img.fillRect(
        canvas,
        x1: 0,
        y1: y,
        x2: canvas.width - 1,
        y2: y,
        color: _lerpColor(from, to, amount),
      );
    }
  }

  void _drawImageLayer(img.Image canvas, Map<String, Object?> layer) {
    final path = _string(layer['path']);
    final sourceFile = File(path);

    if (!sourceFile.existsSync()) {
      throw ArgumentError('Image file does not exist: $path');
    }

    final decoded = img.decodeImage(sourceFile.readAsBytesSync());

    if (decoded == null) {
      throw ArgumentError('Could not decode image: $path');
    }

    final source = img.bakeOrientation(decoded);
    final position = _position(layer, canvas.width, canvas.height);
    final fit = _string(layer['fit'], fallback: 'contain');

    switch (fit) {
      case 'cover':
        _drawCoverImage(canvas, source, position);
      case 'fill':
        img.compositeImage(
          canvas,
          source,
          dstX: position.x,
          dstY: position.y,
          dstW: position.width,
          dstH: position.height,
        );
      case 'contain':
        _drawContainImage(canvas, source, position);
      default:
        throw ArgumentError('Unsupported image fit: $fit');
    }
  }

  void _drawContainImage(
    img.Image canvas,
    img.Image source,
    ResolvedPosition position,
  ) {
    final scale = math.min(
      position.width / source.width,
      position.height / source.height,
    );
    final width = math.max(1, (source.width * scale).round());
    final height = math.max(1, (source.height * scale).round());
    final x = position.x + ((position.width - width) / 2).round();
    final y = position.y + ((position.height - height) / 2).round();

    img.compositeImage(
      canvas,
      source,
      dstX: x,
      dstY: y,
      dstW: width,
      dstH: height,
    );
  }

  void _drawCoverImage(
    img.Image canvas,
    img.Image source,
    ResolvedPosition position,
  ) {
    final targetAspect = position.width / position.height;
    final sourceAspect = source.width / source.height;
    var srcX = 0;
    var srcY = 0;
    var srcW = source.width;
    var srcH = source.height;

    if (sourceAspect > targetAspect) {
      srcW = (source.height * targetAspect).round();
      srcX = ((source.width - srcW) / 2).round();
    } else {
      srcH = (source.width / targetAspect).round();
      srcY = ((source.height - srcH) / 2).round();
    }

    img.compositeImage(
      canvas,
      source,
      dstX: position.x,
      dstY: position.y,
      dstW: position.width,
      dstH: position.height,
      srcX: srcX,
      srcY: srcY,
      srcW: srcW,
      srcH: srcH,
    );
  }

  void _drawRectLayer(img.Image canvas, Map<String, Object?> layer) {
    final position = _position(layer, canvas.width, canvas.height);
    final radius = _int(layer['radius'], fallback: 0);

    img.fillRect(
      canvas,
      x1: position.x,
      y1: position.y,
      x2: position.x + position.width - 1,
      y2: position.y + position.height - 1,
      color: _color(_string(layer['color'])),
      radius: radius,
    );
  }

  void _drawTextLayer(img.Image canvas, Map<String, Object?> layer) {
    final text = _string(layer['text']);
    final color = _color(_string(layer['color'], fallback: '#FFFFFF'));
    final align = _string(layer['align'], fallback: 'left');
    final font = _fontForSize(_int(layer['fontSize'], fallback: 48));
    final fontScale = _double(layer['fontScale'], fallback: 1);
    final lineHeight = _double(layer['lineHeight'], fallback: 1.2);
    final position = _position(
      layer,
      canvas.width,
      canvas.height,
      requireHeight: false,
    );
    final textWidth = math.max(1, (position.width / fontScale).round());
    final lines = _wrapText(
      text: text,
      font: font,
      maxWidth: textWidth,
    );
    final lineStep = math.max(1, (font.lineHeight * lineHeight).round());
    final textHeight = math.max(font.lineHeight, lineStep * lines.length);
    final textLayer = img.Image(
      width: textWidth,
      height: textHeight,
      numChannels: 4,
    );

    img.fill(
      textLayer,
      color: _color('#00000000'),
    );

    for (var i = 0; i < lines.length; i += 1) {
      final line = lines[i];
      final lineWidth = _textWidth(line, font);
      final x = switch (align) {
        'center' => ((textWidth - lineWidth) / 2).round(),
        'right' => textWidth - lineWidth,
        _ => 0,
      };

      img.drawString(
        textLayer,
        line,
        font: font,
        x: math.max(0, x),
        y: i * lineStep,
        color: color,
      );
    }

    final scaled = fontScale == 1
        ? textLayer
        : img.copyResize(
            textLayer,
            width: math.max(1, (textLayer.width * fontScale).round()),
            height: math.max(1, (textLayer.height * fontScale).round()),
            interpolation: img.Interpolation.cubic,
          );

    img.compositeImage(
      canvas,
      scaled,
      dstX: position.x,
      dstY: position.y,
    );
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
}

List<String> _wrapText({
  required String text,
  required img.BitmapFont font,
  required int maxWidth,
}) {
  final lines = <String>[];

  for (final paragraph in text.split('\n')) {
    final words = paragraph.split(RegExp(r'\s+'));
    final currentLine = StringBuffer();

    for (final word in words) {
      if (word.isEmpty) {
        continue;
      }

      final candidate = currentLine.isEmpty
          ? word
          : '${currentLine.toString()} $word';

      if (_textWidth(candidate, font) <= maxWidth || currentLine.isEmpty) {
        currentLine
          ..clear()
          ..write(candidate);
      } else {
        lines.add(currentLine.toString());
        currentLine
          ..clear()
          ..write(word);
      }
    }

    if (currentLine.isNotEmpty) {
      lines.add(currentLine.toString());
    }
  }

  return lines;
}

int _textWidth(String value, img.BitmapFont font) {
  var width = 0;

  for (final codeUnit in value.codeUnits) {
    final character = String.fromCharCode(codeUnit);

    width += font.characterXAdvance(character);
  }

  return width;
}

img.BitmapFont _fontForSize(int size) {
  if (size <= 14) {
    return img.arial14;
  }

  if (size <= 24) {
    return img.arial24;
  }

  return img.arial48;
}

img.ColorUint8 _color(String value) {
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

  return img.ColorUint8.rgba(r, g, b, a);
}

img.ColorUint8 _lerpColor(
  img.ColorUint8 from,
  img.ColorUint8 to,
  double amount,
) {
  int channel(num start, num end) {
    return (start + ((end - start) * amount)).round().clamp(0, 255);
  }

  return img.ColorUint8.rgba(
    channel(from.r, to.r),
    channel(from.g, to.g),
    channel(from.b, to.b),
    channel(from.a, to.a),
  );
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

String? _argValue(List<String> args, String name) {
  for (final arg in args) {
    if (arg.startsWith('$name=')) {
      return arg.substring(name.length + 1);
    }
  }

  return null;
}
