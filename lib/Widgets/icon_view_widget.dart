import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconView extends StatelessWidget {
  const IconView({Key? key, required this.icons, this.color = Colors.black})
      : super(key: key);

  final IconData icons;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.12,
      padding: const EdgeInsets.only(right: 10, top: 10, bottom: 10),
      child: FaIcon(
        icons,
        color: color,
        size: size.width * 0.07,
      ),
    );
  }
}
