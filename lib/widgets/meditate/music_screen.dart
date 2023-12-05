
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class Music extends StatefulWidget  {
  final String text;
  final String url;
  
  const Music({Key? key, required this.text, required this.url}) : super(key: key);

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> {



  final player = AudioPlayer();
  bool isPlaying = false;
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
    await player.setSourceUrl(widget.url);
    
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
               Text(widget.text,style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),),
              const SizedBox(height: 8,),
              Slider(
                min: 0,
                inactiveColor: Colors.white,
                    activeColor: Colors.white,
                  max: duration.inSeconds.toDouble(),
                  value: position.inSeconds.toDouble(),
                  onChanged: (value) async {
                    final position = Duration(seconds: value.toInt());
                    await player.seek(position);

                    // await player.resume();
                    
                  },
              ),
              const SizedBox(height: 5,),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(time(position) ?? "", style: const TextStyle(color: Colors.white)),
                  Text(time(duration - position) ?? "",  style: const TextStyle(color: Colors.white)),
                ],
              ),),
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