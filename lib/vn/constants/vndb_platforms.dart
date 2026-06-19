import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VndbPlatform {
  const VndbPlatform({
    required this.id,
    required this.label,
    required this.group,
    required this.icon,
  });

  final String id;
  final String label;
  final String group;
  final FaIconData icon;
}

const vndbPlatforms = [
  VndbPlatform(
    id: 'win',
    label: 'Windows',
    group: 'Desktop & Web',
    icon: FontAwesomeIcons.windows,
  ),
  VndbPlatform(
    id: 'lin',
    label: 'Linux',
    group: 'Desktop & Web',
    icon: FontAwesomeIcons.linux,
  ),
  VndbPlatform(
    id: 'mac',
    label: 'Mac OS',
    group: 'Desktop & Web',
    icon: FontAwesomeIcons.apple,
  ),
  VndbPlatform(
    id: 'web',
    label: 'Website',
    group: 'Desktop & Web',
    icon: FontAwesomeIcons.globe,
  ),
  VndbPlatform(
    id: 'ios',
    label: 'Apple iProduct',
    group: 'Mobile',
    icon: FontAwesomeIcons.apple,
  ),
  VndbPlatform(
    id: 'and',
    label: 'Android',
    group: 'Mobile',
    icon: FontAwesomeIcons.android,
  ),
  VndbPlatform(
    id: 'mob',
    label: 'Other (mobile)',
    group: 'Mobile',
    icon: FontAwesomeIcons.mobileScreenButton,
  ),
  VndbPlatform(
    id: 'nes',
    label: 'Famicom',
    group: 'Nintendo',
    icon: FontAwesomeIcons.gamepad,
  ),
  VndbPlatform(
    id: 'sfc',
    label: 'Super Famicom',
    group: 'Nintendo',
    icon: FontAwesomeIcons.gamepad,
  ),
  VndbPlatform(
    id: 'gba',
    label: 'Game Boy Advance',
    group: 'Nintendo',
    icon: FontAwesomeIcons.gamepad,
  ),
  VndbPlatform(
    id: 'gbc',
    label: 'Game Boy Color',
    group: 'Nintendo',
    icon: FontAwesomeIcons.gamepad,
  ),
  VndbPlatform(
    id: 'nds',
    label: 'Nintendo DS',
    group: 'Nintendo',
    icon: FontAwesomeIcons.gamepad,
  ),
  VndbPlatform(
    id: 'n3d',
    label: 'Nintendo 3DS',
    group: 'Nintendo',
    icon: FontAwesomeIcons.gamepad,
  ),
  VndbPlatform(
    id: 'swi',
    label: 'Nintendo Switch',
    group: 'Nintendo',
    icon: FontAwesomeIcons.gamepad,
  ),
  VndbPlatform(
    id: 'sw2',
    label: 'Nintendo Switch 2',
    group: 'Nintendo',
    icon: FontAwesomeIcons.gamepad,
  ),
  VndbPlatform(
    id: 'wii',
    label: 'Nintendo Wii',
    group: 'Nintendo',
    icon: FontAwesomeIcons.gamepad,
  ),
  VndbPlatform(
    id: 'wiu',
    label: 'Nintendo Wii U',
    group: 'Nintendo',
    icon: FontAwesomeIcons.gamepad,
  ),
  VndbPlatform(
    id: 'ps1',
    label: 'PlayStation 1',
    group: 'PlayStation',
    icon: FontAwesomeIcons.playstation,
  ),
  VndbPlatform(
    id: 'ps2',
    label: 'PlayStation 2',
    group: 'PlayStation',
    icon: FontAwesomeIcons.playstation,
  ),
  VndbPlatform(
    id: 'ps3',
    label: 'PlayStation 3',
    group: 'PlayStation',
    icon: FontAwesomeIcons.playstation,
  ),
  VndbPlatform(
    id: 'ps4',
    label: 'PlayStation 4',
    group: 'PlayStation',
    icon: FontAwesomeIcons.playstation,
  ),
  VndbPlatform(
    id: 'ps5',
    label: 'PlayStation 5',
    group: 'PlayStation',
    icon: FontAwesomeIcons.playstation,
  ),
  VndbPlatform(
    id: 'psp',
    label: 'PlayStation Portable',
    group: 'PlayStation',
    icon: FontAwesomeIcons.playstation,
  ),
  VndbPlatform(
    id: 'psv',
    label: 'PlayStation Vita',
    group: 'PlayStation',
    icon: FontAwesomeIcons.playstation,
  ),
  VndbPlatform(
    id: 'xb1',
    label: 'Xbox',
    group: 'Xbox',
    icon: FontAwesomeIcons.xbox,
  ),
  VndbPlatform(
    id: 'xb3',
    label: 'Xbox 360',
    group: 'Xbox',
    icon: FontAwesomeIcons.xbox,
  ),
  VndbPlatform(
    id: 'xbo',
    label: 'Xbox One',
    group: 'Xbox',
    icon: FontAwesomeIcons.xbox,
  ),
  VndbPlatform(
    id: 'xxs',
    label: 'Xbox X/S',
    group: 'Xbox',
    icon: FontAwesomeIcons.xbox,
  ),
  VndbPlatform(
    id: 'drc',
    label: 'Dreamcast',
    group: 'Sega',
    icon: FontAwesomeIcons.gamepad,
  ),
  VndbPlatform(
    id: 'smd',
    label: 'Sega Mega Drive',
    group: 'Sega',
    icon: FontAwesomeIcons.gamepad,
  ),
  VndbPlatform(
    id: 'scd',
    label: 'Sega Mega-CD',
    group: 'Sega',
    icon: FontAwesomeIcons.compactDisc,
  ),
  VndbPlatform(
    id: 'sat',
    label: 'Sega Saturn',
    group: 'Sega',
    icon: FontAwesomeIcons.gamepad,
  ),
  VndbPlatform(
    id: 'p88',
    label: 'PC-88',
    group: 'Classic Computers',
    icon: FontAwesomeIcons.computer,
  ),
  VndbPlatform(
    id: 'p98',
    label: 'PC-98',
    group: 'Classic Computers',
    icon: FontAwesomeIcons.computer,
  ),
  VndbPlatform(
    id: 'x1s',
    label: 'Sharp X1',
    group: 'Classic Computers',
    icon: FontAwesomeIcons.computer,
  ),
  VndbPlatform(
    id: 'x68',
    label: 'Sharp X68000',
    group: 'Classic Computers',
    icon: FontAwesomeIcons.computer,
  ),
  VndbPlatform(
    id: 'fm7',
    label: 'FM-7',
    group: 'Classic Computers',
    icon: FontAwesomeIcons.computer,
  ),
  VndbPlatform(
    id: 'fm8',
    label: 'FM-8',
    group: 'Classic Computers',
    icon: FontAwesomeIcons.computer,
  ),
  VndbPlatform(
    id: 'fmt',
    label: 'FM Towns',
    group: 'Classic Computers',
    icon: FontAwesomeIcons.computer,
  ),
  VndbPlatform(
    id: 'msx',
    label: 'MSX',
    group: 'Classic Computers',
    icon: FontAwesomeIcons.computer,
  ),
  VndbPlatform(
    id: 'pce',
    label: 'PC Engine',
    group: 'Classic Consoles',
    icon: FontAwesomeIcons.gamepad,
  ),
  VndbPlatform(
    id: 'pcf',
    label: 'PC-FX',
    group: 'Classic Consoles',
    icon: FontAwesomeIcons.gamepad,
  ),
  VndbPlatform(
    id: 'tdo',
    label: '3DO',
    group: 'Classic Consoles',
    icon: FontAwesomeIcons.gamepad,
  ),
  VndbPlatform(
    id: 'dos',
    label: 'DOS',
    group: 'Media & Other',
    icon: FontAwesomeIcons.terminal,
  ),
  VndbPlatform(
    id: 'dvd',
    label: 'DVD Player',
    group: 'Media & Other',
    icon: FontAwesomeIcons.compactDisc,
  ),
  VndbPlatform(
    id: 'bdp',
    label: 'Blu-ray Player',
    group: 'Media & Other',
    icon: FontAwesomeIcons.compactDisc,
  ),
  VndbPlatform(
    id: 'vnd',
    label: 'VNDS',
    group: 'Media & Other',
    icon: FontAwesomeIcons.bookOpen,
  ),
  VndbPlatform(
    id: 'oth',
    label: 'Other',
    group: 'Media & Other',
    icon: FontAwesomeIcons.ellipsis,
  ),
];

Map<String, String> get vndbPlatformLabels {
  return {
    for (final platform in vndbPlatforms) platform.id: platform.label,
  };
}

VndbPlatform? vndbPlatformById(String id) {
  for (final platform in vndbPlatforms) {
    if (platform.id == id) {
      return platform;
    }
  }

  return null;
}
