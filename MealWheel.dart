import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'constants.dart';
import 'food_wheel.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'adbanner.dart';

class MealWheel extends StatefulWidget {
  @override
  _MealWheelState createState() => _MealWheelState();
}

class _MealWheelState extends State<MealWheel> {
  @override
  void initState() {
    super.initState();
    myBanner.load();
  }

  WheelFunctions wheelFunctions = WheelFunctions();
  String errorText;
  final fieldText = TextEditingController();

  void buttonFunction() {
    wheelFunctions.newItem = wheelFunctions.newItem == null ||
            wheelFunctions.newItem.replaceAll(' ', '') == ''
        ? ''
        : wheelFunctions.newItem.trim();
    try {
      if (wheelFunctions.newItem == '') {
        errorText = 'Enter a choice that is not empty';
      } else {
        wheelFunctions.newFoodItem();
        fieldText.clear();
        wheelFunctions.updateFoodWheel();
        wheelFunctions.newItem = null;
        errorText = null;
      }
    } catch (e) {
      print(e);
    }
  }

  //TODO: how can the users delete a choice if they make a mistake?
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (myBanner == null)
              SizedBox(height: 0)
            else
              Container(
                alignment: Alignment.center,
                child: AdWidget(ad: myBanner),
                height: MediaQuery.of(context).size.height * 0.08, //
                width: MediaQuery.of(context).size.width, //
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Meal',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.1,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Pacifico',
                    color: kPrimaryRed,
                  ),
                ),
                Text(
                  ' Wheel',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.1,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Pacifico',
                    color: kPrimaryYellow,
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      onChanged: (newText) {
                        wheelFunctions.newItem = newText;
                      },
                      onSubmitted: (item) {
                        setState(() {
                          buttonFunction();
                        });
                      },
                      onEditingComplete: () {},
                      textInputAction: TextInputAction.next,
                      cursorColor: kBlack,
                      style: TextStyle(
                        color: kBlack,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter a food choice',
                        fillColor: Colors.white,
                        filled: true,
                        errorText: errorText,
                        errorStyle: TextStyle(
                          color: kPrimaryRed,
                        ),
                        contentPadding: EdgeInsets.only(left: 10.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                      controller: fieldText,
                    ),
                  ),
                  // ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                        kPrimaryYellow,
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 14.0, horizontal: 8.0),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        buttonFunction();
                      });
                    },
                    child: Text(
                      'Add',
                      style: TextStyle(
                        color: kBlack,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                setState(() {
                  FocusScope.of(context).unfocus();
                  wheelFunctions.selected =
                      Random().nextInt(wheelFunctions.foodItems.length);
                  wheelFunctions.updateFoodWheel();
                });
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: wheelFunctions.foodItems.length <= 1
                    ? Text(
                        'Input at least 2 choices',
                        style: TextStyle(
                          color: kPrimaryRed,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : wheelFunctions.foodWheel,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  kPrimaryRed,
                ),
                padding: MaterialStateProperty.all(
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  wheelFunctions.foodItems.clear();
                  wheelFunctions.selected = 0;
                  wheelFunctions.updateFoodWheel();
                  wheelFunctions.newItem = null;
                  fieldText.clear();
                });
              },
              child: Text(
                'Reset',
                style: TextStyle(
                  color: kWhite,
                  fontSize: 15.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    myBanner.dispose();
  }
}
