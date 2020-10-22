import 'package:flutter/material.dart';
import 'package:gescolar_dev/widgets/custom_navigation_drawer/commons/CollapsingNavigationBloc.dart';
import 'package:gescolar_dev/widgets/custom_navigation_drawer/custom_navigation_drawer.dart';

class Size {
  double h;
  double w;

  Size(this.h, this.w);
}

class SubMenu {
  String titulo;
  IconData icono;
  NavigationEvents navigationEvent;
  SubMenu(this.titulo, this.icono, this.navigationEvent);
}

List<Widget> _submenu;

class NavigationModel {
  String title;
  IconData icon;
  NavigationEvents navigationEvent;
  bool isExpanded;
  bool isCollapsed;
  Size size;
  double height;
  List<NavigationModel> submenu;

  NavigationModel(
      {this.title,
      this.icon,
      this.navigationEvent,
      this.isExpanded,
      this.isCollapsed,
      this.size,
      this.height,
      this.submenu});
}

List<NavigationModel> navigationItems = [
  NavigationModel(
      title: "Dashboard",
      icon: Icons.insert_chart,
      isExpanded: false,
      isCollapsed: true,
      size: Size(50, 210),
      height: 0,
      submenu: [
        NavigationModel(
          title: "Año lectivo",
          icon: Icons.error,
          isExpanded: false,
          isCollapsed: true,
          size: Size(50, 200),
          height: 0,
          navigationEvent: NavigationEvents.Dashboard,
          submenu: [
            NavigationModel(
              title: "Año lectivo",
              icon: Icons.error,
              isExpanded: false,
              isCollapsed: false,
              size: Size(50, 200),
              height: 0,
              navigationEvent: NavigationEvents.Dashboard,
            ),
            NavigationModel(
                title: "Matriculas",
                icon: Icons.bluetooth_searching,
                isExpanded: false,
                isCollapsed: false,
                size: Size(50, 200),
                height: 0,
                navigationEvent: NavigationEvents.Institucional)
          ],
        ),
        NavigationModel(
          title: "Institucional",
          icon: Icons.bluetooth_searching,
          isExpanded: false,
          isCollapsed: false,
          size: Size(50, 200),
          height: 0,
          navigationEvent: NavigationEvents.Institucional,
        ),
        NavigationModel(
          title: "Matriculas",
          icon: Icons.bluetooth_searching,
          isExpanded: false,
          isCollapsed: false,
          size: Size(50, 200),
          height: 0,
          navigationEvent: NavigationEvents.Matriculas,
        )
      ],
      navigationEvent: NavigationEvents.Dashboard),
  NavigationModel(
      title: "Errors",
      icon: Icons.error,
      isExpanded: false,
      isCollapsed: false,
      size: Size(200, 200),
      height: 0,
      navigationEvent: NavigationEvents.Errors),
  NavigationModel(
      title: "Search",
      icon: Icons.search,
      isExpanded: false,
      isCollapsed: false,
      size: Size(200, 200),
      height: 0,
      navigationEvent: NavigationEvents.Search),
  NavigationModel(
      title: "Notifications",
      icon: Icons.notifications,
      isExpanded: false,
      isCollapsed: false,
      size: Size(200, 200),
      height: 0,
      navigationEvent: NavigationEvents.Notifications),
  NavigationModel(
      title: "Settings",
      icon: Icons.settings,
      isExpanded: false,
      isCollapsed: false,
      size: Size(200, 200),
      height: 0,
      navigationEvent: NavigationEvents.Settings),
];
// add(_subMenu(SubMenu('Sedes', Icons.accessibility_new)))
/* _subMenu(a) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Row(
      children: <Widget>[
        Text(a.titulo),
        Spacer(),
        Icon(a.icono),
      ],
    ),
  );
} */
