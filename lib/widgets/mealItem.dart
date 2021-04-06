import 'package:flutter/material.dart';

import '../screens/mealDetailScreen.dart';
import '../models/meal.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  MealItem({
    @required this.id,
    @required this.imageUrl,
    @required this.title,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
  });

  String get complexityText {
    switch (complexity) {
      case Complexity.Challenging:
        return "Challenging";
      case Complexity.Hard:
        return "Hard";
      case Complexity.Simple:
        return "Simple";
      default:
        return "";
    }
  }

  String get affordabilityText {
    switch (affordability) {
      case Affordability.Affordable:
        return "Affordable";
      case Affordability.Luxurious:
        return "Luxurious";
      case Affordability.Pricey:
        return "Pricey";
      default:
        return "";
    }
  }

  void selectMeal(BuildContext ctx) {
    Navigator.of(ctx).pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectMeal(context),
      child: LayoutBuilder(
        builder: (ctx, constrain) => Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Container(
                height: constrain.maxHeight * 4 / 5 - 10,
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      child: Hero(
                        tag: id,
                        child: InteractiveViewer(
                          child: FadeInImage(
                            width: double.infinity,
                            image: NetworkImage(imageUrl),
                            placeholder: AssetImage("assets/images/a2.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 10,
                      child: Container(
                        width: 300,
                        color: Colors.black54,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        child: Text(
                          title,
                          style: TextStyle(fontSize: 26, color: Colors.white),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: (constrain.maxHeight / 5) - 10,
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.schedule,
                            color: Theme.of(context).buttonColor),
                        SizedBox(width: 6),
                        Text("$duration min",
                            style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.work, color: Theme.of(context).buttonColor),
                        SizedBox(width: 6),
                        Text(complexityText,
                            style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.attach_money,
                            color: Theme.of(context).buttonColor),
                        SizedBox(width: 6),
                        Text(affordabilityText,
                            style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
