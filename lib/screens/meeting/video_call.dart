import 'package:flutter/material.dart';
import 'package:school_project/helpers/meeting_handler.dart';
import 'package:school_project/screens/login.dart';
import 'package:school_project/screens/meeting/schedule_meeting.dart';
import 'package:school_project/stores/chat_store.dart';
import 'package:school_project/stores/user_store.dart';
import 'package:provider/provider.dart';
import 'package:school_project/widgets/meeting/video_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../helpers/chat_handler.dart';

class VideoCall extends StatefulWidget {
  const VideoCall({Key? key}) : super(key: key);
  static String id = 'video-screen';

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  late String id, peerId, groupChatId;
  

  @override
  void initState() {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    
    id = userStore.user.uid?? 'testing';
    peerId = userStore.user.peerId?? 'testing';
    groupChatId = getGroupChatId(id, peerId);

    if(id == 'testing' && peerId == 'testing'){
       Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushNamed(context, Login.id);
    });  
     }
    super.initState();
  }
 

 
  

  @override
  Widget build(BuildContext context) {
   
    return Consumer<ChatStore>(builder: (_, chatStore, __) {
      return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text('Meeting'),
        ),
        body: Container(
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
            
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 10,),
             const Text('Remember to communicate with your ',
             style: TextStyle(
                      color: Colors.white,
                      
                    ),),
             const Text('therapist before creating an instant meeting',
             style: TextStyle(
                      color: Colors.white,
                      
                    ),),
             const SizedBox(height: 10,),
             VideoButton(
              onPressed: () async {
                    String meetingLinkInstant = fetchInstantMeetingUrl(groupChatId);
                    final url = 'https://$meetingLinkInstant';
                    chatStore.onSendMessage('mli-$meetingLinkInstant', groupChatId, id);
                    if (await canLaunchUrlString(url)){
                     await launchUrlString(
                     url,
                     mode: LaunchMode.platformDefault,
                     webOnlyWindowName: '_blank',
                     
                     );
                    }
                 },
                  text: "New meeting",
                  subText: 'A link will be send to chats',
                  ),
              
              
               const SizedBox(height: 10,),
                VideoButton(onPressed: () {
                   Navigator.pushNamed(context, ScheduleMeeting.id);
                 },
                  text: "Schedule a meeting ",
                  subText: 'A link will be send to chats',
                  ),
                
            ],
            ),
        ),
      );
    });
  }
}
