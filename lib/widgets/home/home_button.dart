// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String subText;

  const HomeButton({
    Key? key,
    required this.onPressed,
    required this.text,
    required this.subText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          width: double.infinity,
          height: 100,
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
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(text, style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                      ),
                      const SizedBox(height: 10,),
                      Text(subText, style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
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
