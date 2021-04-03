import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/mealItem.dart';
import '../providers/meal.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MealProvider>(
      builder: (ctx, _, child) {
        return (ctx.watch<MealProvider>().favoriteMeals.isEmpty)
            ? Center(
                child: Text("You have no favorites yet - start adding some!"))
            : ListView.builder(
                itemCount: ctx.watch<MealProvider>().favoriteMeals.length,
                itemBuilder: (context, index) {
                  return MealItem(
                    id: ctx.watch<MealProvider>().favoriteMeals[index].id,
                    imageUrl:
                        ctx.watch<MealProvider>().favoriteMeals[index].imageUrl,
                    title: ctx.watch<MealProvider>().favoriteMeals[index].title,
                    duration:
                        ctx.watch<MealProvider>().favoriteMeals[index].duration,
                    complexity: ctx
                        .watch<MealProvider>()
                        .favoriteMeals[index]
                        .complexity,
                    affordability: ctx
                        .watch<MealProvider>()
                        .favoriteMeals[index]
                        .affordability,
                  );
                },
              );
      },
    );
  }
}
