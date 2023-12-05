// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_project/helpers/meeting_handler.dart';
import 'package:url_launcher/link.dart';


Widget showChatItemBasedOnType(
      DocumentSnapshot document, BuildContext context, String name) {
  // Expand this more as per need
  String type = document.get('content');
  String index = type[0] + type[1] + type[2];
  if (index == 'mli') {
    // Meeting Link Instant
    return instantMeetingItemContent(document, context, name);
  } else if (index == 'mls') {
    // Meeting Link Scheduled
    return scheduledMeetingItemContent(document, context, name);
  } else {
    // Chat text item
    return chatItemContent(document);
  }
}

Widget chatItemHeader(String name, String image, DocumentSnapshot document,
    BuildContext context) {
  return Row(
    children: [
      const CircleAvatar(backgroundImage: AssetImage('assets/relax.png')),
      const SizedBox(width: 10),
      Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      const Text(' • ', style: TextStyle(color: Colors.black54)),
      Text(
        DateFormat('dd MMM kk:mm').format(DateTime.fromMillisecondsSinceEpoch(
            int.parse(document.get('timestamp')))),
        style: Theme.of(context).textTheme.caption,
      ),
    ],
  );
}

Widget chatItemContent(DocumentSnapshot document) {
  return Container(
    constraints: const BoxConstraints(maxWidth: 400),
    padding: const EdgeInsets.symmetric(horizontal: 50),
    child: Text(document.get('content') + '   .'),
  );
}

Widget instantMeetingItemContent(
    DocumentSnapshot document, BuildContext context, String name) {
  String url = document.get('content').split('-')[1];
  return Padding(
    padding: const EdgeInsets.only(left: 50, right: 20, top: 5, bottom: 5),
    child: Link(
      uri: Uri.parse('https://$url'),
      target: LinkTarget.blank,
      builder: (context, followLink){ 
      return OutlinedButton(
        onPressed: followLink,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              const Icon(Icons.video_call),
              const VerticalDivider(),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${name.split(' ')[0]}'s meeting",
                      style: Theme.of(context).textTheme.subtitle2),
                  const SizedBox(height: 5),
                  const Text('Join video meeting')
                ],
              ),
            ],
          ),
        ),
      );
      },
    ),
  );
}

Widget scheduledMeetingItemContent(
    DocumentSnapshot document, BuildContext context, String name) {
      
  String url = document.get('content').split('-')[1];
  Map meetingDetails = fetchDetailsFromEncodedScheduledMeetingUrl(url);
  // bool meetingJoinedTooEarly = checkIfJoinMeetingTooEarly(
  //           meetingDetails['date'], meetingDetails['time'], context);
  return Padding(
    padding: const EdgeInsets.only(left: 50, right: 20, top: 5, bottom: 5),
    child: Link(
      uri: Uri.parse('https://$url'),
      target: LinkTarget.blank,
      builder: (context, followLink){ 
      return OutlinedButton(

    onPressed:
        followLink,
      
      child: SizedBox(
        height: 100,
        child: Row( 
          children: [
            const Icon(Icons.video_call),
            const VerticalDivider(),
             Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${name.split(' ')[0]}'s meeting",
                    style: Theme.of(context).textTheme.subtitle2),
                const SizedBox(height: 5),
                Text(
                    'Time: ${meetingDetails['date']} ${meetingDetails['time']}',
                    style: Theme.of(context).textTheme.caption),
                Text('Duration: ${meetingDetails['duration']}',
                    style: Theme.of(context).textTheme.caption),
                const SizedBox(height: 5),
                const Text('Join video meeting')
              ],
            ),
          ],
        ),
      ),
      );
      }
    ),
  );
}

