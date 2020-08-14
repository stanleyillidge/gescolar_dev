/* import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Fluid Sidebar',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin<MyHomePage> {
  Offset _offset = Offset(0, 0);
  GlobalKey globalKey = GlobalKey();
  List<double> limits = [];
  AnimationController _animationController;
  final _animationDuration = const Duration(milliseconds: 500);

  bool isMenuOpen = false;

  @override
  void initState() {
    limits = [0, 0, 0, 0, 0, 0];
    WidgetsBinding.instance.addPostFrameCallback(getPosition);
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: _animationDuration);
  }

  getPosition(duration) {
    RenderBox renderBox = globalKey.currentContext.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);
    double start = position.dy - 20;
    double contLimit = position.dy + renderBox.size.height - 20;
    double step = (contLimit - start) / 5;
    limits = [];
    for (double x = start; x <= contLimit; x = x + step) {
      limits.add(x);
    }
    setState(() {
      limits = limits;
    });
  }

  double getSize(int x) {
    double size =
        (_offset.dy > limits[x] && _offset.dy < limits[x + 1]) ? 25 : 20;
    return size;
  }

  void onIconPressed() {
    if (isMenuOpen) {
      setState(() {
        _animationController.reverse();
        isMenuOpen = false;
      });
    } else {
      setState(() {
        _animationController.forward();
        isMenuOpen = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    double sidebarSize = mediaQuery.width * 0.25;
    double menuContainerHeight = mediaQuery.height / 2;

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(255, 65, 108, 1.0),
                Color.fromRGBO(255, 75, 73, 1.0)
              ],
            ),
          ),
          width: mediaQuery.width,
          child: Stack(
            children: <Widget>[
              Center(
                child: MaterialButton(
                    color: Colors.white,
                    child: Text(
                      "Helo World",
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {}),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 1500),
                left: isMenuOpen ? 0 : -sidebarSize + 10,
                top: 0,
                curve: Curves.elasticOut,
                child: SizedBox(
                  width: sidebarSize + 35,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      if (details.localPosition.dx <= sidebarSize) {
                        setState(() {
                          _offset = details.localPosition;
                        });
                      }
                      if (details.localPosition.dx > sidebarSize - 20 &&
                          details.delta.distanceSquared > 2) {
                        setState(() {
                          _animationController.forward();
                          isMenuOpen = true;
                        });
                      }
                    },
                    onPanEnd: (details) {
                      setState(() {
                        _offset = Offset(0, 0);
                      });
                    },
                    child: Stack(
                      children: <Widget>[
                        CustomPaint(
                          size: Size(sidebarSize, mediaQuery.height),
                          painter: DrawerPainter(offset: _offset),
                        ),
                        Container(
                          height: mediaQuery.height,
                          width: sidebarSize,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Container(
                                height: mediaQuery.height * 0.25,
                                child: Center(
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        "images/monica.png",
                                        width: sidebarSize / 3,
                                      ),
                                      Text(
                                        "RetroPortal Studio",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(
                                thickness: 1,
                              ),
                              Container(
                                key: globalKey,
                                width: double.infinity,
                                height: menuContainerHeight,
                                child: Column(
                                  children: <Widget>[
                                    MyButton(
                                      text: "Profile",
                                      iconData: Icons.person,
                                      textSize: getSize(0),
                                      height: (menuContainerHeight) / 5,
                                    ),
                                    MyButton(
                                      text: "Payments",
                                      iconData: Icons.payment,
                                      textSize: getSize(1),
                                      height: (menuContainerHeight) / 5,
                                    ),
                                    MyButton(
                                      text: "Notifications",
                                      iconData: Icons.notifications,
                                      textSize: getSize(2),
                                      height: (mediaQuery.height / 2) / 5,
                                    ),
                                    MyButton(
                                      text: "Settings",
                                      iconData: Icons.settings,
                                      textSize: getSize(3),
                                      height: (menuContainerHeight) / 5,
                                    ),
                                    MyButton(
                                      text: "My Files",
                                      iconData: Icons.attach_file,
                                      textSize: getSize(4),
                                      height: (menuContainerHeight) / 5,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment(1, 0),
                          child: GestureDetector(
                            onTap: () {
                              onIconPressed();
                            },
                            child: ClipPath(
                              clipper: CustomMenuClipper(),
                              child: Container(
                                width: 35,
                                height: 110,
                                color: Colors.white,
                                alignment: Alignment.centerLeft,
                                child: AnimatedIcon(
                                  progress: _animationController.view,
                                  icon: AnimatedIcons.menu_close,
                                  color: Color(0xFF1BB5FD),
                                  size: 25,
                                ),
                              ),
                            ),
                          ),
                        ),
                        /* AnimatedPositioned(
                          duration: Duration(milliseconds: 400),
                          right: (isMenuOpen) ? 45 : sidebarSize,
                          bottom: 30,
                          child: IconButton(
                            enableFeedback: true,
                            icon: Icon(
                              Icons.keyboard_backspace,
                              color: Colors.black45,
                              size: 30,
                            ),
                            onPressed: () {
                              this.setState(() {
                                isMenuOpen = false;
                              });
                            },
                          ),
                        ) */
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final String text;
  final IconData iconData;
  final double textSize;
  final double height;

  MyButton({this.text, this.iconData, this.textSize, this.height});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialButton(
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon(
            iconData,
            color: Colors.black45,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.black45, fontSize: textSize),
          ),
        ],
      ),
      onPressed: () {},
    );
  }
}

