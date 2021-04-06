import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dummy_data.dart';
import '../providers/meal.dart';

class MealDetailScreen extends StatefulWidget {
  static const routeName = "meal_screen";

  @override
  _MealDetailScreenState createState() => _MealDetailScreenState();
}

class _MealDetailScreenState extends State<MealDetailScreen> {
  Color accentColor;

  bool useWhiteForeground(Color backgroundColor) {
    return 1.05 / (backgroundColor.computeLuminance() + 0.5) > 4.5;
  }

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: Theme.of(context).textTheme.headline6),
    );
  }

  Widget buildContainer(Widget child) {
    return Builder(
      builder: (ctx) {
        var md = MediaQuery.of(ctx);
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(10),
          height: md.orientation == Orientation.portrait
              ? md.size.height * 0.25
              : (md.size.width * 0.5),
          width: md.orientation == Orientation.portrait
              ? md.size.width
              : (md.size.width * 0.5 - 30),
          child: child,
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    accentColor = Theme.of(context).accentColor;
  }

  @override
  Widget build(BuildContext context) {
    final String mealId = ModalRoute.of(context).settings.arguments as String;
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) {
      return (meal.id == mealId);
    });
    var liIngredient = ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Card(
          color: accentColor,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              selectedMeal.ingredients[index],
              style: TextStyle(
                color: useWhiteForeground(accentColor)
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
        );
      },
      itemCount: selectedMeal.ingredients.length,
    );
    var liSteps = ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text(
                selectedMeal.steps[index],
                style: TextStyle(
                  color: useWhiteForeground(accentColor)
                      ? Colors.white
                      : Colors.black,
                ),
              ),
              leading: CircleAvatar(child: Text("# ${index + 1}")),
            ),
            Divider(),
          ],
        );
      },
      itemCount: selectedMeal.steps.length,
    );
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(selectedMeal.title),
              background: Hero(
                tag: selectedMeal.id,
                child: InteractiveViewer(
                  child: FadeInImage(
                    image: NetworkImage(selectedMeal.imageUrl),
                    placeholder: AssetImage("assets/images/a2.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            MediaQuery.of(context).orientation == Orientation.portrait
                ? Column(
                    children: [
                      buildSectionTitle(context, "Ingredients"),
                      buildContainer(
                        liIngredient,
                      ),
                      buildSectionTitle(context, "Steps"),
                      buildContainer(
                        liSteps,
                      )
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          buildSectionTitle(context, "Ingredients"),
                          buildContainer(
                            liIngredient,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          buildSectionTitle(context, "Steps"),
                          buildContainer(
                            liSteps,
                          )
                        ],
                      )
                    ],
                  ),
          ]))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {
          context.read<MealProvider>().toggleFavorite(mealId);
        }),
        child: Icon(context.read<MealProvider>().isMealFavorite(mealId)
            ? Icons.star
            : Icons.star_outline),
      ),
    );
  }
}
