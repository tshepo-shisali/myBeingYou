
import 'package:flutter/material.dart';

class ConsultWidget extends StatelessWidget {
  const ConsultWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(
              color: const Color(0xff434eea),
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
                  children: const [
                    Icon(Icons.add, size: 25,),
                    Text('Schedule', style: TextStyle(
                      fontWeight: FontWeight.normal,
                      
                    ),
                    overflow: TextOverflow.ellipsis,),
                    Text('appointment', style: TextStyle(
                      fontWeight: FontWeight.normal,
                      
                    ),
                    overflow: TextOverflow.ellipsis,),
                  ],
                )),
              Expanded(
                child: Column(
                  children: const [
                    Icon(Icons.video_call, size: 25,),
                    Text('Join video call', style: TextStyle(
                      fontWeight: FontWeight.normal,
                      
                    ),
                    overflow: TextOverflow.ellipsis,),
                    Text('to talk to therapist', style: TextStyle(
                      fontWeight: FontWeight.normal,
                      
                    ),
                    overflow: TextOverflow.ellipsis,),
                  ],
                )),
              Expanded(
                child: Column(
                  children: const [
                    Icon(Icons.favorite,size: 25,),
                    Text('Be happy', style: TextStyle(
                      fontWeight: FontWeight.normal,
                      
                    ),
                    overflow: TextOverflow.ellipsis,),
                    Text('Be an A+ student', style: TextStyle(
                      fontWeight: FontWeight.normal,
                      
                    ),
                    overflow: TextOverflow.ellipsis,),
                  ],
                )),
            ],
          ),
        ),
      ),
    );
  }
}