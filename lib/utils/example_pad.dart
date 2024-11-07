import 'package:flutter/material.dart';

class ExamplePad extends StatelessWidget {
  final String title;
  final Widget child;
  final double width;
  final double height;
  final bool center;
  const ExamplePad({
    required this.child,
    required this.title,
    this.height = 200,
    this.width = 200,
    this.center = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Container(
            width: width,
            height: height,
            alignment: center ? Alignment.center : null,
            decoration: BoxDecoration(
              border: Border.all(width: 1),
              color: const Color.fromARGB(114, 173, 203, 255),
            ),
            child: child,
          ),
          const Divider(),
        ],
      );
}
