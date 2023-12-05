import 'package:flutter/material.dart';

class JourneyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String image;
  final String text;
  final String subText;

  const JourneyButton({Key? key, required this.onPressed, required this.image, required this.text, required this.subText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          width: 300,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white70,
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
                  height: 80,
                  width: 70,
                  child: Image.asset(image, fit: BoxFit.fill),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(text, style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      
                      Text(subText, style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      )
                    ],
                  ),
                  ),
                
              ]
            ),
          ),
          
        ),
      )
    );
  }
}