import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.size,
    required this.name,
    required this.icon,
    required this.function,
  }) : super(key: key);

  final double size;
  final String name;
  final Icon icon;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => function(),
      child: FittedBox(
        child: SizedBox(
          width: size,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              icon,
              Text(name),
            ],
          ),
        ),
      ),
    );
  }
}
