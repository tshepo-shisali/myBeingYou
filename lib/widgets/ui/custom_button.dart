import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const CustomButton({Key? key, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: ElevatedButton(
        onPressed: onPressed,
         style: ElevatedButton.styleFrom(
          primary: const  Color(0xffcdd0f9),
          minimumSize: const Size(100, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          )
         ),
         child: Text(text,
         style: const TextStyle(
          fontSize: 20,
            ),
          ),
         ),
    );
  }
}