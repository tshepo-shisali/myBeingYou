import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:school_project/widgets/diary/app_style.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc){
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doc['note_title'],
          style: const TextStyle(
            fontSize: 18,
            )),
            Text(doc['creation_date'],
          style: const TextStyle(
            fontSize: 16,
            )),
            const SizedBox(height: 16.0,),
            Text(doc['note_content'],
          style: const TextStyle(
            fontSize: 14,
            ),
            overflow: TextOverflow.ellipsis,),
          ],
      )
    ),
  );
}