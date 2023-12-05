// Store all routes in a global variable

import 'package:school_project/screens/professional_info.dart';
import 'package:school_project/screens/chat/chat_list.dart';
import 'package:school_project/screens/chat/chat_screen.dart';
import 'package:school_project/screens/meeting/video_call.dart';
import 'package:school_project/screens/student_varification.dart';
import 'package:school_project/widgets/chat/chat_meeting.dart';
import 'package:school_project/bottom.dart';
import 'package:school_project/screens/login.dart';
import 'package:school_project/screens/looking_for_therapist.dart';
import 'package:school_project/screens/meeting/schedule_meeting.dart';

final routes = {
  
  Login.id: (context) => const Login(),
  ProfessionalInfo.id: (content) => const ProfessionalInfo(),
   
 
  LookingForTherapist.id: (context) => const LookingForTherapist(),
  BottomNavigationPage.id: (context) => const BottomNavigationPage(),
  StudentVarification.id: (context) => const StudentVarification(),
  ChatList.id: (context) => const ChatList(),
   
  VideoCall.id: (context) => const VideoCall(),
  ChatScreen.id: (context) => const ChatScreen(),
  ChatMeeting.id: (context) => const ChatMeeting(),
  ScheduleMeeting.id: (context) => const ScheduleMeeting(),
};
