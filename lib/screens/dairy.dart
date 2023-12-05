import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:school_project/screens/login.dart';
import 'package:school_project/stores/user_store.dart';
import 'package:school_project/widgets/diary/dairy_editor.dart';
import 'package:school_project/widgets/diary/diary_viewer.dart';
import 'package:school_project/widgets/diary/note_card.dart';


class MyDairy extends StatefulWidget {
   const MyDairy({Key? key}) : super(key: key);

  @override
  State<MyDairy> createState() => _MyDairyState();
}

class _MyDairyState extends State<MyDairy> {
  late String id;

  @override
  void initState() {
    UserStore userStore = Provider.of<UserStore>(context, listen: false);
    // ChatStore chatStore = Provider.of<ChatStore>(context, listen: false);
    id = userStore.user.uid?? 'testing';
    

    if(id == 'testing'){
       Future.delayed(const Duration(seconds: 2),(){
      Navigator.pushNamed(context, Login.id);
    });  
     }
    super.initState();
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children:  [
               const Text('Your recent notes', style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(height: 20.0),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('users').doc(id).collection('Notes').snapshots(),
                  builder: (context, AsyncSnapshot snapshot){
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const Center(
                        child:  CircularProgressIndicator(),
                      );
                    }
                    if(snapshot.hasData){
                      return GridView(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2
                      ),
                      children: snapshot.data!.docs.map<Widget>((note) => noteCard((){
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => NoteReaderScreen(doc: note,)));
                      }, note)).toList(),
                      );
                    }
                    return const Text('There is no Notes', style:  TextStyle(
                      color: Colors.red,
                    ));
                  }
                ),
              )
            ]
          ),
        ),
        
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
           Navigator.push(context, MaterialPageRoute(
                          builder: (context) => const NoteEditorScreen()));
        }, label: const Text("Add Notes"), icon: const Icon(Icons.add),),
    );
  }
}