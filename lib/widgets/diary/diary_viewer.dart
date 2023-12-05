// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_project/widgets/diary/app_style.dart';

// ignore: must_be_immutable
class NoteReaderScreen extends StatefulWidget {
  QueryDocumentSnapshot doc;
  NoteReaderScreen({
    Key? key,
    required this.doc,
  }) : super(key: key);
  

  @override
  State<NoteReaderScreen> createState() => _NoteReaderScreenState();
}

class _NoteReaderScreenState extends State<NoteReaderScreen> {
  @override
  Widget build(BuildContext context) {
    int colorId = widget.doc['color_id'];
    return Scaffold(
      backgroundColor: AppStyle.cardsColor[colorId],
      appBar: AppBar(
        backgroundColor: AppStyle.cardsColor[colorId],
        elevation: 0.0,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        
      ),
  body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.doc['note_title'],
            style: const TextStyle(
              fontSize: 18,
              )),
              Text(widget.doc['creation_date'],
            style: const TextStyle(
              fontSize: 16,
              )),
              const SizedBox(height: 28.0,),
              Text(widget.doc['note_content'],
            style: const TextStyle(
              fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 100,),
            ],
      ),
    ),
  )
    );
  }
}