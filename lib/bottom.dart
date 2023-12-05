// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, camel_case_types, prefer_final_fields

import 'package:school_project/screens/dairy.dart';
import 'package:school_project/screens/home.dart';
import 'package:school_project/screens/meditate.dart';
import 'package:school_project/screens/profile.dart';
import 'package:school_project/screens/session.dart';
import 'package:flutter/material.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);
   static String id = 'bottom';
   
  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}


class _BottomNavigationPageState extends State<BottomNavigationPage> {
   final List<Map<String, dynamic>> _pageDetails = [
    {'pageName': const HomePage(), 'title': 'Home'},
    {'pageName': const Session(), 'title': 'Session'},
    {'pageName': const Meditate(), 'title': 'Meditation'},
    {'pageName': const MyDairy(), 'title': 'MyDairy'},
    {'pageName': const Profile(), 'title': 'Profile'},
  ];

  var _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(_pageDetails[_selectedPageIndex]['title']),
       ),
      body: _pageDetails[_selectedPageIndex]['pageName'],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff0e157c),
        selectedItemColor: Colors.white,
        iconSize: 26.0,
        selectedFontSize: 16.0,
        unselectedFontSize: 14.0,
        unselectedItemColor:  const Color.fromARGB(255, 86, 90, 172),
        currentIndex: _selectedPageIndex,
        onTap: (index){
          setState(() {
            _selectedPageIndex = index;
          });
          
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.video_call),
            label: 'Session'
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.sentiment_satisfied_alt),
            label: 'Meditate'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'My Dairy'
          ),
           BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile'
          ),
        ]
        ),
    );
  }
}



