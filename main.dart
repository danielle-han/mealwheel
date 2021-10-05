import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'MealWheel.dart';
import 'constants.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize(); //for displaying ads

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //dont show debug banner
      theme: ThemeData( //setting theme color of app
        primaryColor: Color(0xffebebeb),
        accentColor: kPrimaryRed,
      ),
      home: MealWheel(),
    );
  }
}
