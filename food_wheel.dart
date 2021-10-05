import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'constants.dart';

class WheelFunctions {
  String newItem;
  int selected = 0;
  FortuneWheel foodWheel;
  List<FortuneItem> foodItems = [];
  int index = 0;

  Color itemColor() { //returning color of wheel item
    if (index >= 0 && index < 6) {
      index++;
    } else if (index == 6) {
      index = 1;
    }
    print(index);
    return kItemColors[index];
  }

  List<FortuneItem> newFoodItem() {
    FortuneItem item = FortuneItem( //List item
      child: Text(
        newItem,
        style: TextStyle(fontSize: 20.0, color: Colors.black),
      ),
      style: FortuneItemStyle( //List item style
        borderColor: Colors.white,
        borderWidth: 1.0,
        textAlign: TextAlign.center,
        color: itemColor(),
      ),
    );
    foodItems.add(item); //add list item to list foodItems
    return foodItems;
  }

  FortuneWheel updateFoodWheel() {
    if (foodItems.length <= 1) {
      //safety - doesn't show; added just in case.
      foodWheel = FortuneWheel(
        physics: NoPanPhysics(),
        selected: selected,
        items: [
          FortuneItem(
            child: Text('Add at least 2 choices!'),
          ),
          FortuneItem(
            child: Text('Example: McDonald\'s'),
          ),
        ],
      );
      return foodWheel;
    } else {
      foodWheel = FortuneWheel(
          physics: NoPanPhysics(), selected: selected, items: foodItems);
      return foodWheel;
    }
  }
}
