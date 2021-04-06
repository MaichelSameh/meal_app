import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/meal.dart';
import '../widgets/categoryItem.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          crossAxisSpacing: 20,
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 20,
          childAspectRatio: 3 / 2,
        ),
        padding: EdgeInsets.all(25),
        children:
            context.watch<MealProvider>().avilableCategories.map((catData) {
          return CategoryItem(catData.id, catData.title, catData.color);
        }).toList(),
      ),
    );
  }
}
