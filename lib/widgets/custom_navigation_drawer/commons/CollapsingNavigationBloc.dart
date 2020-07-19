import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class NavigationStates {}

class Dashboard extends NavigationStates {}

class Search extends NavigationStates {}

class Errors extends NavigationStates {}

class Notifications extends NavigationStates {}

class Settings extends NavigationStates {}

enum NavigationEvents {
  Dashboard,
  Search,
  Errors,
  Notifications,
  Settings,
}

class CollapsingNavigationBloc
    extends Bloc<NavigationEvents, NavigationStates> {
  CollapsingNavigationBloc() : super(Dashboard());

  @override
  Stream<NavigationStates> mapEventToState(NavigationEvents event) async* {
    switch (event) {
      case NavigationEvents.Dashboard:
        yield Dashboard();
        break;
      case NavigationEvents.Errors:
        yield Errors();
        break;
      case NavigationEvents.Search:
        yield Search();
        break;
      case NavigationEvents.Notifications:
        yield Notifications();
        break;
      case NavigationEvents.Settings:
        yield Settings();
        break;
    }
  }
}
