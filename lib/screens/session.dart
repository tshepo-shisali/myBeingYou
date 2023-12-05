import 'package:school_project/screens/chat/chat_list.dart';
import 'package:school_project/screens/meeting/video_call.dart';
import 'package:school_project/widgets/meeting/consult_widget.dart';
import 'package:school_project/widgets/meeting/meeting_button.dart';
import 'package:flutter/material.dart';

class Session extends StatelessWidget {
  const Session({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment(0.8 , 1),
            colors: <Color> [
              Color(0xff050729),
              Color(0xff0b1060),
              Color(0xff0e157c),
              Color(0xff111a97),
              Color(0xff434eea),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 18.0),
            child: Text('How It Works?', style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xffcdd0f9),
             ),),
          ),
          const SizedBox(height: 10,),
          const ConsultWidget(),
           const Padding(
             padding: EdgeInsets.only(left: 18.0),
             child: Text('Consult', style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xffcdd0f9),
             ),),
           ),
          const SizedBox(height: 10,),
          MeetingButton(
            onPressed: () => Navigator.pushNamed(context, VideoCall.id),
            image: 'assets/happy.png',
            subText: 'Upcoming meetings',
            text: 'Schedule a meeting with a therapist',),
           MeetingButton(
           onPressed: () => Navigator.pushNamed(context, ChatList.id),
            image: 'assets/envy.png',
            subText: 'Ask your theraoist anything',
            text: 'Chat with your therapist',),
        ],
      ),
    );
  }
}