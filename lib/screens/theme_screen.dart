import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import '../providers/theme_provider.dart';

import '../widgets/mainDrawer.dart';

class ThemeScreen extends StatelessWidget {
  static const String routeName = "/themes";

  Widget buildRadioListTile(
      ThemeMode themeVal, String text, IconData icon, BuildContext ctx) {
    return RadioListTile(
      value: themeVal,
      secondary: Icon(icon, color: Theme.of(ctx).buttonColor),
      groupValue: ctx.watch<ThemeProvider>().tm,
      onChanged: (newThemeValue) =>
          ctx.read<ThemeProvider>().themeModeChange(newThemeValue),
      title: Text(text, style: Theme.of(ctx).textTheme.bodyText1),
    );
  }

  Widget buildListTile(BuildContext ctx, String text) {
    var primaryColor = ctx.watch<ThemeProvider>().primaryColor;
    var accentColor = ctx.watch<ThemeProvider>().accentColor;

    return ListTile(
      title: Text(
        "Choose your $text color",
        style: Theme.of(ctx).textTheme.headline6,
      ),
      trailing: CircleAvatar(
        backgroundColor: text == "primary" ? primaryColor : accentColor,
      ),
      onTap: () {
        showDialog(
          context: ctx,
          builder: (context) => AlertDialog(
            elevation: 4,
            titlePadding: const EdgeInsets.all(0),
            contentPadding: const EdgeInsets.all(0),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: text == "primary"
                    ? context.watch<ThemeProvider>().primaryColor
                    : context.watch<ThemeProvider>().accentColor,
                onColorChanged: (newColor) =>
                    context.read<ThemeProvider>().onChanged(
                          newColor,
                          text == "primary" ? 1 : 2,
                        ),
                colorPickerWidth: 300,
                pickerAreaHeightPercent: 0.7,
                enableAlpha: false,
                displayThumbColor: true,
                showLabel: false,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (ctx, themeProvider, child) => Scaffold(
        appBar: AppBar(title: Text("Your Themes")),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Adjust your themes selection.",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      "Choose your theme Mode",
                      style: Theme.of(ctx).textTheme.headline6,
                    ),
                  ),
                  buildRadioListTile(
                    ThemeMode.system,
                    "System default theme",
                    null,
                    ctx,
                  ),
                  buildRadioListTile(
                    ThemeMode.light,
                    "Light theme",
                    Icons.wb_sunny_outlined,
                    ctx,
                  ),
                  buildRadioListTile(
                    ThemeMode.dark,
                    "Dark theme",
                    Icons.nights_stay_outlined,
                    ctx,
                  ),
                  buildListTile(ctx, "primary"),
                  buildListTile(ctx, "accent"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
