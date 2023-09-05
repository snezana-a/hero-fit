import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  final String text;
  final Function onPressed;
  final String imagePath;

  CustomListItem({required this.text, required this.onPressed, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        imagePath,
        width: 80,
        height: 80,
      ),
      title: Text(text,
          style: const TextStyle(
            fontSize: 24,
            color: Colors.teal,
          )),
      onTap: () {
        onPressed();
      },
    );
  }
}