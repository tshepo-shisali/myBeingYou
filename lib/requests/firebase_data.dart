// Interact with cloud Firestore, and handle data

// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

void setUserDataInFirestore(User user) {
  firebaseFirestore.collection('users').doc(user.uid).set({
    'uid': user.uid,
    'name': user.name,
    'email': user.email,
    'address': user.address,
    'isStudent': user.isStudent,
    'peerId': user.peerId,
    'isLookingForJob': user.isLookingForJob,
    'location': user.location,
    'studentDetails': user.studentDetails,
    'jobDetails': user.jobDetails,
  });
}

Future<Map> getUserDataFromFirestore(String uid) async {
  DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  Map docData = doc.data() as Map;
  return docData;
}

Future getPeerDataFromFirestore(String uid) async {
  DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
  Map docData = doc.data() as Map;
  return docData;
}




void setTherapistFirestore(User user) {
  firebaseFirestore.collection('therapist').doc(user.uid).set({
    'name': user.name,
    'email': user.email,
    'peerId': user.peerId,
  });
}


void setStudentFirestore(User user) {
  firebaseFirestore.collection('student').doc(user.uid).set({
    'name': user.name,
    'peerId': user.peerId,
    'email': user.email,
  });
}

// void seFirestore(User user) {
//   firebaseFirestore.collection('therapist').doc(user.uid).collection('therapist').doc(user.uid).set({
//     'name': user.name,
//     'peerId': user.peerId,
//     'email': user.email,
//   });
// }




