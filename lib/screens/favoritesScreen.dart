import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/mealItem.dart';
import '../providers/meal.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double dw = MediaQuery.of(context).size.width;
    return Consumer<MealProvider>(
      builder: (ctx, _, child) {
        return (ctx.watch<MealProvider>().favoriteMeals.isEmpty)
            ? Center(
                child: Text("You have no favorites yet - start adding some!"))
            : GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  crossAxisSpacing: 0,
                  maxCrossAxisExtent: dw >= 500 ? 500 : dw,
                  mainAxisSpacing: 0,
                  childAspectRatio:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? dw / (dw * 0.75)
                          : dw / (dw * 0.8),
                ),
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
