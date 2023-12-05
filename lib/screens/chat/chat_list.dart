// ignore_for_file: non_constant_identifier_names, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:school_project/requests/firebase_data.dart';
import 'package:school_project/screens/chat/chat_screen.dart';
import 'package:school_project/screens/login.dart';
import 'package:school_project/services/validations.dart';
import 'package:school_project/stores/chat_store.dart';
import 'package:school_project/stores/user_store.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class ChatList extends StatefulWidget {
  const ChatList({Key? key}) : super(key: key);
  static String id = 'chat-list';

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {

  late bool hasTherapist;
     late bool student;
     late String id;

    

  @override
  void initState() {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    
    id = userStore.user.uid?? 'testing';
    
    
    hasTherapist = userStore.user.isLookingForJob?? true;
     student = userStore.user.isStudent?? true;
     
     if(id == 'testing'){
       Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushNamed(context, Login.id);
    });
        
     }
     
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    ChatStore chatStore = Provider.of<ChatStore>(context, listen: false);
    String  peerImage = 'https://www.britannica.com/plant/water-lily', myImage = 'https://www.britannica.com/plant/water-lily';
    
    // late String id;
    late String peerId;
    late String collection_name_main;
    late String collection_name_sub;
    // late bool hasTherapist = userStore.user.isLookingForJob!;
    // late bool student = userStore.user.isStudent!;

    // id = userStore.user.uid!;

    if(student == false){
      hasTherapist = true;
      collection_name_main = 'therapist';
      collection_name_sub = 'Students';
    }else{
      collection_name_main = 'student';
      collection_name_sub = 'Therapist';
    }

    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Messaging'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.rate_review))
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
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot<dynamic>>(
          stream: FirebaseFirestore.instance.collection(collection_name_main).doc(id).collection(collection_name_sub).snapshots(),
          builder: (context, AsyncSnapshot<dynamic> snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child:  CircularProgressIndicator(),
            );
          }
          if(snapshot.hasData){
            return ListView.builder(
             itemCount: snapshot.data!.docs.length,
             itemBuilder: (_, index){
              DocumentSnapshot doccc = snapshot.data!.docs[index];
               return Padding(
                 padding: const EdgeInsets.all(6.0),
                 child: Material(
                   child: ListTile(
                    leading: Image.asset('assets/happy.png',),
                    tileColor: const Color(0xff050729),
                    title: Text(doccc["name"], style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,)),
                   onTap: () async {
                    peerId = doccc["uid"];
                    
                    Map userData = await getUserDataFromFirestore(peerId);
                     chatStore.setPeerNameAndHeadline(userData);
                      userStore.setPeerId(peerId);
                    chatStore.setPeerId(peerId);
                     userStore.setPeerName(chatStore.peerName); 
                    chatStore.setProfileImages(peerImage, myImage);
                     if(student){
                    bool next = checkValidTherapist(hasTherapist, context);
                    if(next == true){
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
                    }else{
                    Navigator.pushNamed(context, ChatScreen.id);
                    }  
                   },
                   ),
                 ),
               );
               
               }
             );
          }
          return const Text('There are no peers reload the page', style:  TextStyle(
            color: Colors.red,
          ));
          }
            ),
        ),
      ),
    );
  }
}

































// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:school_project/screens/chat/chat_screen.dart';
// import 'package:school_project/stores/user_store.dart';
// import 'package:provider/provider.dart';

// import '../../requests/firebase_data.dart';
// import '../../stores/chat_store.dart';

// class ChatList extends StatefulWidget {
//   const ChatList({Key? key}) : super(key: key);
//   static String id = 'chat-list';

//   @override
//   State<ChatList> createState() => _ChatListState();
// }

// class _ChatListState extends State<ChatList> {
//   onPressedHandler() async {
//     // peerId will be known when we tap on it
//     String peerId = '', peerImage = '', myImage = '';

//     String MARYID = '0PxXcoXfy4VtvAvSL0jhTd9HnG22',
//         MARYIMAGE = 'https://i.pravatar.cc/192?img=5';
//     String ABID = 'cjqsIpofEeae0y9NMnCfJUhn4hb2',
//         ABIMAGE = '5V3HgDfju3eqvc2aPkCJl9CJ2B63';

//     UserStore userStore = Provider.of<UserStore>(context, listen: false);
//     String id = userStore.user.uid!;

//     if (id == MARYID) {
//       myImage = MARYIMAGE;
//       peerId = ABID;
//       peerImage = ABIMAGE;
//     } else {
//       myImage = ABIMAGE;
//       peerId = MARYID;
//       peerImage = MARYIMAGE;
//     }

//     ChatStore chatStore = Provider.of<ChatStore>(context, listen: false);
//     chatStore.setPeerId(peerId);
//     Map userData = await getUserDataFromFirestore(peerId);
//     chatStore.setPeerNameAndHeadline(userData);
//     chatStore.setProfileImages(peerImage, myImage);
//     Navigator.pushNamed(context, ChatScreen.id);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         title: const Text('Messaging'),
//         actions: [
//           IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
//           IconButton(onPressed: () {}, icon: const Icon(Icons.rate_review))
//         ],
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             CupertinoTextField(
//               style: Theme.of(context).textTheme.subtitle1,
//               prefix: const Padding(
//                   padding: EdgeInsets.all(15),
//                   child: Icon(Icons.search, color: Colors.grey)),
//               placeholder: 'Search messages',
//               suffix: const Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Icon(Icons.tune, color: Colors.grey),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     for (int i = 0; i < 2; i++)
//                       Column(
//                         children: [
//                           ListTile(
//                             onTap: onPressedHandler,
//                             isThreeLine: true,
//                             leading: CircleAvatar(
//                                 backgroundImage: NetworkImage(
//                                     'https://i.pravatar.cc/192?img=$i')),
//                             title: const Text('Neeta Singh Mehta'),
//                             subtitle: const Text(
//                                 'Exciting engineering role at Amazon. You can apply now here and contact with me to proceed further with the interviews',
//                                 overflow: TextOverflow.ellipsis,
//                                 maxLines: 2),
//                           ),
//                           const Divider(indent: 60),
//                         ],
//                       ),
//                   ],
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

