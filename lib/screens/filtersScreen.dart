import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "../widgets/mainDrawer.dart";
import '../providers/meal.dart';
import '../providers/theme_provider.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = "/filters";

  Widget buildSwitchListTile(
      String filterTitle,
      String title,
      String subTitle,
      bool value,
      Function(String key, bool val) updateValue,
      BuildContext ctx) {
    return SwitchListTile.adaptive(
      inactiveTrackColor: ctx.watch<ThemeProvider>().tm == ThemeMode.light
          ? null
          : Colors.black,
      value: value,
      onChanged: (val) => updateValue(filterTitle, val),
      title: Text(title),
      subtitle: Text(subTitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MealProvider>(
      builder: (ctx, provider, child) => Scaffold(
        appBar: AppBar(
          title: Text("Your Filters"),
        ),
        drawer: MainDrawer(),
        body: Column(children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text("Adjust your mealselection",
                style: Theme.of(context).textTheme.headline6),
          ),
          Expanded(
            child: ListView(
              children: [
                buildSwitchListTile(
                  "gluten",
                  "Gluten-free",
                  "Only include gluten-free meals.",
                  ctx.watch<MealProvider>().filters["gluten"],
                  ctx.read<MealProvider>().setFilter,
                  ctx,
                ),
                buildSwitchListTile(
                  "lactose",
                  "Lactose-free",
                  "Only include Lactose-free meals.",
                  ctx.watch<MealProvider>().filters["lactose"],
                  ctx.read<MealProvider>().setFilter,
                  ctx,
                ),
                buildSwitchListTile(
                  "vegan",
                  "Vegan",
                  "Only include Vegan meals.",
                  ctx.watch<MealProvider>().filters["vegan"],
                  ctx.read<MealProvider>().setFilter,
                  ctx,
                ),
                buildSwitchListTile(
                  "vegetarian",
                  "Vegetarian",
                  "Only include Vegetarian meals.",
                  ctx.watch<MealProvider>().filters["vegetarian"],
                  ctx.read<MealProvider>().setFilter,
                  ctx,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
