import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:neopop/neopop.dart';

class PostButton extends StatelessWidget {
  final VoidCallback onTap;

  const PostButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeoPopButton(
      color: Colors.black,
      parentColor: Colors.black,
      depth: 8,
      animationDuration: const Duration(milliseconds: 200),
      buttonPosition: Position.center,
      border: Border.all(
        color: Colors.white,
        width: 2,
      ),
      onTapUp: () => onTap(),
      onTapDown: () => HapticFeedback.lightImpact(),
      child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: Center(
            child: Text(
              "Post",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
