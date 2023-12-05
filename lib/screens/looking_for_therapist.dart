// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_project/bottom.dart';
import 'package:school_project/main.dart';
import 'package:school_project/requests/firebase_data.dart';
import 'package:school_project/screens/login.dart';
import 'package:school_project/stores/chat_store.dart';
import 'package:school_project/stores/user_store.dart';
import 'dart:math';


class LookingForTherapist extends StatefulWidget {
  const LookingForTherapist({Key? key}) : super(key: key);
  static String id = 'looking-for-job';

  @override
  State<LookingForTherapist> createState() => _LookingForTherapistState();
}

class _LookingForTherapistState extends State<LookingForTherapist> {
   late String peerId;
   late String peerName;
   late String id;
   late bool isStudent;
   late String name;

    late List<String> docIds = [];
String  peerImage = 'https://www.britannica.com/plant/water-lily', myImage = 'https://www.britannica.com/plant/water-lily';
  Future getDocId() async {

     UserStore userStore = Provider.of<UserStore>(context, listen: false);
      ChatStore chatStore = Provider.of<ChatStore>(context, listen: false);
    await FirebaseFirestore.instance.collection('therapist').get().then(
      (snapshot) => snapshot.docs.forEach((element){
        debugPrint(element.reference.id);
        docIds.add(element.reference.id);

      }),
    );
    // print(docIds);
     final random = Random();
    if(docIds.isNotEmpty){
    peerId = docIds[random.nextInt(docIds.length)];
    debugPrint( 'id: $peerId');
    }else {
      
      peerId = '';
      debugPrint( 'id: $peerId');
    
    }
    Map userData = await getUserDataFromFirestore(peerId);
                    chatStore.setPeerNameAndHeadline(userData);
                    chatStore.setProfileImages(peerImage, myImage);
                    userStore.setPeerName(chatStore.peerName);
    userStore.setPeerId(peerId);
    chatStore.setPeerId(peerId);
    
    
 
   
    if(id != 'testing'){
      CollectionReference users = firebaseFirestore.collection('therapist');
   await users.doc(peerId).collection('Students').doc(id).set({
    'uid': id,
    'name': name,
    });
   CollectionReference peeruser = firebaseFirestore.collection('student');
   await peeruser.doc(id).collection('Therapist').doc(peerId).set({
    'uid': peerId,
    'name': chatStore.peerName,
    });
    setStudentFirestore(userStore.user);
    }
    setState(() {
     
    });
   
    
  }

  @override
  void initState(){
    getDocId();
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    
    id = userStore.user.uid?? 'testing';
    peerName = userStore.user.peerName?? 'testing';
    name = userStore.user.name?? 'testing';
    
    
    
    //  student = userStore.user.isStudent?? true;
     
     if(id == 'testing'){
       Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushNamed(context, Login.id);
    });
        
     }
    
    super.initState();
  }

   

void onPressedHandler(String label, BuildContext context) {
  UserStore userStore = Provider.of<UserStore>(context, listen: false);
  
  
  
  if (label == 'Yes') {
     
      

    
    userStore.setUserLookingForJob(true);
    setStudentFirestore(userStore.user);
  } else {
    userStore.setUserLookingForJob(false);
  }

  // At this stage everything is done and stored in Provider
  // We shall send a request to Cloud Firestore
  setUserDataInFirestore(userStore.user);
  
  sharedPreferences.setBool('details-in-firestore', true);

  // Then move the home management screen
  Navigator.pushNamed(context, BottomNavigationPage.id);
}

Widget jobButton(String label, BuildContext context) {
  return OutlinedButton(
    onPressed: () => onPressedHandler(label, context),
    style: OutlinedButton.styleFrom(padding: const EdgeInsets.all(20)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.subtitle1
          ?.copyWith(color: Colors.white,),
        ),
      ],
    ),
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                const SizedBox(height: 50),
                Text('Are you looking for a Therapist right now?',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 5),
                Text(
                    'We can help you prepare for your search. Your response is private to you.',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge
                        ?.copyWith(color: Colors.grey)),
                const SizedBox(height: 30),
                jobButton('Yes', context),
                const SizedBox(height: 15),
                jobButton('Now now', context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

