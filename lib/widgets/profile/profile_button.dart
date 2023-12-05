// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ProfileButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;
  final Color color;

  const ProfileButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: onPressed,
    child: Padding(
      padding: const EdgeInsets.all(18.0),

      child: Container(
        
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.06),
              offset: const Offset(0, 4)
            ),
            ],
          ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Icon(icon, size: 30, color:const Color(0xffcdd0f9)),
          Text(text,
          style: Theme.of(context).primaryTextTheme.subtitle1,),
          const Icon(Icons.navigate_next, size: 30, color:  Color(0xffcdd0f9),)
        ]),
      ),
      
    ),
  );
  }
}
