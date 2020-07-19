import 'package:flutter/material.dart';
import 'package:gescolar_dev/widgets/custom_navigation_drawer/commons/CollapsingNavigationBloc.dart';

class NavigationModel {
  String title;
  IconData icon;
  NavigationEvents navigationEvent;
  bool isExpanded;
  bool isCollapsed;

  NavigationModel(
      {this.title,
      this.icon,
      this.navigationEvent,
      this.isExpanded,
      this.isCollapsed});
}

List<NavigationModel> navigationItems = [
  NavigationModel(
      title: "Dashboard",
      icon: Icons.insert_chart,
      isExpanded: false,
      isCollapsed: false,
      navigationEvent: NavigationEvents.Dashboard),
  NavigationModel(
      title: "Errors",
      icon: Icons.error,
      isExpanded: false,
      isCollapsed: false,
      navigationEvent: NavigationEvents.Errors),
  NavigationModel(
      title: "Search",
      icon: Icons.search,
      isExpanded: false,
      isCollapsed: false,
      navigationEvent: NavigationEvents.Search),
  NavigationModel(
      title: "Notifications",
      icon: Icons.notifications,
      isExpanded: false,
      isCollapsed: false,
      navigationEvent: NavigationEvents.Notifications),
  NavigationModel(
      title: "Settings",
      icon: Icons.settings,
      isExpanded: false,
      isCollapsed: false,
      navigationEvent: NavigationEvents.Settings),
];
