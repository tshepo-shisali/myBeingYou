import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_project/helpers/meeting_handler.dart';
import 'package:school_project/screens/login.dart';
import 'package:school_project/screens/meeting/schedule_meeting.dart';

import '../../helpers/chat_handler.dart';
import '../../stores/chat_store.dart';
import '../../stores/user_store.dart';

class ChatMeeting extends StatefulWidget {
  const ChatMeeting({Key? key}) : super(key: key);
  static String id = 'chat-meeting';

  @override
  State<ChatMeeting> createState() => _ChatMeetingState();
}

class _ChatMeetingState extends State<ChatMeeting> {
  late String id, peerId, groupChatId;

  @override
  void initState() {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    ChatStore chatStore  = Provider.of<ChatStore>(context, listen: false);
    id = userStore.user.uid!;
    peerId = chatStore.peerId;
    groupChatId = getGroupChatId(id, peerId);

  
    
    groupChatId = getGroupChatId(id, peerId);

    // if(id == 'testing' && peerId == 'testing'){
    //    Future.delayed(const Duration(seconds: 2),(){
    //   Navigator.pushNamed(context, Login.id);
    // });
        
    //  }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatStore>(builder: (_, chatStore, __) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          ListTile(
            visualDensity: const VisualDensity(vertical: -4),
            leading: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: Colors.black54)),
            title: const Text('Create video meeting'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              
              // fetch instant meeting URL
              // add it to the DB by calling the function on chat store
              // Don't forget to pop out of the current screen.
              Navigator.pop(context);
              String meetingLinkInstant = fetchInstantMeetingUrl(groupChatId);
              chatStore.onSendMessage('mli-$meetingLinkInstant', groupChatId, id);
            },
            leading: const Icon(Icons.flash_on, color: Colors.black54),
            title: const Text('Send instant meeting link'),
          ),
          ListTile(
            onTap: () {
              
              // Send to schedule meeting screen
              // Don't forget to pop out of the current screen.
              Navigator.pop(context);
              Navigator.pushNamed(context, ScheduleMeeting.id);

            },
            leading: const Icon(Icons.event, color: Colors.black54),
            title: const Text('Schedule a meeting for later'),
            trailing:
                const Icon(Icons.keyboard_arrow_right, color: Colors.black54),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('You are using  video meetings'),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 0)),
                  child: const Text('Select a different provider'),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
