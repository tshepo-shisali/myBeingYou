import 'package:flutter/material.dart';
import 'package:school_project/screens/login.dart';
import 'package:school_project/stores/chat_store.dart';
import 'package:provider/provider.dart';
import 'package:school_project/stores/user_store.dart';

class ChatWindowUser extends StatefulWidget {
  const ChatWindowUser({Key? key}) : super(key: key);

  @override
  State<ChatWindowUser> createState() => _ChatWindowUserState();
}

class _ChatWindowUserState extends State<ChatWindowUser> {

  // late String peerName;
  

  //  @override
  //    void initState() {
    
  //    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    
  //   peerName = userStore.user.peerName?? "k";
    
    

  //    if(peerName == 'k'){
      
      
  //       Future.delayed(const Duration(seconds: 3),(){
  //     Navigator.pushNamed(context, Login.id);
  //   });

  //    }else{
      
   
  //    }
  //   super.initState();
  // }


  @override
  Widget build(BuildContext context) {
    return Consumer<ChatStore>(builder: (_, chatStore, __) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/happy.png'),
              ),
            ),
            Text(chatStore.peerName,
                style: Theme.of(context).textTheme.subtitle2),
            const Text(
                ''),
          ],
        ),
      );
    });
  }
}
