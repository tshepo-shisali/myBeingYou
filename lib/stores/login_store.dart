// ignore_for_file: use_build_context_synchronously


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:school_project/main.dart';
import 'package:school_project/requests/firebase_data.dart';
import 'package:school_project/screens/student_varification.dart';
import 'package:school_project/stores/chat_store.dart';
import 'package:school_project/stores/user_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../bottom.dart';
import '../screens/login.dart';

part 'login_store.g.dart';

class LoginStore = LoginStoreBase with _$LoginStore;

abstract class LoginStoreBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
   
  @observable
  User? firebaseUser;

  @action
  Future<bool> isAlreadyAuthenticated(BuildContext context) async {
    firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      setPersonalDetailsForLoggedInUser(firebaseUser!, context);
      return true;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const Login()), (route) => false);
      return false;
    }

    
  }

  

  @action
  Future<void> signInWithGoogle(BuildContext context) async {
    
    GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await _auth.signInWithCredential(credential).then((UserCredential value) {
      if (value.user != null) {
        debugPrint('Google authentication successful');
        sharedPreferences.setString('login-provider', 'Google');
        if(value.additionalUserInfo!.isNewUser){
          onAuthenticationSuccessful(context, value);
        }else{
          // onAuthenticationSuccessful(context, value);
          onAuthenticationSuccessfulOne(context, value);
          
        }
        
      } else {
        debugPrint('Something is wrong!');
      }
    });
  }

  

  @action
  Future<void> onAuthenticationSuccessful(
      BuildContext context, UserCredential result) async {
    firebaseUser = result.user;

    setPersonalDetailsForLoggedInUser(firebaseUser!, context);

      
      

        
      Widget nextPage = const StudentVarification();
  
   Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => nextPage), (route) => false);
   
  }

  

  //two
    @action
  Future<void> onAuthenticationSuccessfulOne(
      BuildContext context, UserCredential result) async {
    firebaseUser = result.user;

    setPersonalDetailsForLoggedInUserOne(firebaseUser!, context);

 
   Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const BottomNavigationPage()), (route) => false);
  }
  //two

  void setPersonalDetailsForLoggedInUser(
      User firebaseUser, BuildContext context)async {
       
    String name = firebaseUser.displayName!;
    String email = firebaseUser.email!;
    String uid = firebaseUser.uid;
    Provider.of<UserStore>(context, listen: false)
        .setUserPersonalDetails(name, email, uid);
         
  }

  void setPersonalDetailsForLoggedInUserOne(
      User firebaseUser, BuildContext context) async{
        UserStore userStore = Provider.of<UserStore>(context, listen: false);
      ChatStore chatStore = Provider.of<ChatStore>(context, listen: false);
    String name = firebaseUser.displayName!;
    String email = firebaseUser.email!;
    String uid = firebaseUser.uid;
    Provider.of<UserStore>(context, listen: false)
        .setUserPersonalDetails(name, email, uid);

        Map userData = await getUserDataFromFirestore(uid);
                    chatStore.setUserNameAndHeadline(userData);
                    userStore.setStudentOrTherapist(true);
                     userStore.setStudentOrTherapist(chatStore.isStudent);
                     userStore.setUserLookingForJob(chatStore.isLookingForJob);
    
  }

  @action
  Future<void> signOut(BuildContext context) async {
    

    await _auth.signOut();
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const Login()), (route) => false);
    firebaseUser = null;
  }

//   Future getUserStatus(BuildContext context) async {
//      UserStore userStore = Provider.of<UserStore>(context, listen: false);
//     String? id;
//     bool? isLookingForJob;
// await FirebaseFirestore.instance.collection('user').doc(id).get().then(
//   (value) {
//     Map<bool, dynamic> data = value.data() as Map<bool,dynamic>;
//     isLookingForJob = data['isLookingForJob'];
//      userStore.setUserLookingForJob(isLookingForJob!);
//   });


//   }
}





