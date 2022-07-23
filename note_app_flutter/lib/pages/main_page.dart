// ignore_for_file: prefer_const_constructors, unnecessary_this
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:note_app_flutter/pages/notes_page.dart';
import 'package:note_app_flutter/pages/welcome_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  void goToNotesPage(Widget childCurrent, BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
            alignment: Alignment.bottomCenter,
            curve: Curves.easeInOut,
            duration: Duration(milliseconds: 1000),
            reverseDuration: Duration(milliseconds: 1000),
            type: PageTransitionType.rightToLeftJoined,
            child: NotesPage(),
            childCurrent: childCurrent));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WelcomePage(
        onStartButtonPressed: () {
          goToNotesPage(this.widget, context);
        },
      ),
    );
  }
}
