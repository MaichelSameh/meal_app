import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/filtersScreen.dart';
import './screens/mealDetailScreen.dart';
import './screens/tabsScreen.dart';
import './screens/categoryMealScreen.dart';
import 'providers/meal.dart';

void main() {
  runApp(ChangeNotifierProvider<MealProvider>(
    create: (ctx) => MealProvider(),
    builder: (ctx, _) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          textTheme: ThemeData.light().textTheme.copyWith(
                // ignore: deprecated_member_use
                title: TextStyle(
                    fontFamily: "RobotoCondensed",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
        title: "Meal App",
        routes: {
          "/": (context) => TabsScreen(),
          CategoryMealScreen.routeName: (context) => CategoryMealScreen(),
          MealDetailScreen.routeName: (context) => MealDetailScreen(),
          FiltersScreen.routeName: (context) => FiltersScreen(),
        });
  }
}
