import 'package:flutter/material.dart';

import '../screens/filtersScreen.dart';
import '../screens/theme_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(
      String text, IconData icon, Function function, BuildContext ctx) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Theme.of(ctx).buttonColor,
      ),
      title: Text(
        text,
        style: TextStyle(
            color: Theme.of(ctx).textTheme.bodyText1.color,
            fontSize: 24,
            fontFamily: "RobotoCondensed",
            fontWeight: FontWeight.bold),
      ),
      onTap: function,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        elevation: 0,
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              color: Theme.of(context).accentColor,
              child: Text(
                "Cooking up!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            SizedBox(height: 20),
            buildListTile(
              "Meal",
              Icons.restaurant,
              () {
                Navigator.of(context).pushReplacementNamed("/");
              },
              context,
            ),
            buildListTile(
              "Filters",
              Icons.settings,
              () {
                Navigator.of(context)
                    .pushReplacementNamed(FiltersScreen.routeName);
              },
              context,
            ),
            buildListTile(
              "Themes",
              Icons.color_lens,
              () {
                Navigator.of(context)
                    .pushReplacementNamed(ThemeScreen.routeName);
              },
              context,
            ),
          ],
        ));
  }
}
