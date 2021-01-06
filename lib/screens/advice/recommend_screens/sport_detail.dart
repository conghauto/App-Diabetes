import 'package:diabetesapp/models/sport.dart';
import 'package:diabetesapp/screens/advice/recommend_screens/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

// ignore: must_be_immutable
class SportDetail extends StatefulWidget {
  static String routeName = "/sport_detail_screen";
  SportModel sportModel ;
  SportDetail({this.sportModel});
  @override
  _SportDetailState createState() {
    // TODO: implement createState
    return new _SportDetailState();
  }
}
class _SportDetailState extends State<SportDetail> {
  FlutterTts voice = FlutterTts();
  bool isPlaying = false;
  @override
  void initState() {
    configureVoice();
  }

  @override
  void dispose() {
    super.dispose();
    voice.stop();
  }
  Future configureVoice() async {
    voice.setLanguage("vi-VN");
    voice.setPitch(1);
    voice.setStartHandler(() {
      setState(() {
        isPlaying = true;
      });
    });

    voice.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });

    voice.setErrorHandler((err) {
      setState(() {
        isPlaying = false;
      });
    });
  }
  Future _speak(String text) async {
    if (text != null && text.isNotEmpty) {
      var result = await voice.speak(text);
      if (result == 1)
        setState(() {
          isPlaying = true;
        });
    }
  }

  Future _stop() async {
    var result = await voice.stop();
    if (result == 1)
      setState(() {
        isPlaying = false;
      });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          tooltip: 'Đóng',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            iconSize: 30,
            autofocus: true,
            tooltip: "Nhấn để nghe",
            icon: (!isPlaying) ? Icon(Icons.play_arrow, color: Colors.black,) : Icon(Icons.stop, color: Colors.red,),
            onPressed: () async{
              String content = widget.sportModel.name;
              content += "Công dụng " + widget.sportModel.benefit;
              content += "Phương pháp " + widget.sportModel.technique + " g";
              if (widget.sportModel.note.length > 0) {
                content += "Chú thích " + widget.sportModel.note;
              }
              setState(() {
                (isPlaying) ? _stop() : _speak(content);
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariation1(widget.sportModel.name),
                  buildTextTitleVariation2('Công dụng', false),
                  buildTextSubTitleVariation1(widget.sportModel.benefit),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              height: 310,
              width: 310,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(
                  image: NetworkImage(widget.sportModel.image),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, bottom: 80),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTextTitleVariation2('Phương pháp', false),
                  buildTextSubTitleVariation1(widget.sportModel.technique),
                  (widget.sportModel.note != null && widget.sportModel.note != "null") ?
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16),
                      buildTextTitleVariation2('Chú thích', false),
                      buildTextSubTitleVariation1(widget.sportModel.note),
                    ],
                  ) :
                  SizedBox(height: 5,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}