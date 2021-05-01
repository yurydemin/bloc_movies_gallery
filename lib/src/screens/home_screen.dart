import 'package:bloc_movies_gallery/src/blocs/tab/tab_bloc.dart';
import 'package:bloc_movies_gallery/src/blocs/tab/tab_event.dart';
import 'package:bloc_movies_gallery/src/models/app_tab.dart';
import 'package:bloc_movies_gallery/src/widgets/favorites_list.dart';
import 'package:bloc_movies_gallery/src/widgets/movies_list.dart';
import 'package:bloc_movies_gallery/src/widgets/tab_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          body: activeTab == AppTab.movies ? MoviesList() : FavoritesList(),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<TabBloc>(context).add(TabUpdated(tab)),
          ),
        );
      },
    );
  }
}
