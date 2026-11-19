import 'package:material_ui/material_ui.dart';

class LanguageFlagIcon extends StatelessWidget {
  const LanguageFlagIcon({
    super.key,
    required this.flag,
    this.fontSize = 18.0,
  });

  final String flag;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      flag,
      style: TextStyle(
        fontSize: fontSize,
        height: 1.0,
      ),
    );
  }
}