class DrawerPainter extends CustomPainter {
  final Offset offset;

  DrawerPainter({this.offset});

  double getControlPointX(double width) {
    if (offset.dx == 0) {
      return width;
    } else {
      return offset.dx > width ? offset.dx : width + 80;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    Path path = Path();
    var widthx = 35.0;
    var heightx = 110.0;
    // path.moveTo(0, 0);
    // ----------------------------------
    path.quadraticBezierTo(size.width, 8, size.width + 10, 16);
    path.quadraticBezierTo(size.width + widthx - 1, heightx / 2 - 20,
        size.width + widthx, heightx / 2);
    path.quadraticBezierTo(size.width + widthx + 1, heightx / 2 + 20,
        size.width + 10, heightx - 16);
    path.quadraticBezierTo(size.width, heightx - 8, size.width, heightx);
    // ----------------------------------
    path.moveTo(-size.width, 0);
    path.lineTo(size.width, 0);
    path.quadraticBezierTo(
        getControlPointX(size.width), offset.dy, size.width, size.height);
    path.lineTo(-size.width, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return true;
  }
}

class CustomMenuClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Paint paint = Paint();
    paint.color = Colors.white;

    final width = size.width;
    final height = size.height;

    Path path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(0, 8, 10, 16);
    path.quadraticBezierTo(width - 1, height / 2 - 20, width, height / 2);
    path.quadraticBezierTo(width + 1, height / 2 + 20, 10, height - 16);
    path.quadraticBezierTo(0, height - 8, 0, height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
} */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gescolar_dev/pages/home.dart';
import 'package:gescolar_dev/pages/login.dart';
// import 'package:gescolar_dev/services/firebase_auth_service.dart';

void main() {
  runApp(MyApp());
}

Widget home = HomePage();

// stanley.illidge@lreginaldofischione.edu.co
// 116675950093144953544
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // final LocalStorage storage = LocalStorage('gescolar_app');
  // final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  bool initialized = false;
  /* @override
  Widget build(BuildContext context) {
    if (!initialized) {
      // var items = storage.getItem('database');
      // var items1 = storage.getItem('database1');
      // print(['database', items, 'database1', items1]);
      initialized = true;
    }
    // _checkLogin(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: FirebaseAuthService().currentUser() != null
          ? HomePage()
          : LoginPage(),
    );
  } */
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseUser>(
        future: FirebaseAuth.instance.currentUser(),
        builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
          if (snapshot.hasData) {
            // FirebaseUser user = snapshot.data; // this is your user instance
            print(snapshot.data);

            /// is because there is user already logged
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              home: HomePage(),
            );
          }

          /// other way there is no user logged.
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            home: LoginPage(),
          );
        });
  }
}

/* _checkLogin(context) {
  FirebaseAuthService().currentUser().then(
        (value) => {
          print(['Login Ok0:', value]),
          if (value == null)
            {
              MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                home: HomePage(),
              )
            }
          else
            {
              MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                home: LoginPage(),
              )
            }
        },
      );
} */
