// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:school_project/screens/login.dart';
import 'package:school_project/screens/professional_info.dart';
import 'package:school_project/stores/user_store.dart';
import 'package:provider/provider.dart';
import 'package:school_project/requests/firebase_data.dart';
import 'package:school_project/stores/chat_store.dart';
import 'dart:math';

class StudentVarification extends StatefulWidget {
  const StudentVarification({Key? key,}) : super(key: key);

static String id = 'student-Varification';

  @override
  State<StudentVarification> createState() => _StudentVarificationState();
}

class _StudentVarificationState extends State<StudentVarification> {
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
    
    }
    setState(() {
     
    });
   
    
  }

  @override
  void initState(){
    
    // getDocId();
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    
    id = userStore.user.uid?? 'testing';
    peerName = userStore.user.peerName?? 'testing';
    name = userStore.user.name?? 'testing';
    
    
    
    //  student = userStore.user.isStudent?? true;
     
     if(id == 'testing'){
       Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushNamed(context, Login.id);
    });
        
     }else{
      Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushNamed(context, ProfessionalInfo.id);
      setUserDataInFirestore(userStore.user);
      });
     }
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    CollectionReference therapist = FirebaseFirestore.instance.collection('stuff');

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
        child: Center(
          child: FutureBuilder<DocumentSnapshot>(
            future: therapist.doc(id).get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot){
              if(snapshot.hasError){
                Future.delayed(const Duration(seconds: 3),(){
              Navigator.pushNamed(context, Login.id);
                
    });
               return const Text("Something went wrong please reload");
                 
              }
              if(snapshot.hasData && !snapshot.data!.exists){
                userStore.setStudentOrTherapist(true);
                getDocId();
                userStore.setUserLookingForJob(true);
                setStudentFirestore(userStore.user);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const Text("Student name: ", style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color:Color(0xffcdd0f9),
                  )),
                    const SizedBox(height: 10),
                    Text(userStore.user.name!, style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color:Color(0xffcdd0f9),
                  )),
                  ],
                );
              }
              if(snapshot.hasData && snapshot.data!.exists){
                userStore.setStudentOrTherapist(false);
                setTherapistFirestore(userStore.user);
        userStore.setUserLookingForJob(true);
        setUserDataInFirestore(userStore.user);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                     const Text("Therapist name:", style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color:Color(0xffcdd0f9),
                  )),
                     const SizedBox(height: 10),
                     Text(userStore.user.name!, style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color:Color(0xffcdd0f9),
                  )),
                  ],
                );
              }
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                   Text('Varifying if you are a student', style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color:Color(0xffcdd0f9),
                  )),
                   SizedBox(height: 10),
                   CircularProgressIndicator(),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}