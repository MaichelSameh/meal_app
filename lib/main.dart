import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/filtersScreen.dart';
import 'screens/mealDetailScreen.dart';
import 'screens/tabsScreen.dart';
import 'screens/categoryMealScreen.dart';
import 'screens/theme_screen.dart';
import 'screens/on_boarding_screen.dart';

import 'providers/meal.dart';
import 'providers/theme_provider.dart';
import 'providers/language_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences pref = await SharedPreferences.getInstance();

  Widget widget =
      pref.getBool("watched") ?? false ? TabsScreen() : OnBoardingScreen();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MealProvider>(create: (_) => MealProvider()),
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider(),
        ),
      ],
      builder: (ctx, _) => MyApp(mainScreen: widget),
    ),
  );
}

class MyApp extends StatelessWidget {
  final Widget mainScreen;
  MyApp({this.mainScreen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: context.watch<ThemeProvider>().tm,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: "Raleway",
        buttonColor: Colors.white70,
        cardColor: Colors.white,
        shadowColor: Colors.white60,
        unselectedWidgetColor: Colors.black,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: "RobotoCondensed",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 50, 50, 1),
              ),
            ),
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(14, 22, 33, 1),
        fontFamily: "Raleway",
        buttonColor: Colors.white70,
        cardColor: Color.fromRGBO(35, 34, 39, 1),
        shadowColor: Colors.white60,
        unselectedWidgetColor: Colors.white70,
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: "RobotoCondensed",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white60),
              bodyText1: TextStyle(
                color: Colors.white70,
              ),
              bodyText2: TextStyle(color: Colors.white54, fontSize: 10),
            ),
      ),
      home: mainScreen,
      title: "Meal App",
      routes: {
        OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
        TabsScreen.routeName: (context) => TabsScreen(),
        CategoryMealScreen.routeName: (context) => CategoryMealScreen(),
        MealDetailScreen.routeName: (context) => MealDetailScreen(),
        FiltersScreen.routeName: (context) => FiltersScreen(),
        ThemeScreen.routeName: (context) => ThemeScreen(),
      },
    );
  }
}
