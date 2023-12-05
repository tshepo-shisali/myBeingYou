import 'package:flutter/material.dart';

class MeetingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String image;
  final String text;
  final String subText;

  const MeetingButton({Key? key, required this.onPressed, required this.image, required this.text, required this.subText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          width: double.infinity,
          height: 60,
          decoration: BoxDecoration(
            color: const Color(0xff050729),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.06),
              offset: const Offset(0, 4)
            ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  height: 60,
                  width: 80,
                  child: Image.asset(image, fit: BoxFit.fill),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(text, style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      const SizedBox(height: 10,),
                      Text(subText, style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      )
                    ],
                  ),
                  ),
                const Icon(Icons.navigate_next)
              ]
            ),
          ),
          
        ),
      )
    );
  }
}