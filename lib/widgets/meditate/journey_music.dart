
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Journey extends StatefulWidget  {
  final String text;
  
  
  const Journey({Key? key, required this.text}) : super(key: key);

  @override
  State<Journey> createState() => _JourneyState();
}

class _JourneyState extends State<Journey> {



  final player = AudioPlayer();
  bool isPlaying = false;
  String url = '';
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

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

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  String? time(Duration duration){
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if(duration.inHours > 0) hours,
      minutes,
      seconds
    ].join(":");
  }

  //for network audio
  Future setAudio() async {
    player.setReleaseMode(ReleaseMode.loop);
    // String url = "https://scummbar.com/mi2/MI1-CD/01%20-%20Opening%20Themes%20-%20Introduction.mp3";
    await player.setSourceUrl(url);
    
  }

  Widget chip(String label, String newUrl) {
    // Customised Chip widget
    return GestureDetector(
        onTap: () {
          url = newUrl;
          setAudio();
          
          
        },
        child: Chip(label: Center(child: Text(label, style: const TextStyle(color: Colors.white)))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
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
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Image of the album or music
              Image.asset("assets/break.png",width: double.infinity,height: 300,fit: BoxFit.cover,),
              const SizedBox(height: 20,),
               Text(widget.text,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
              const SizedBox(height: 8,),
              SizedBox(
                  height: 25,
                  width: 1700,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              chip('Day 1', 'https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2FAngelica-Singh-Anxiety-Meditation.mp3?alt=media&token=9935ae8b-4fa6-4396-85c0-e9ef56973d82'),
                              const SizedBox(height: 10,),
                              chip('Day 2', 'https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Falways-with-me-always-with-you-piano-long-21257.mp3?alt=media&token=47210a9a-75a1-4a1d-88a0-8e58d5a446cc'),
                              const SizedBox(height: 5,),
                              chip('Day 3', 'https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2FAngelica-Singh-Anxiety-Meditation.mp3?alt=media&token=9935ae8b-4fa6-4396-85c0-e9ef56973d82'),
                              const SizedBox(height: 5,),
                              chip('Day 4', 'https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Fanxious-99498.mp3?alt=media&token=7ff844d3-2e69-4ccf-85a1-ccfd012c1f7e'),
                              chip('Day 5', 'https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Fautumn-sky-meditation-7618.mp3?alt=media&token=7d1c1253-3bc6-43d7-90f6-055919e87fc7'),
                              chip('Day 6', 'https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Fsia_salted_wound_from_the_fifty_shades_of_grey_soundtrack_audio_mp3_72776.mp3?alt=media&token=f3995059-3208-4dae-8996-bda86c7a664c'),
                              chip('Day 7', 'https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Ftension-113661.mp3?alt=media&token=2584e28a-cc00-41a0-8c31-09f5caa7f362'),
                              chip('Day 8', 'https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Fsia_salted_wound_from_the_fifty_shades_of_grey_soundtrack_audio_mp3_72776.mp3?alt=media&token=f3995059-3208-4dae-8996-bda86c7a664c'),
                              chip('Day 9', 'https://firebasestorage.googleapis.com/v0/b/my-being-you.appspot.com/o/music%2Ftense-cinematic-1-22135.mp3?alt=media&token=f0e8397c-30cc-4d2c-86bc-5f6e495c208a'),
                            ],
                          ),
                        ),
                      ]
                      ),
                  ),
                ),
              const SizedBox(height: 5,),
              
              IconButton(
                  onPressed: () async {
                    if(isPlaying){
                      await player.pause();
                    } else {
                      await player.resume();
                      
                    }
                  },
                icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                iconSize: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}


  