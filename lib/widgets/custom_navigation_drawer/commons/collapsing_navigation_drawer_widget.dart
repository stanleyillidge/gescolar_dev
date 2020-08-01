import 'package:gescolar_dev/widgets/custom_navigation_drawer/commons/CollapsingNavigationBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../custom_navigation_drawer.dart';
import 'package:flutter/material.dart';

class CollapsingNavigationDrawer extends StatefulWidget {
  @override
  CollapsingNavigationDrawerState createState() {
    return new CollapsingNavigationDrawerState();
  }
}

class CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 210;
  double minWidth = 58;
  // double _width = 210;
  int duration = 230;
  bool isCollapsed = false;
  AnimationController _animationController;
  Animation<double> widthAnimation;
  List<int> currentSelectedIndex = [0, 99];
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: duration));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
        // .animate(_animationController);
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.decelerate));
    _animationController.forward();
  }

  /*  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      child: Container(
        // duration: Duration(milliseconds: duration),
        // curve: Curves.decelerate,
        width: widthAnimation.value,
        color: drawerBackgroundColor,
        child: Column(
          children: <Widget>[
            CollapsingListTile(
              duration: duration,
              width: widthAnimation.value,
              title: 'Techie',
              icon: Icons.person,
              animationController: _animationController,
            ),
            Divider(
              color: Colors.grey,
              height: 40.0,
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, counter) {
                  return Divider(height: 12.0);
                },
                itemBuilder: (context, counter) {
                  return CollapsingListTile(
                    onTap: () {
                      setState(() {
                        currentSelectedIndex = counter;
                        isCollapsed = false;
                        _width = maxWidth;
                        _animationController.reverse();
                      });
                    },
                    duration: duration,
                    width: _width,
                    isSelected: currentSelectedIndex == counter,
                    title: navigationItems[counter].title,
                    icon: navigationItems[counter].icon,
                    animationController: _animationController,
                  );
                },
                itemCount: navigationItems.length,
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isCollapsed = !isCollapsed;
                  // if (isCollapsed) {
                  //   _animationController.forward();
                  //   _width = maxWidth;
                  // } else {
                  //   _width = minWidth;
                  //   _animationController.reverse();
                  // }
                  isCollapsed
                      ? _animationController.forward()
                      : _animationController.reverse();
                });
              },
              child: AnimatedIcon(
                icon: AnimatedIcons.close_menu,
                progress: _animationController,
                color: selectedColor,
                size: 50.0,
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
          ],
        ),
      ),
    );
  } */

  @override
  Widget build(BuildContext context) {
    final CollapsingNavigationBloc bloc =
        BlocProvider.of<CollapsingNavigationBloc>(context);

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(bloc, context, widget),
    );
  }

  var spaceTop = 10.0;
  Widget getWidget(CollapsingNavigationBloc bloc, context, widget) {
    var size = MediaQuery.of(context).size;
    /* return Column(
      children: <Widget>[
        Padding(padding: EdgeInsets.only(bottom: spaceTop)),
        ClipPath(
          child: GestureDetector(
            onPanEnd: (e) {
              setState(() {
                isCollapsed = !isCollapsed;
                isCollapsed
                    ? _animationController.forward()
                    : _animationController.reverse();
              });
            },
            child: Container(
              width: widthAnimation.value,
              height: size.height - (spaceTop * 2),
              decoration: BoxDecoration(
                color: drawerBackgroundColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              padding: EdgeInsets.only(top: 30.0),
              child: Column(
                children: <Widget>[
                  CollapsingListTile(
                    title: 'Usuario',
                    icon: Icons.person,
                    animationController: _animationController,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 40.0,
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, counter) {
                        return Divider(height: 12.0);
                      },
                      itemBuilder: (context, counter) {
                        return CollapsingListTile(
                          onTap: () {
                            setState(() {
                              bloc.add(
                                  navigationItems[counter].navigationEvent);
                              currentSelectedIndex = counter;
                            });
                          },
                          isSelected: currentSelectedIndex == counter,
                          title: navigationItems[counter].title,
                          icon: navigationItems[counter].icon,
                          animationController: _animationController,
                        );
                      },
                      itemCount: navigationItems.length,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isCollapsed = !isCollapsed;
                        isCollapsed
                            ? _animationController.forward()
                            : _animationController.reverse();
                      });
                    },
                    child: AnimatedIcon(
                      icon: AnimatedIcons.close_menu,
                      progress: _animationController,
                      color: selectedColor,
                      size: 50.0,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ); */
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(bottom: spaceTop)),
        Material(
          elevation: 10.0,
          // color: Colors.transparent,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
          child: GestureDetector(
            onPanEnd: (e) {
              setState(() {
                isCollapsed = !isCollapsed;
                isCollapsed
                    ? _animationController.forward()
                    : _animationController.reverse();
              });
            },
            child: Container(
              width: widthAnimation.value,
              height: size.height - (spaceTop * 2),
              padding: EdgeInsets.only(top: 30.0),
              // color: drawerBackgroundColor,
              decoration: BoxDecoration(
                color: drawerBackgroundColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                children: <Widget>[
                  CollapsingListTile(
                    title: 'Techie',
                    icon: Icons.person,
                    isExpanded: false,
                    animationController: _animationController,
                  ),
                  Divider(
                    color: Colors.grey,
                    height: 40.0,
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, counter) {
                        return Divider(height: 12.0);
                      },
                      itemBuilder: (context, counter) {
                        if (navigationItems[counter].isCollapsed) {
                          if (navigationItems[counter].height !=
                              navigationItems[counter].size.h) {
                            navigationItems[counter].isExpanded = true;
                          }
                          return Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: () => setState(() {
                                  navigationItems[counter].height !=
                                          navigationItems[counter].size.h
                                      ? navigationItems[counter].height =
                                          navigationItems[counter].size.h
                                      : navigationItems[counter].height = 0.0;
                                }),
                                child: Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          navigationItems[counter].size.w),
                                  padding: EdgeInsets.only(top: 5),
                                  child: CollapsingListTile(
                                    onTap: null,
                                    isSelected:
                                        currentSelectedIndex[0] == counter,
                                    isExpanded: (currentSelectedIndex[0] ==
                                            counter) &&
                                        navigationItems[counter].isCollapsed,
                                    title: navigationItems[counter].title,
                                    icon: navigationItems[counter].icon,
                                    animationController: _animationController,
                                  ),
                                  // color: Colors.blueAccent,
                                  // height: 25.0,
                                  width: (widthAnimation.value == 50)
                                      ? (widthAnimation.value - 1)
                                      : (navigationItems[counter].size.w),
                                ),
                              ),
                              AnimatedContainer(
                                padding: EdgeInsets.only(top: 6.0),
                                duration: const Duration(milliseconds: 340),
                                curve: Curves.decelerate,
                                child: !navigationItems[counter].isExpanded
                                    ? null
                                    : ListView.separated(
                                        separatorBuilder: (context, index) {
                                          return Divider(height: 6.0);
                                        },
                                        itemBuilder: (context, index) {
                                          return CollapsingListTile(
                                            onTap: () {
                                              setState(() {
                                                bloc.add(
                                                    navigationItems[counter]
                                                        .submenu[index]
                                                        .navigationEvent);
                                                currentSelectedIndex[1] = index;
                                                currentSelectedIndex[0] =
                                                    counter;
                                                print(widthAnimation.value);
                                              });
                                            },
                                            isSelected:
                                                currentSelectedIndex[1] ==
                                                    index,
                                            isExpanded: false,
                                            title: navigationItems[counter]
                                                .submenu[index]
                                                .title,
                                            icon: navigationItems[counter]
                                                .submenu[index]
                                                .icon,
                                            animationController:
                                                _animationController,
                                          );
                                        },
                                        itemCount: navigationItems[counter]
                                            .submenu
                                            .length),
                                height: navigationItems[counter].height *
                                    navigationItems[counter].submenu.length,
                                color: (widthAnimation.value > 50)
                                    ? Colors.transparent.withOpacity(0.25)
                                    : Colors.transparent.withOpacity(0.3),
                                width: (widthAnimation.value == 58)
                                    ? (widthAnimation.value)
                                    : (navigationItems[counter].size.w - 20),
                                margin: (widthAnimation.value > 50)
                                    ? EdgeInsets.symmetric(horizontal: 5)
                                    : EdgeInsets.symmetric(
                                        horizontal:
                                            (widthAnimation.value / 58)),
                              )
                            ],
                          );
                        } else {
                          return CollapsingListTile(
                            onTap: () {
                              setState(() {
                                bloc.add(
                                    navigationItems[counter].navigationEvent);
                                currentSelectedIndex[0] = counter;
                              });
                            },
                            isSelected: currentSelectedIndex[0] == counter,
                            isExpanded: false,
                            title: navigationItems[counter].title,
                            icon: navigationItems[counter].icon,
                            animationController: _animationController,
                          );
                        }
                      },
                      itemCount: navigationItems.length,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isCollapsed = !isCollapsed;
                        isCollapsed
                            ? _animationController.forward()
                            : _animationController.reverse();
                      });
                    },
                    child: AnimatedIcon(
                      icon: AnimatedIcons.close_menu,
                      progress: _animationController,
                      color: selectedColor,
                      size: 25.0,
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
