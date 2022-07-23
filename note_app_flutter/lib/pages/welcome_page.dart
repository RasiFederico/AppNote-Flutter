// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key, required this.onStartButtonPressed})
      : super(key: key);
  final VoidCallback onStartButtonPressed;

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with TickerProviderStateMixin {
  late VoidCallback onStartButtonPressed;
  late AnimationController _controllerA;
  late Animation<double> _animationA;
  late AnimationController _controllerB;
  late Animation<double> _animationB;
  late bool _visible = false;

  @override
  void initState() {
    super.initState();
    _controllerA =
        AnimationController(duration: Duration(seconds: 4), vsync: this)
          ..forward();
    _animationA = Tween<double>(begin: -500, end: 0)
        .animate(CurvedAnimation(parent: _controllerA, curve: Curves.easeOut));

    _controllerB =
        AnimationController(duration: Duration(seconds: 4), vsync: this)
          ..forward()
          ..addListener(() {
            if (_controllerB.isCompleted) {
              setState(() {
                _visible = true;
              });
            }
          });
    _animationB = Tween<double>(begin: 500, end: 0)
        .animate(CurvedAnimation(parent: _controllerB, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controllerA.dispose();
    _controllerB.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: AnimatedBuilder(
            animation: _animationA,
            builder: ((context, child) => Transform.translate(
                  offset: Offset(_animationA.value, 0),
                  child: Text('by Federico Rasi',
                      style: GoogleFonts.pacifico(
                          fontSize: 10, color: Colors.grey, height: 0.1)),
                )),
          ),
        ),
        Center(
          child: AnimatedBuilder(
            animation: _animationA,
            builder: ((context, child) => Transform.translate(
                  offset: Offset(_animationA.value, 0),
                  child: Text('welcome to',
                      style: GoogleFonts.pacifico(fontSize: 30)),
                )),
          ),
        ),
        Center(
          child: AnimatedBuilder(
            animation: _animationB,
            builder: ((context, child) => Transform.translate(
                  offset: Offset(_animationB.value, 0),
                  child: Text('AppNote',
                      style: GoogleFonts.satisfy(fontSize: 60, shadows: [
                        Shadow(offset: Offset(2, 2), color: Colors.amber)
                      ])),
                )),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        AnimatedOpacity(
          opacity: _visible ? 1.0 : 0.0,
          duration: Duration(seconds: 1),
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber),
              ),
              onPressed: () {
                widget.onStartButtonPressed();
              },
              child: Text('Start taking Notes',
                  style: GoogleFonts.courgette(fontSize: 20, shadows: [
                    Shadow(offset: Offset(1, 1), color: Colors.black)
                  ]))),
        ),
      ],
    ));
  }
}
