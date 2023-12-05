import 'package:flutter/material.dart';
import 'package:school_project/widgets/home/home_button.dart';
import 'package:school_project/widgets/home/home_button_pic.dart';
import 'package:school_project/widgets/home/home_button_pic_two.dart';
import 'package:school_project/widgets/meditate/music_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.only(left: 18.0),
                  child: Text('Morning', style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  ),
                ),
                const SizedBox(height: 10),
                HomeButtonPicture(onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const Music(text: 'Execise', url: 'https://scummbar.com/mi2/MI1-CD/01%20-%20Opening%20Themes%20-%20Introduction.mp3',))));
                }, image: 'assets/stress.png',
                 text: 'Execise', subText: '4 min meditation'),
                HomeButton(onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const Music(text: 'Dealing with rage', url: 'https://scummbar.com/mi2/MI1-CD/01%20-%20Opening%20Themes%20-%20Introduction.mp3',))));
                },
                 text: 'Dealing with rage', subText: '2 min article'),

                const SizedBox(height: 10),

                  const Padding(
                  padding: EdgeInsets.only(left: 18.0),
                  child: Text('Day', style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  ),
                ),
                const SizedBox(height: 10),
                HomeButtonPictureTwo(onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const Music(text: 'Anxiety', url: 'https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Fnature-99499.mp3?alt=media&token=d96b359e-b9d4-4bb9-933c-849b4b0b00aa',))));
                }, image: 'assets/happy.png',
                 text: 'Anxiety', subText: '4 min meditation'),
                HomeButton(onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const Music(text: 'Take  a break', url: 'https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Fautumn-sky-meditation-7618.mp3?alt=media&token=7d1c1253-3bc6-43d7-90f6-055919e87fc7',))));
                },
                 text: 'Take a break', subText: 'Relaxing sounds'),
                 
                const SizedBox(height: 10),

                  const Padding(
                  padding: EdgeInsets.only(left: 18.0),
                  child: Text('Evening', style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  ),
                ),
                const SizedBox(height: 10),
                HomeButtonPicture(onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const Music(text: 'Bedtime story', url: 'https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Falways-with-me-always-with-you-piano-long-21257.mp3?alt=media&token=47210a9a-75a1-4a1d-88a0-8e58d5a446cc',))));
                }, image: 'assets/envy.png',
                 text: 'Bedtime story', subText: 'Listen and relax'),
                HomeButton(onPressed: () {
                   Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => const Music(text: 'Relax sounds', url: 'https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Fanxious-99498.mp3?alt=media&token=7ff844d3-2e69-4ccf-85a1-ccfd012c1f7e',))));
                },
                 text: 'Relax sounds', subText: '7 min meditation'),
              ],
            ),
          )
        ),
      )
    );
  }
}