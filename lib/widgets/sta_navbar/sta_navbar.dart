import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';
// import 'dart:math' as Math;

class StaNavBar extends StatefulWidget {
  var end;

  StaNavBar({Key key, this.end}) : super(key: key);

  @override
  _StaNavBarState createState() => _StaNavBarState(end: end);
}

class _StaNavBarState extends State<StaNavBar> with TickerProviderStateMixin {
  double end;
  double ini;
  _StaNavBarState({Key key, this.end});

  AnimationController _controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    print(['initState ini', ini]);
    if (ini == null) {
      ini = 1.0;
      print(['initState in if ini', ini]);
    }
    _controller = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );
    animation = Tween(begin: ini, end: end).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var spaceTop = 10.0;
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(
              left: size.width - (size.width * 0.785), bottom: spaceTop),
        ),
        AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            return ClipPath(
              clipper: MyCliper(_controller.value * end),
              child: Container(
                height: size.height - (spaceTop * 2),
                width: size.width * 0.2,
                decoration: BoxDecoration(color: Colors.blue),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      end = end + 2;
                      _controller.forward();
                      // _controller.reverse();
                    });
                  },
                  onTapDown: (e) {
                    print(e);
                    setState(() {
                      _controller.reverse();
                    });
                  },
                  child: AnimatedIcon(
                    icon: AnimatedIcons.close_menu,
                    progress: _controller,
                    size: 50.0,
                  ),
                ),
                /* Center(
                    /* child: RaisedButton(
                    child: Text('Update State'),
                    onPressed: () {
                      setState(() {
                        // print(['Antes end-ini', end, ini]);
                        // _controller.value = end + ini;
                        end = end + 3;
                        _controller
                            .forward()
                            .whenComplete(() => _controller.animateBack(ini));
                        // ini = end;
                        print(['Despues end-ini', end, ini, _controller.value]);
                      });
                    },
                  ) */
                  ) */
              ),
            );
          },
        ),
      ],
    );
  }
}

class MyCliper extends CustomClipper<Path> {
  double position;

  MyCliper(this.position) {
    print(['Cliper pos', position]);
    if (position > 22) {
      position = 22;
    } else if (position < 1) {
      position = 1;
    }
  }

  @override
  Path getClip(Size size) {
    var sw = size.width;
    var sh = size.height;
    print([sw, sh]);
    // Method to convert degree to radians
    // num degToRad(num deg) => deg * (Math.pi / 180.0);

    var corner = 25.0;
    // var position = 8.0;
    var path = new Path();
    // part inferior
    path.lineTo(0.0, size.height - corner);
    path.quadraticBezierTo(0.0, size.height, corner, size.height);
    path.lineTo(size.width - corner, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - corner);
    // seleccion
    path.lineTo(size.width, size.height - (corner * position));
    path.cubicTo(
        size.width,
        size.height - (corner * position),
        size.width + 5,
        size.height - (corner * (position + 1)),
        size.width - (corner),
        size.height - (corner * (position + 1)));

    path.lineTo(corner + corner, size.height - (corner * (position + 1)));
    path.quadraticBezierTo(corner, size.height - (corner * (position + 1)),
        corner, size.height - (corner * (position + 2)));

    path.lineTo(corner, (size.height - (corner * (position + 2))));
    path.quadraticBezierTo(
        corner + (corner * (1 / corner)),
        size.height - (corner * (position + 3)),
        corner + corner,
        size.height - (corner * (position + 3)));

    path.lineTo(size.width - corner, size.height - (corner * (position + 3)));
    path.cubicTo(
        size.width + corner,
        size.height - (corner * (position + 3)),
        size.width - corner,
        size.height - (corner * (position + 5)),
        size.width + corner,
        size.height - (corner * (position + 5)));

    // parte superior
    path.lineTo(size.width, corner * 1.0);
    path.quadraticBezierTo(
        size.width, 1, size.width - (corner * ((1 / corner) + 1.1)), 0);
    path.lineTo(corner, 0.0);
    path.quadraticBezierTo(0.0, 0.0, 0.0, corner);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class NavCustomPainter extends CustomPainter {
  double loc;
  double s;
  Color color;
  TextDirection textDirection;

  NavCustomPainter(
      double startingLoc, int itemsLength, this.color, this.textDirection) {
    final span = 1.0 / itemsLength;
    s = 0.15;
    double l = startingLoc + (span - s) / 2;
    loc = textDirection == TextDirection.rtl ? 0.8 - l : l;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    var x = size.width;
    var y = size.height;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo((loc - 0.1) * x, 0)
      ..cubicTo(
        (loc + s * 0.20) * x, //#1
        y * 0, //0.05 //#2
        loc * x - 1, //#3
        y * 0.60,
        (loc + s * 0.50) * x, //#4
        y * 0.60,
      )
      ..cubicTo(
        (loc + s) * x + 1, //#3
        y * 0.60,
        (loc + s - s * 0.20) * x, //#1
        y * 0, //0.05 //#2
        (loc + s + 0.1) * x, //#4
        0,
      )
      ..lineTo(x, 0)
      ..lineTo(x, y)
      ..lineTo(0, y)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
