// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:school_project/stores/login_store.dart';
import 'package:provider/provider.dart';

Widget loginButton(
  //String icon,
    String text, Function onPressedHandler, BuildContext context) {
  return GestureDetector(
    onTap: () => onPressedHandler(),
    child: Padding(
      padding: const EdgeInsets.all(18.0),

      child: Container(
        
        decoration: BoxDecoration(
            color: const Color(0xff050729),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
              blurRadius: 10,
              color: Colors.black.withOpacity(0.06),
              offset: const Offset(0, 4)
            ),
            ],
          ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          SizedBox(
            height: 35,
            width: 50,
            child: Image.asset('assets/google.png',
            fit: BoxFit.fill),
          ),
          Text(text,
          style: Theme.of(context).primaryTextTheme.subtitle1,)
        ]),
      ),
      
    ),
  );
}


Widget loginScreenButtons(BuildContext context) {
  void googleLoginHandler() {
    print('Google Login');
    Provider.of<LoginStore>(context, listen: false).signInWithGoogle(context);
    

  }

 
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      loginButton('Sign In With Google',
          googleLoginHandler, context),
      
    ],
  );
}
// 'assets/icon/google.png',