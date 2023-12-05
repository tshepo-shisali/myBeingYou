import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_project/screens/login.dart';
import 'package:school_project/stores/chat_store.dart';
import 'package:school_project/stores/user_store.dart';
import 'package:school_project/widgets/chat/chat_window.dart';
import 'package:school_project/widgets/chat/chat_meeting.dart';
import 'package:provider/provider.dart';

import '../../helpers/chat_handler.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
  static String id = 'chat-screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late String id, peerId, groupChatId, peerName;

  @override
  void initState() {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    ChatStore chatStore = Provider.of<ChatStore>(context, listen: false);
    id = userStore.user.uid?? 'testing';
    peerId = chatStore.peerId;
    peerName = userStore.user.peerName?? 'testing';
    groupChatId = getGroupChatId(id, peerId);
    super.initState();

    if(id == 'testing' && peerId == 'testing' && peerName == 'testing'){
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
          title: Text(peerName),
          actions: [
            // IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            PopupMenuButton(
                itemBuilder: (_) => [
                      PopupMenuItem(
                          onTap: () => FirebaseFirestore.instance
                                  .collection('Messages')
                                  .doc(groupChatId)
                                  .collection(groupChatId)
                                  .get()
                                  .then((snapshot) {
                                for (DocumentSnapshot ds in snapshot.docs) {
                                  ds.reference.delete();
                                }
                              }),
                          child: const Text('Delete conversation'))
                    ]),
            IconButton(onPressed: () {
              showModalBottomSheet(context: context,
              builder: (BuildContext context){
                return const ChatMeeting();
              });
            }, icon: const Icon(Icons.video_call)),
          ],
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
          child: const SafeArea(
            child: ChatWindow(),
          ),
        ),
      );
    });
  }
}



















// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:school_project/screens/meeting/schedule_meeting.dart';
// import 'package:school_project/stores/chat_store.dart';
// import 'package:school_project/stores/user_store.dart';
// import 'package:school_project/widgets/chat/chat_window.dart';


// import 'package:provider/provider.dart';

// import '../../helpers/chat_handler.dart';
// import '../../helpers/meeting_handler.dart';

// class ChatScreen extends StatefulWidget {
//   const ChatScreen({Key? key}) : super(key: key);
//   static String id = 'chat-screen';

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   late String id, peerId, groupChatId;

//   @override
//   void initState() {
//     UserStore userStore = Provider.of<UserStore>(context, listen: false);
//     ChatStore chatStore = Provider.of<ChatStore>(context, listen: false);
//     id = userStore.user.uid!;
//     peerId = chatStore.peerId;
//     groupChatId = getGroupChatId(id, peerId);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ChatStore>(builder: (_, chatStore, __) {
//       return Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//             icon: const Icon(Icons.arrow_back),
//             onPressed: () => Navigator.pop(context),
//           ),
//           title: Text(chatStore.peerName),
//           actions: [
//             PopupMenuButton(
//                 icon: const Icon(Icons.more_vert),
//                 itemBuilder: (_) => [
//                       PopupMenuItem(
//                           onTap: () => FirebaseFirestore.instance
//                                   .collection('Messages')
//                                   .doc(groupChatId)
//                                   .collection(groupChatId)
//                                   .get()
//                                   .then((snapshot) {
//                                 for (DocumentSnapshot ds in snapshot.docs) {
//                                   ds.reference.delete();
//                                 }
//                               }),
//                           child: const Text('Delete conversation'))
//                     ]),
//             IconButton(
//                 onPressed: () {
//                   showModalBottomSheet(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Divider(),
//                           ListTile(
//                             visualDensity: const VisualDensity(vertical: -4),
//                             leading: IconButton(
//                                 padding: EdgeInsets.zero,
//                                 constraints: const BoxConstraints(),
//                                 onPressed: () => Navigator.pop(context),
//                                 icon: const Icon(Icons.close,
//                                     color: Colors.black54)),
//                             title: const Text('Create video meeting'),
//                           ),
//                           const Divider(),
//                           ListTile(
//                             onTap: () {
//                               Navigator.pop(context);
//                               String meetingLinkInstant =
//                                   fetchInstantMeetingUrl(groupChatId);
//                               chatStore.onSendMessage(
//                                   'mli-$meetingLinkInstant', groupChatId, id);
//                             },
//                             leading: const Icon(Icons.flash_on,
//                                 color: Colors.black54),
//                             title: const Text('Send instant meeting link'),
//                           ),
//                           ListTile(
//                             onTap: () {
//                               Navigator.pop(context);
//                               Navigator.pushNamed(context, ScheduleMeeting.id);
//                             },
//                             leading:
//                                 const Icon(Icons.event, color: Colors.black54),
//                             title: const Text('Schedule a meeting for later'),
//                             trailing: const Icon(Icons.keyboard_arrow_right,
//                                 color: Colors.black54),
//                           ),
//                           const Divider(),
//                           Padding(
//                             padding: const EdgeInsets.all(15),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                     'You are using LinkedIn video meetings'),
//                                 TextButton(
//                                   onPressed: () {},
//                                   style: TextButton.styleFrom(
//                                       padding: const EdgeInsets.only(left: 0)),
//                                   child:
//                                       const Text('Select a different provider'),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//                 icon: const Icon(Icons.video_call)),
//           ],
//         ),
//         body: const SafeArea(
//           child: ChatWindow(),
//         ),
//       );
//     });
//   }
// }
