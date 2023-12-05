

// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:school_project/screens/login.dart';
import 'package:school_project/stores/user_store.dart';
import 'package:flutter/material.dart';
import 'package:school_project/widgets/diary/app_style.dart';

class NoteEditorScreen extends StatefulWidget {
   const NoteEditorScreen({Key? key}) : super(key: key);

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {

  final TextEditingController _titleController = TextEditingController();
  String date = DateTime.now().toString();
  final TextEditingController _mainController = TextEditingController();
  int colorId = Random().nextInt(AppStyle.cardsColor.length);

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
       backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colorId],
        elevation: 0.0,
        title: const Text('Add a new dairy notes'),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                
                hintText: 'Notes title'
              ),
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0,),
            Text(date, style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            ),
            const SizedBox(height: 28.0,),
            TextField(
              controller: _mainController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Write how you feel'
              ),
              maxLines: null,
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ]
          ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()async{
          FirebaseFirestore.instance.collection('users').doc(id).collection('Notes').add({
            'note_title': _titleController.text,
            'creation_date': date,
            'note_content': _mainController.text,
            'color_id': colorId,
          }).then((value) {
            Navigator.pop(context);
          }).catchError((onError) => debugPrint('Failed to add new Notes due to $onError'));
        }, label: const Text("Add Notes"), icon: const Icon(Icons.save),),
    );
  }
}