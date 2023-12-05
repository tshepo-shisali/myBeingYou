import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:school_project/screens/chat/chat_screen.dart';
import 'package:school_project/services/validations.dart';
import 'package:provider/provider.dart';
import 'package:school_project/screens/login.dart';
import 'package:school_project/stores/user_store.dart';
import 'package:school_project/widgets/profile/profile_button.dart';
import 'package:school_project/widgets/meeting/video_button.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  static String id = 'profile-screen';

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

 String name = 'Default name',
  email = " ",
      image =
          'https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg';
  bool hasTherapist = false;
  bool student = false;
  @override
  void initState() {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    
    name = userStore.user.name?? "k";
    email = userStore.user.email?? "testing.@gmail.com";
    
    hasTherapist = userStore.user.isLookingForJob?? true;
    student = userStore.user.isStudent?? true;
     
     if(name == 'k' && email == "testing.@gmail.com" ){
      
      
        Future.delayed(const Duration(seconds: 3),(){
      Navigator.pushNamed(context, Login.id);
    });

     }else{
      name = userStore.user.name!;
    email = userStore.user.email!;
    
    hasTherapist = userStore.user.isLookingForJob!;
    student = userStore.user.isStudent!;
     }
    super.initState();
  }


   onPressedHandler() async {
    
   if(student == false){
      hasTherapist = true;
    }
    
     if(student){
      bool next = requestingTherapist(hasTherapist, context);
      if(next == false){
                      Navigator.pushNamed(context, ChatScreen.id);
                    }
      
    }else{
       isTherapist(hasTherapist, context);
    }
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                         const CircleAvatar(
                       backgroundImage: AssetImage('assets/happy.png'), radius: 30,
                      ),
                      const SizedBox(height: 10),
                      Text(name, 
                      style: Theme.of(context).primaryTextTheme.headline5,
                      ),
                      const SizedBox(height: 10),
                       Text(email, 
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                      ),
                      const SizedBox(height: 20),
                    VideoButton(onPressed: onPressedHandler, text: 'Request a therapist', subText: 'Specifically for students'),
                      const SizedBox(height: 20),
                    ProfileButton(onPressed: () {}, icon: LineAwesomeIcons.user_shield, text: 'Privacy', color: const Color.fromARGB(255, 86, 90, 172),),
                    const SizedBox(height: 20),
                    ProfileButton(onPressed: () {}, icon: LineAwesomeIcons.question_circle, text: 'Help & Support', color:  const Color.fromARGB(255, 86, 90, 172),),
                    const SizedBox(height: 20),
                     ProfileButton(onPressed: () {}, icon: LineAwesomeIcons.cog, text: 'Settings', color: const Color.fromARGB(255, 86, 90, 172),),
                    const SizedBox(height: 20),
                    ProfileButton(onPressed: () {}, icon: LineAwesomeIcons.add_to_shopping_cart, text: 'Privacy', color:const Color.fromARGB(255, 86, 90, 172),),
                    const SizedBox(height: 20),
                    ProfileButton(onPressed: () {
                     
                       Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const Login())));
                    }, icon: LineAwesomeIcons.alternate_sign_out, text: 'Logout', color: const Color(0xff050729),),
                    const SizedBox(height: 20),

                ]
       ),
            ),
          ),
       ),
     
     
    );
  }
}
