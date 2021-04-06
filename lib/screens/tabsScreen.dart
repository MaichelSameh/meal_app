import 'package:flutter/material.dart';

import './categoriesScreen.dart';
import './favoritesScreen.dart';
import '../widgets/mainDrawer.dart';

class TabsScreen extends StatefulWidget {
  static const String routeName = "tab_screen";
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  void _selectedPage(int value) {
    setState(() {
      _selectedPageIndex = value;
    });
  }

  @override
  void initState() {
    _pages = [
      {
        "page": CategoriesScreen(),
        "title": "Category",
      },
      {
        "page": FavoritesScreen(),
        "title": "Your favorites",
      }
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]["title"],
        ),
      ),
      body: _pages[_selectedPageIndex]["page"],
      drawer: MainDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            // ignore: deprecated_member_use
            title: Text("Categories"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            // ignore: deprecated_member_use
            title: Text("Favorites"),
          ),
        ],
      ),
    );
  }
}
