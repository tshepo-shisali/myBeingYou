import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:school_project/routes.dart';
import 'package:school_project/screens/login.dart';
import 'package:school_project/stores/chat_store.dart';
import 'package:school_project/stores/login_store.dart';
import 'package:school_project/stores/user_store.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

late SharedPreferences sharedPreferences;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        Provider<LoginStore>(create: (_) => LoginStore()),
        Provider<UserStore>(create: (_) => UserStore()),
        Provider<ChatStore>(create: (_) => ChatStore()),
        
      ],
      child: MaterialApp(
        title: 'Being You',
        debugShowCheckedModeBanner: false,
        
        theme: ThemeData(
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: const Color(0xff050729),
          ),
          scaffoldBackgroundColor: Colors.blue,
        ),
        home: const Login(),
          routes: routes,
        ),
        
      );
    
  }
  }
 
  
 
