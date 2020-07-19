import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gescolar_dev/pages/cinco.dart';
import 'package:gescolar_dev/pages/cuatro.dart';
import 'package:gescolar_dev/pages/dos.dart';
import 'package:gescolar_dev/pages/tres.dart';
import 'package:gescolar_dev/pages/uno.dart';
import 'package:gescolar_dev/widgets/custom_navigation_drawer/commons/CollapsingNavigationBloc.dart';
import 'package:gescolar_dev/widgets/custom_navigation_drawer/custom_navigation_drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<CollapsingNavigationBloc>(
        create: (context) => CollapsingNavigationBloc(),
        child: Stack(
          children: <Widget>[
            Center(
              child: BlocBuilder<CollapsingNavigationBloc, NavigationStates>(
                builder: (context, state) {
                  if (state is Dashboard) {
                    return Uno();
                  } else if (state is Errors) {
                    return Dos();
                  } else if (state is Search) {
                    return Tres();
                  } else if (state is Notifications) {
                    return Cuatro();
                  } else if (state is Settings) {
                    return Cinco();
                  }
                },
              ),
            ),
            CollapsingNavigationDrawer(),
          ],
        ),
      ),
    );
  }
}
