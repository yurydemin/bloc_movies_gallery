import 'package:bloc_movies_gallery/src/keys.dart';
import 'package:bloc_movies_gallery/src/models/app_tab.dart';
import 'package:flutter/material.dart';

class TabSelector extends StatelessWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;

  TabSelector({
    Key key,
    @required this.activeTab,
    @required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      key: MoviesAppKeys.tabs,
      currentIndex: AppTab.values.indexOf(activeTab),
      onTap: (index) => onTabSelected(AppTab.values[index]),
      items: AppTab.values.map((tab) {
        return BottomNavigationBarItem(
          icon: Icon(
            tab == AppTab.movies ? Icons.list : Icons.star,
            key: tab == AppTab.movies
                ? MoviesAppKeys.moviesTab
                : MoviesAppKeys.favoritesTab,
          ),
          label: tab == AppTab.movies ? 'Movies' : 'Favorites',
        );
      }).toList(),
    );
  }
}
