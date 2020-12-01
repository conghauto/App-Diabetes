import 'package:diabetesapp/models/sport.dart';
import 'package:diabetesapp/screens/advice/recommend_screens/shared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
          tooltip: 'Đóng',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.favorite_border,
              color: Colors.black,
            ),
          ),
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