import 'package:demo/users/student/rating_feedback.dart';
import 'package:demo/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({Key? key}) : super(key: key);

  @override
  _splash_screenState createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 14,
      navigateAfterSeconds: new RatingScreen(),
      title: new Text(
        'Easy Bus Portal',
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 20.0, letterSpacing: 2),
      ),
      image: new Image.asset('assets/gifs/Bus driver.gif'),
      photoSize: 200,
      backgroundColor: Colors.white,
      loaderColor: Colors.purple,
    );
  }
}
