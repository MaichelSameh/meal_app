import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dummy_data.dart';
import '../models/meal.dart';

class MealProvider with ChangeNotifier {
  MealProvider() {
    print("constructor");
    getDataFromSahred();
  }

  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegan": false,
    "vegetarian": false,
  };

  Map<String, bool> get filters => _filters;

  List<Meal> _avilableMeal = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  List<Meal> get favoriteMeals => _favoriteMeals;
  List<Meal> get avilableMeal => _avilableMeal;

  void getDataFromSahred() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getKeys().isNotEmpty) {
      _filters["vegan"] = pref.getBool("vegan");
      _filters["gluten"] = pref.getBool("gluten");
      _filters["lactose"] = pref.getBool("lactose");
      _filters["vegetarian"] = pref.getBool("vegetarian");
      notifyListeners();
    }
  }

  void setFilter(String key, bool value) {
    _filters.update(key, (val) => value);
    _updateFilters(value);
    notifyListeners();
  }

  void _updateFilters(bool remove) async {
    _avilableMeal = DUMMY_MEALS.where((element) {
      if (_filters["gluten"] && !element.isGlutenFree) {
        return false;
      } else if (_filters["lactose"] && !element.isLactoseFree) {
        return false;
      } else if (_filters["vegan"] && !element.isVegan) {
        return false;
      } else if (_filters["vegetarian"] && !element.isVegetarian) {
        return false;
      } else
        return true;
    }).toList();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool("vegan", _filters["vegan"]);
    pref.setBool("gluten", _filters["gluten"]);
    pref.setBool("lactose", _filters["lactose"]);
    pref.setBool("vegetarian", _filters["vegetarian"]);
  }

  void toggleFavorite(String mealId) {
    final int existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      _favoriteMeals.removeAt(existingIndex);
    } else {
      _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
    }
    notifyListeners();
  }

  bool isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }
}
