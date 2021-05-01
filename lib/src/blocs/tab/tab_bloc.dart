import 'package:bloc_movies_gallery/src/blocs/tab/tab_event.dart';
import 'package:bloc_movies_gallery/src/models/app_tab.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabBloc extends Bloc<TabEvent, AppTab> {
  TabBloc() : super(AppTab.movies);

  @override
  Stream<AppTab> mapEventToState(TabEvent event) async* {
    if (event is TabUpdated) {
      yield event.tab;
    }
  }
}
