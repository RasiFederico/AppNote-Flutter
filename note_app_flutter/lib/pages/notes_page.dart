// ignore_for_file: prefer_const_constructors, unnecessary_this
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_flutter/pages/editor_page.dart';
import 'note_mini.dart';
import 'package:page_transition/page_transition.dart';
import 'package:hive_flutter/hive_flutter.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final _notesBox = Hive.box('notes');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: Row(
        children: [
          Spacer(),
          Opacity(
            opacity: 0.1,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                'Swipe to change page',
                style: GoogleFonts.pacifico(
                    color: Colors.black,
                    fontSize: 20,
                    shadows: [
                      Shadow(color: Colors.amber, offset: Offset(2, 2))
                    ]),
              ),
            ),
          ),
          Spacer()
        ],
      ),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Your notes',
          style: GoogleFonts.pacifico(
              color: Colors.black,
              fontSize: 30,
              shadows: [Shadow(color: Colors.amber, offset: Offset(2, 2))]),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx < 1500.0) {
            Navigator.push(
                context,
                PageTransition(
                    alignment: Alignment.bottomCenter,
                    curve: Curves.easeInOut,
                    duration: Duration(milliseconds: 600),
                    reverseDuration: Duration(milliseconds: 600),
                    type: PageTransitionType.rightToLeftJoined,
                    child: EditorPage(noteKey: 0, content: '', title: ''),
                    childCurrent: this.widget));
          }
        },
        child: Padding(
          padding: EdgeInsets.all(10),
          child: GridView.count(
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          alignment: Alignment.bottomCenter,
                          curve: Curves.easeInOut,
                          duration: Duration(milliseconds: 600),
                          reverseDuration: Duration(milliseconds: 600),
                          type: PageTransitionType.rightToLeftJoined,
                          child: EditorPage(noteKey: 0, content: '', title: ''),
                          childCurrent: this.widget));
                },
                child: Material(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  elevation: 2,
                  shadowColor: Colors.amber,
                  child: Container(
                    width: 10,
                    height: 150,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(54, 158, 158, 158),
                        border: Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Icon(Icons.add, color: Colors.amber, shadows: [
                      Shadow(color: Colors.black, offset: Offset(1, 1))
                    ]),
                  ),
                ),
              ),
              for (int key in _notesBox.keys)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            alignment: Alignment.bottomCenter,
                            curve: Curves.easeInOut,
                            duration: Duration(milliseconds: 600),
                            reverseDuration: Duration(milliseconds: 600),
                            type: PageTransitionType.rightToLeftJoined,
                            child: EditorPage(
                                noteKey: key,
                                content: _notesBox.get(key)[1],
                                title: _notesBox.get(key)[0]),
                            childCurrent: this.widget));
                  },
                  child: Material(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    elevation: 2,
                    shadowColor: Colors.amberAccent,
                    child: NoteMini(
                        title: _notesBox.get(key)[0],
                        content: _notesBox.get(key)[1]),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
