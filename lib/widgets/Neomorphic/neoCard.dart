/* import 'package:flutter/material.dart';

class NeumorphicCard extends StatefulWidget {
  final Widget child;
  final double bevel;
  final Offset blurOffset;
  final Color color;
  final bool darkMode;
  final String imagen;
  final double padding;

  NeumorphicCard({
    Key key,
    this.darkMode,
    this.imagen,
    this.padding,
    this.child,
    this.bevel = 10.0,
    this.color,
  })  : this.blurOffset = Offset(bevel / 2, bevel / 2),
        super(key: key);

  @override
  _NeumorphicCardState createState() => _NeumorphicCardState();
}

class _NeumorphicCardState extends State<NeumorphicCard> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final color = this.widget.color ?? Theme.of(context).backgroundColor;

    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        padding: (widget.imagen != null)
            ? EdgeInsets.all(2.0)
            : EdgeInsets.all(widget.padding),
        decoration: BoxDecoration(
          color: widget.darkMode ? Colors.grey[850] : Colors.white,
          borderRadius: BorderRadius.circular(widget.bevel * 2),
          boxShadow: _isPressed
              ? null
              : [
                  BoxShadow(
                      color:
                          widget.darkMode ? Colors.black54 : Colors.grey[300],
                      offset: Offset(2.0, 2.0),
                      blurRadius: 7.0,
                      spreadRadius: 1.0),
                  BoxShadow(
                      color: widget.darkMode ? Colors.grey[800] : Colors.white,
                      offset: Offset(-2.0, -2.0),
                      blurRadius: 7.0,
                      spreadRadius: 1.0),
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
    );
  }
}

extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }
} */
import 'package:flutter/material.dart';

class NeumorphicContainer extends StatefulWidget {
  final Widget child;
  final double bevel;
  final Offset blurOffset;
  final Color color;

  NeumorphicContainer({
    Key key,
    this.child,
    this.bevel = 10.0,
    this.color,
  })  : this.blurOffset = Offset(bevel / 2, bevel / 2),
        super(key: key);

  @override
  _NeumorphicContainerState createState() => _NeumorphicContainerState();
}

class _NeumorphicContainerState extends State<NeumorphicContainer> {
  bool _isPressed = false;

  void _onPointerDown(PointerDownEvent event) {
    setState(() {
      _isPressed = true;
    });
  }

  void _onPointerUp(PointerUpEvent event) {
    setState(() {
      _isPressed = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = this.widget.color ?? Theme.of(context).backgroundColor;

    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.bevel * 10),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              _isPressed ? color : color.mix(Colors.black54, .1),
              _isPressed ? color.mix(Colors.black54, .05) : color,
              _isPressed ? color.mix(Colors.black54, .05) : color,
              color.mix(Colors.white, _isPressed ? .25 : .5),
            ],
            stops: [
              0.0,
              .066,
              .132,
              0.264,
            ],
          ),
          boxShadow: _isPressed
              ? null
              : [
                  BoxShadow(
                    blurRadius: widget.bevel - (widget.bevel * 0.5),
                    offset: -widget.blurOffset,
                    color: color.mix(Colors.white, .6),
                  ),
                  BoxShadow(
                    blurRadius: widget.bevel - (widget.bevel * 0.5),
                    offset: widget.blurOffset,
                    color: color.mix(Colors.black, .3),
                  )
                ],
        ),
        child: widget.child,
      ),
    );
  }
}

extension ColorUtils on Color {
  Color mix(Color another, double amount) {
    return Color.lerp(this, another, amount);
  }
}
