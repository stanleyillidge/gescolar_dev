import 'package:flutter/material.dart';

class CustomNeumorphicButton extends StatefulWidget {
  final Widget child;
  final double bevel;
  final Offset blurOffset;
  final Color color;
  Color background;
  final bool darkMode;
  final String imagen;
  final double padding;
  final Function onTap;

  CustomNeumorphicButton({
    Key key,
    this.onTap,
    this.background,
    this.darkMode,
    this.imagen,
    this.padding,
    this.child,
    this.bevel = 10.0,
    this.color,
  })  : this.blurOffset = Offset(bevel / 2, bevel / 2),
        super(key: key);

  @override
  _CustomNeumorphicButtonState createState() => _CustomNeumorphicButtonState();
}

class _CustomNeumorphicButtonState extends State<CustomNeumorphicButton> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
      if (null != widget.onTap) {
        // Raise the event
        widget.onTap();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final color = this.widget.color ?? Theme.of(context).backgroundColor;

    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 60),
        padding: (widget.imagen != null)
            ? EdgeInsets.all(2.0)
            : EdgeInsets.all(widget.padding),
        /* decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.bevel * 5),
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                _isPressed ? color : color.mix(Colors.black, .1),
                _isPressed ? color.mix(Colors.black, .05) : color,
                _isPressed ? color.mix(Colors.black, .05) : color,
                color.mix(Colors.white, _isPressed ? .2 : .5),
              ],
              stops: [
                0.0,
                .3,
                .6,
                1.0,
              ]),
          boxShadow: _isPressed
              ? null
              : [
                  BoxShadow(
                    blurRadius: widget.bevel,
                    offset: -widget.blurOffset,
                    color: color.mix(Colors.white, .6),
                  ),
                  BoxShadow(
                    blurRadius: widget.bevel,
                    offset: widget.blurOffset,
                    color: color.mix(Colors.black, .3),
                  )
                ],
        ), */
        decoration: BoxDecoration(
          color: widget.darkMode
              ? Colors.grey[850]
              : (widget.background != null)
                  ? widget.background
                  : Colors.grey[300],
          // borderRadius: BorderRadius.all(Radius.circular(50)),
          borderRadius: BorderRadius.circular(widget.bevel * 2),
          boxShadow: _isPressed
              ? null
              : [
                  BoxShadow(
                      color: widget.darkMode ? Colors.black54 : Colors.grey[400]
                        ..withOpacity(0.7),
                      offset: Offset(2.0, 2.0),
                      blurRadius: 5.0,
                      spreadRadius: 3.5),
                  BoxShadow(
                      color: widget.darkMode ? Colors.grey[700] : Colors.white,
                      offset: Offset(-3.0, -3.0),
                      blurRadius: 5.0,
                      spreadRadius: 3.5),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            (widget.imagen != null)
                ? Container(
                    padding: const EdgeInsets.all(0.0),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.center,
                        image: AssetImage(widget.imagen),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(),
            Container(
              margin: (widget.imagen != null)
                  ? EdgeInsets.only(left: 5, right: 5)
                  : EdgeInsets.only(left: 0, right: 0),
              child: widget.child,
            ),
          ],
        ),
      ),
      /* child: GestureDetector(
        // onTap: widget.onTap,
        onTap: () {
          if (null != widget.onTap) {
            // Raise the event
            widget.onTap();
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 60),
          padding: (widget.imagen != null)
              ? EdgeInsets.all(2.0)
              : EdgeInsets.all(widget.padding),
          /* decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.bevel * 5),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _isPressed ? color : color.mix(Colors.black, .1),
                  _isPressed ? color.mix(Colors.black, .05) : color,
                  _isPressed ? color.mix(Colors.black, .05) : color,
                  color.mix(Colors.white, _isPressed ? .2 : .5),
                ],
                stops: [
                  0.0,
                  .3,
                  .6,
                  1.0,
                ]),
            boxShadow: _isPressed
                ? null
                : [
                    BoxShadow(
                      blurRadius: widget.bevel,
                      offset: -widget.blurOffset,
                      color: color.mix(Colors.white, .6),
                    ),
                    BoxShadow(
                      blurRadius: widget.bevel,
                      offset: widget.blurOffset,
                      color: color.mix(Colors.black, .3),
                    )
                  ],
          ), */
          decoration: BoxDecoration(
            color: widget.darkMode
                ? Colors.grey[850]
                : (widget.background != null)
                    ? widget.background
                    : Colors.grey[300],
            // borderRadius: BorderRadius.all(Radius.circular(50)),
            borderRadius: BorderRadius.circular(widget.bevel * 2),
            boxShadow: _isPressed
                ? null
                : [
                    BoxShadow(
                        color:
                            widget.darkMode ? Colors.black54 : Colors.grey[500]
                              ..withOpacity(0.7),
                        offset: Offset(4.0, 4.0),
                        blurRadius: 6.0, //15
                        spreadRadius: 3.0), //1
                    BoxShadow(
                        color:
                            widget.darkMode ? Colors.grey[800] : Colors.white,
                        offset: Offset(-4.0, -4.0),
                        blurRadius: 6.0,
                        spreadRadius: 3.0),
                  ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              (widget.imagen != null)
                  ? Container(
                      padding: const EdgeInsets.all(0.0),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.center,
                          image: AssetImage(widget.imagen),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : Container(),
              Container(
                margin: (widget.imagen != null)
                    ? EdgeInsets.only(left: 5, right: 5)
                    : EdgeInsets.only(left: 0, right: 0),
                child: widget.child,
              ),
            ],
          ),
        ),
      ), */
    );
    /* return GestureDetector(
      // onTap: widget.onTap,
      onTap: () {
        if (null != widget.onTap) {
          // Raise the event
          return widget.onTap();
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 60),
        padding: (widget.imagen != null)
            ? EdgeInsets.all(2.0)
            : EdgeInsets.all(widget.padding),
        /* decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.bevel * 5),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  _isPressed ? color : color.mix(Colors.black, .1),
                  _isPressed ? color.mix(Colors.black, .05) : color,
                  _isPressed ? color.mix(Colors.black, .05) : color,
                  color.mix(Colors.white, _isPressed ? .2 : .5),
                ],
                stops: [
                  0.0,
                  .3,
                  .6,
                  1.0,
                ]),
            boxShadow: _isPressed
                ? null
                : [
                    BoxShadow(
                      blurRadius: widget.bevel,
                      offset: -widget.blurOffset,
                      color: color.mix(Colors.white, .6),
                    ),
                    BoxShadow(
                      blurRadius: widget.bevel,
                      offset: widget.blurOffset,
                      color: color.mix(Colors.black, .3),
                    )
                  ],
          ), */
        decoration: BoxDecoration(
          color: widget.darkMode
              ? Colors.grey[850]
              : (widget.background != null)
                  ? widget.background
                  : Colors.grey[300],
          // borderRadius: BorderRadius.all(Radius.circular(50)),
          borderRadius: BorderRadius.circular(widget.bevel * 2),
          boxShadow: _isPressed
              ? null
              : [
                  BoxShadow(
                      color: widget.darkMode ? Colors.black54 : Colors.grey[500]
                        ..withOpacity(0.7),
                      offset: Offset(4.0, 4.0),
                      blurRadius: 6.0, //15
                      spreadRadius: 3.0), //1
                  BoxShadow(
                      color: widget.darkMode ? Colors.grey[800] : Colors.white,
                      offset: Offset(-4.0, -4.0),
                      blurRadius: 6.0,
                      spreadRadius: 3.0),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            (widget.imagen != null)
                ? Container(
                    padding: const EdgeInsets.all(0.0),
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        alignment: Alignment.center,
                        image: AssetImage(widget.imagen),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : Container(),
            Container(
              margin: (widget.imagen != null)
                  ? EdgeInsets.only(left: 5, right: 5)
                  : EdgeInsets.only(left: 0, right: 0),
              child: widget.child,
            ),
          ],
        ),
      ),
    ); */
  }
}

extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }
}
