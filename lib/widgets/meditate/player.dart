// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter/material.dart';

class BottomPlayer extends StatefulWidget {
 final String cover;
 final String title;
 VoidCallback onPressed;
 final bool isPlaying;
 final double duration;
 final double position;
 void Function(double) onChanged;
  BottomPlayer({
    Key? key,
    required this.cover,
    required this.title,
    required this.onPressed,
    required this.isPlaying,
    required this.duration,
    required this.position,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<BottomPlayer> createState() => _BottomPlayerState();
}

class _BottomPlayerState extends State<BottomPlayer> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
         decoration: const BoxDecoration(
          color: Color.fromARGB(255, 41, 48, 173),
          boxShadow: [
             BoxShadow(
            color: Colors.black,
            ),
          ],
         ),
         child: Row(
          children: [
             Container(
                height: 40.0,
                width: 40.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  image: DecorationImage(
                    image: AssetImage('assets/${widget.cover}')),
                ),
              ),
              const SizedBox(width: 5.0,),
            Expanded(
              child: Column(
                children: [
                  Text(widget.title, style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                  ),
                  ),
                  const SizedBox(width: 5.0,),
                  Slider.adaptive(
                    inactiveColor: Colors.white,
                    activeColor: Colors.white,
                     max: widget.duration,
                  value: widget.position,
                    onChanged: widget.onChanged,
                  )
                ]
              )
            ),
            IconButton(
                    onPressed: widget.onPressed,
                  icon: Icon(widget.isPlaying ? Icons.pause : Icons.play_arrow),
                  iconSize: 50,
                )
          ]
         )
      ),
    );
  }
}