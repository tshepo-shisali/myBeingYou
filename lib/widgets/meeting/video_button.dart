import 'package:flutter/material.dart';

class VideoButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String subText;

  const VideoButton({Key? key, required this.onPressed, required this.text, required this.subText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          width: double.infinity,
          height: 70,
          decoration: BoxDecoration(
            color:  const Color.fromARGB(255, 86, 90, 172),
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
            child: 
                Column(
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
          ),
          
        ),

    );
  }
}