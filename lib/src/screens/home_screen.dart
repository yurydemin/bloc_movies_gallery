import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_movies_gallery/src/blocs/tab/tab_bloc.dart';
import 'package:bloc_movies_gallery/src/blocs/tab/tab_event.dart';
import 'package:bloc_movies_gallery/src/models/app_tab.dart';
import 'package:bloc_movies_gallery/src/widgets/favorites_list.dart';
import 'package:bloc_movies_gallery/src/widgets/movies_list.dart';
import 'package:bloc_movies_gallery/src/widgets/search_textfield.dart';
import 'package:bloc_movies_gallery/src/widgets/tab_selector.dart';
import 'package:bloc_movies_gallery/src/blocs/filtered_movies/filtered_movies_bloc.dart';
import 'package:bloc_movies_gallery/src/blocs/filtered_movies/filtered_movies_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: activeTab == AppTab.movies
              ? AppBar(
                  title: SearchTextfield(
                    searchFilter: '',
                    onChanged: (value) {
                      BlocProvider.of<FilteredMoviesBloc>(context)
                          .add(FilterUpdated(value));
                    },
                  ),
                  leading: Icon(Icons.search),
                )
              : AppBar(
                  title: Text('Favorites'),
                  centerTitle: true,
                ),
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
