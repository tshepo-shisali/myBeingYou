import 'package:flutter/material.dart';

class HomeButtonPictureTwo extends StatelessWidget {
  final VoidCallback onPressed;
  final String image;
  final String text;
  final String subText;

  const HomeButtonPictureTwo({Key? key, required this.onPressed, required this.image, required this.text, required this.subText}) : super(key: key);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 100,
                  width: 100,
                  child: Image.asset(image, fit: BoxFit.fill),
                ),
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