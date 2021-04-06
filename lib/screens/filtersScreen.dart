import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import "../widgets/mainDrawer.dart";
import '../providers/meal.dart';
import '../providers/theme_provider.dart';

class FiltersScreen extends StatelessWidget {
  static const routeName = "/filters";

  final bool fromOnBoarding;

  FiltersScreen({this.fromOnBoarding = false});

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
      title: Text(title, style: Theme.of(ctx).textTheme.bodyText1),
      subtitle: Text(subTitle, style: Theme.of(ctx).textTheme.bodyText2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MealProvider>(
      builder: (ctx, provider, child) => Scaffold(
        drawer: fromOnBoarding ? null : MainDrawer(),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              title: fromOnBoarding ? null : Text("Your Filters"),
              backgroundColor: fromOnBoarding
                  ? Theme.of(context).canvasColor
                  : Theme.of(context).primaryColor,
              elevation: fromOnBoarding ? 0 : 5,
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Adjust your mealselection",
                      style: Theme.of(context).textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  ),
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
                  SizedBox(height: fromOnBoarding ? 80 : 0),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
