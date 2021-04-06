import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/meal.dart';
import '../widgets/mealItem.dart';
import '../providers/meal.dart';

class CategoryMealScreen extends StatefulWidget {
  static const String routeName = "category_meals";
  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  Map<String, Object> routeArg;
  String categoryTitle;
  String categoryId;
  List<Meal> categoryMeal;

  @override
  void didChangeDependencies() {
    List<Meal> avilableMeal = context.watch<MealProvider>().avilableMeal;
    routeArg = ModalRoute.of(context).settings.arguments as Map<String, String>;
    categoryTitle = routeArg["title"];
    categoryId = routeArg["id"];
    categoryMeal = avilableMeal.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double dw = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: 0,
          maxCrossAxisExtent: dw >= 500 ? 500 : dw,
          mainAxisSpacing: 0,
          childAspectRatio:
              MediaQuery.of(context).orientation == Orientation.portrait
                  ? dw / (dw * 0.8)
                  : dw / (dw * 0.78),
        ),
        itemBuilder: (context, index) {
          return MealItem(
            id: categoryMeal[index].id,
            imageUrl: categoryMeal[index].imageUrl,
            title: categoryMeal[index].title,
            duration: categoryMeal[index].duration,
            complexity: categoryMeal[index].complexity,
            affordability: categoryMeal[index].affordability,
          );
        },
        itemCount: categoryMeal.length,
      ),
    );
  }
}
