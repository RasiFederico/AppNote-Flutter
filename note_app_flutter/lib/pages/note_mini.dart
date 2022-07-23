// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteMini extends StatefulWidget {
  const NoteMini({Key? key, required this.title, required this.content})
      : super(key: key);
  final String title;
  final String content;
  @override
  State<NoteMini> createState() => _NoteMiniState();
}

class _NoteMiniState extends State<NoteMini> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 150,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
          color: Color.fromARGB(54, 158, 158, 158),
          border: Border.all(color: Colors.transparent),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(children: [
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            color: Colors.amber.shade400,
            padding: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
            child: Text(widget.title,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.pacifico(color: Colors.black, fontSize: 15)),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            alignment: Alignment.topLeft,
            height: double.infinity,
            constraints: BoxConstraints.expand(),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
            child: Text(widget.content,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: GoogleFonts.aBeeZee(
                    color: Colors.black, fontSize: 15, height: 1)),
          ),
        )
      ]),
    );
  }
}
