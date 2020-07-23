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
  double minWidth = 50;
  // double _width = 210;
  int duration = 230;
  bool isCollapsed = false;
  AnimationController _animationController;
  Animation<double> widthAnimation;
  int currentSelectedIndex = 0;

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
                          /* return Theme(
                            data: Theme.of(context)
                                .copyWith(cardColor: drawerBackgroundColor),
                            child: ExpansionPanelList(
                              expansionCallback: (int index, bool isExpanded) {
                                setState(() {
                                  // int m = 0;
                                  // print(navigationItems.length);
                                  for (var i = 0;
                                      i < navigationItems.length;
                                      i++) {
                                    if (i != counter) {
                                      // print(navigationItems[i].isExpanded);
                                      navigationItems[i].isExpanded = false;
                                    }
                                  }
                                  navigationItems[counter].isExpanded =
                                      !navigationItems[counter].isExpanded;
                                });
                              },
                              children: [
                                ExpansionPanel(
                                  headerBuilder:
                                      (BuildContext context, bool isExpanded) {
                                    return CollapsingListTile(
                                      onTap: () {
                                        setState(() {
                                          bloc.add(navigationItems[counter]
                                              .navigationEvent);
                                          currentSelectedIndex = counter;
                                        });
                                      },
                                      isSelected:
                                          currentSelectedIndex == counter,
                                      title: navigationItems[counter].title,
                                      icon: navigationItems[counter].icon,
                                      animationController: _animationController,
                                    );
                                  },
                                  body: ListTile(
                                    title: Text('Item 1 child'),
                                    subtitle: Text('Details goes here'),
                                  ),
                                  isExpanded:
                                      navigationItems[counter].isExpanded,
                                ),
                              ],
                            ),
                          ); */
                          return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            elevation: 2,
                            margin: EdgeInsets.all(12.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ExpansionTile(
                                backgroundColor: Colors.white,
                                title: CollapsingListTile(
                                  onTap: () {
                                    setState(() {
                                      bloc.add(navigationItems[counter]
                                          .navigationEvent);
                                      currentSelectedIndex = counter;
                                    });
                                  },
                                  isSelected: currentSelectedIndex == counter,
                                  title: navigationItems[counter].title,
                                  icon: navigationItems[counter].icon,
                                  animationController: _animationController,
                                ),
                                trailing: SizedBox(),
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text("Herzlich Willkommen"),
                                        Spacer(),
                                        Icon(Icons.check),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: <Widget>[
                                        Text("Das Kursmenu"),
                                        Spacer(),
                                        Icon(Icons.check),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                          /* return Hero(
                            tag: "card$counter",
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Stack(
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      AspectRatio(
                                        aspectRatio: 485.0 / 384.0,
                                        child: Image.network("https://picsum.photos/485/384?image=$counter"),
                                      ),
                                      Material(
                                        child: ListTile(
                                          title: Text("Item $counter"),
                                          subtitle: Text("This is item #$counter"),
                                        ),
                                      )
                                    ],
                                  ),
                                  Positioned(
                                    left: 0.0,
                                    top: 0.0,
                                    bottom: 0.0,
                                    right: 0.0,
                                    child: Material(
                                      type: MaterialType.transparency,
                                      child: InkWell(
                                        onTap: () async {
                                          await Future.delayed(Duration(milliseconds: 200));
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return new PageItem(num: num);
                                              },
                                              fullscreenDialog: true,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ); */
                        } else {
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
