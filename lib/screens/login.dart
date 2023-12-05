
import 'package:flutter/material.dart';

import '../../widgets/login/login_button.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  static String id = 'login';

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  
                  height: 100,
                  width: 100,
                  child: Image.asset('assets/leaf.png',
                  fit: BoxFit.fill),
                  ),
                const SizedBox(height: 10),
                      Text('Being',
                      style: Theme.of(context).primaryTextTheme.headline1,),
                      Text('You',
                      style: Theme.of(context).primaryTextTheme.headline2,),
                loginScreenButtons(context),
                const SizedBox(height: 10),
                Text('Login to continue',
                style: Theme.of(context).primaryTextTheme.subtitle1,)
              ],
            ),
   
      ),
        ),
      ),
    );
  }
}
