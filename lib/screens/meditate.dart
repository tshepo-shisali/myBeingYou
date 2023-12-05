import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:school_project/widgets/meditate/journey_button.dart';
import 'package:school_project/widgets/meditate/journey_music.dart';
import 'package:school_project/widgets/meditate/music_listview.dart';
import 'package:school_project/widgets/meditate/player.dart';

class Meditate extends StatefulWidget {
  const Meditate({Key? key}) : super(key: key);

  @override
  State<Meditate> createState() => _MeditateState();
}

class _MeditateState extends State<Meditate> {
   final player = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  String url = '';


  List musicList = [
    {
      'title': "Always-with-me-always-with-you-piano-long ",
      'singer': "Get into meditative state",
      'cover': "anxiety.png",
      'url': "https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Falways-with-me-always-with-you-piano-long-21257.mp3?alt=media&token=47210a9a-75a1-4a1d-88a0-8e58d5a446cc",

    },
    {
      'title': "Nature",
      'singer': "Fall asleep fast",
      'cover': "break.png",
      'url': "https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Fnature-99499.mp3?alt=media&token=d96b359e-b9d4-4bb9-933c-849b4b0b00aa",

    },
     {
      'title': "Anxious",
      'singer': "Soft and Light track",
      'cover': "envy.png",
      'url': "https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Fanxious-99498.mp3?alt=media&token=7ff844d3-2e69-4ccf-85a1-ccfd012c1f7e",

    },
     {
      'title': "Autumn-sky-meditation",
      'singer': "Anxiety free sound",
      'cover': "relax.png",
      'url': "https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Fautumn-sky-meditation-7618.mp3?alt=media&token=7d1c1253-3bc6-43d7-90f6-055919e87fc7",

    },
    {
      'title': "Sia",
      'singer': "Music with soft and binaural pads",
      'cover': "happy.png",
      'url': "https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Fsia_salted_wound_from_the_fifty_shades_of_grey_soundtrack_audio_mp3_72776.mp3?alt=media&token=f3995059-3208-4dae-8996-bda86c7a664c",

    },
    {
      'title': "Tension",
      'singer': "Beat your insomnia now",
      'cover': "stress.png",
      'url': "https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Ftension-113661.mp3?alt=media&token=2584e28a-cc00-41a0-8c31-09f5caa7f362",

    },
    {
      'title': "Alted_wound",
      'singer': "Sia",
      'cover': "worry.png",
      'url': "https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Fsia_salted_wound_from_the_fifty_shades_of_grey_soundtrack_audio_mp3_72776.mp3?alt=media&token=f3995059-3208-4dae-8996-bda86c7a664c",

    },
  ];

 Future setAudio() async {
    player.setReleaseMode(ReleaseMode.loop);
    // String url = "https://scummbar.com/mi2/MI1-CD/01%20-%20Opening%20Themes%20-%20Introduction.mp3";
    await player.setSourceUrl(url);
    
  }
 
  @override
  void initState() {

    setAudio();

     
    super.initState();

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    //listen to audio duration
    player.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    //listen to audio position
    player.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    

  }
  String currentTitle = '';
  String currentCover = '';

  @override
  Widget build(BuildContext context) {
    Widget current = currentTitle.isNotEmpty
    ? BottomPlayer(title: currentTitle, cover: currentCover, isPlaying: isPlaying, onPressed: () async {
      if(isPlaying){
                      await player.pause();
                    } else {
                      await player.resume();
                    }
     }, duration: duration.inSeconds.toDouble(), onChanged: (position)async { 
      
       final position1 = Duration(seconds: position.toInt());
                    await player.seek(position1);
      }, position: position.inSeconds.toDouble(),)
    : Container();
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.vertical -
                    40,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Journey', style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color:Color(0xffcdd0f9),
                  )),
                  SizedBox(
                    height: 200,
                    width: 1700,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                 JourneyButton(onPressed: () {
                                   Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const Journey(text: 'Daily dose of motivation'))));
                                 }, image: 'assets/happy.png',
                                text: 'Todays Affirmation', subText: 'Daily dose of motivation'),
                                  const SizedBox(height: 10,),
                                  JourneyButton(onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const Journey(text: 'The sweet scent of nature'))));
                                  }, image: 'assets/anxiety.png',
                                   text: 'Anxiety', subText: 'The sweet scent of nature'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                 JourneyButton(onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const Journey(text: 'Raise your vibration'))));
                                 }, image: 'assets/stress.png',
                                text: 'Stress', subText: 'Raise your vibration'),
                                  const SizedBox(height: 10,),
                                  JourneyButton(onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => const Journey(text: 'Ethereal atmosphere'))));
                                  },image: 'assets/happy.png',
                                   text: 'Fear', subText: 'Ethereal atmosphere'),
                              ],
                            ),
                          ),
                        ]
                        ),
                    ),
                  ),
                   Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: SizedBox(
                      height: 200,
                       child: ListView.builder(
                                 shrinkWrap: true,
                                 itemCount: musicList.length,
                                 itemBuilder: (context, index) => customListTile(
                                   onPressed: () async{
                                     
                                     setState(() {
                                       currentTitle = musicList[index]['title'];
                                    
                                   currentCover = musicList[index]['cover'];
                                   url = musicList[index]['url'];
                                     });
                                     
                                     setAudio();
          
                                   },
                                   title: musicList[index]['title'],
                                    singer: musicList[index]['singer'],
                                   cover: musicList[index]['cover'], 
                                   )),
                     ),
                   ),
                 current,
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}