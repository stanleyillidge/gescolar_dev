import 'package:flutter/material.dart';

enum CurveType2 { concave, convex, none }

/* class ClayContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final Color parentColor;
  final Color surfaceColor;
  final double spread;
  final Widget child;
  final double borderRadius;
  final BorderRadius customBorderRadius;
  final CurveType2 CurveType2;
  final int depth;
  final bool emboss;

  ClayContainer(
      {this.child,
      this.height,
      this.width,
      this.color,
      this.surfaceColor,
      this.parentColor,
      this.spread,
      this.borderRadius,
      this.customBorderRadius,
      this.CurveType2,
      this.depth,
      this.emboss});

  Color _getAdjustColor(Color baseColor, amount) {
    Map colors = {
      "red": baseColor.red,
      "green": baseColor.green,
      "blue": baseColor.blue
    };
    colors = colors.map((key, value) {
      if (value + amount < 0) return MapEntry(key, 0);
      if (value + amount > 255) return MapEntry(key, 255);
      return MapEntry(key, value + amount);
    });
    return Color.fromRGBO(colors["red"], colors["green"], colors["blue"], 1);
  }

  List<Color> _getFlatGradients(baseColor, depth) {
    return [
      baseColor,
      baseColor,
    ];
  }

  List<Color> _getConcaveGradients(baseColor, depth) {
    return [
      _getAdjustColor(baseColor, 0 - depth),
      _getAdjustColor(baseColor, depth),
    ];
  }

  List<Color> _getConvexGradients(baseColor, depth) {
    return [
      _getAdjustColor(baseColor, depth),
      _getAdjustColor(baseColor, 0 - depth),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final double heightValue = height == null ? null : height;
    final double widthValue = width == null ? null : width;
    final int depthValue = depth == null ? 20 : depth;
    Color colorValue = color == null ? Color(0xFFf0f0f0) : color;
    final Color parentColorValue =
        parentColor == null ? colorValue : parentColor;
    final Color surfaceColorValue =
        surfaceColor == null ? colorValue : surfaceColor;
    final double spreadValue = spread == null ? 6 : spread;
    final bool embossValue = emboss == null ? false : emboss;
    BorderRadius borderRadiusValue = borderRadius == null
        ? BorderRadius.zero
        : BorderRadius.circular(borderRadius);

    if (customBorderRadius != null) {
      borderRadiusValue = customBorderRadius;
    }
    final CurveType2 CurveType2Value =
        CurveType2 == null ? CurveType2.none : CurveType2;

    List<BoxShadow> shadowList = [
      BoxShadow(
          color: _getAdjustColor(
              parentColorValue, embossValue ? 0 - depthValue : depthValue),
          offset: Offset(0 - spreadValue, 0 - spreadValue),
          blurRadius: spreadValue),
      BoxShadow(
          color: _getAdjustColor(
              parentColorValue, embossValue ? depthValue : 0 - depthValue),
          offset: Offset(spreadValue, spreadValue),
          blurRadius: spreadValue)
    ];

    if (embossValue) shadowList = shadowList.reversed.toList();
    if (embossValue)
      colorValue = _getAdjustColor(colorValue, 0 - depthValue ~/ 2);
    if (surfaceColor != null) colorValue = surfaceColorValue;

    List<Color> gradientColors;
    switch (CurveType2Value) {
      case CurveType2.concave:
        gradientColors = _getConcaveGradients(colorValue, depthValue);
        break;
      case CurveType2.convex:
        gradientColors = _getConvexGradients(colorValue, depthValue);
        break;
      case CurveType2.none:
        gradientColors = _getFlatGradients(colorValue, depthValue);
        break;
    }

    return Container(
      height: heightValue,
      width: widthValue,
      child: child,
      decoration: BoxDecoration(
          borderRadius: borderRadiusValue,
          color: colorValue,
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors),
          boxShadow: shadowList),
    );
  }
} */

class ClayContainer extends StatefulWidget {
  // ClayContainer({Key key}) : super(key: key);
  final double height;
  final double width;
  final Color color;
  final Color parentColor;
  final Color surfaceColor;
  final double spread;
  final Widget child;
  final double borderRadius;
  final BorderRadius customBorderRadius;
  final CurveType2 curveType;
  final int depth;
  final bool emboss;
  final Function onTap;
  final String imagen;
  final double padding;

  ClayContainer({
    Key key,
    this.child,
    this.height,
    this.width,
    this.color,
    this.surfaceColor,
    this.parentColor,
    this.spread,
    this.borderRadius,
    this.customBorderRadius,
    this.curveType,
    this.depth,
    this.emboss,
    this.onTap,
    this.imagen,
    this.padding,
  }) : super(key: key);

  Color _getAdjustColor(Color baseColor, amount) {
    Map colors = {
      "red": baseColor.red,
      "green": baseColor.green,
      "blue": baseColor.blue
    };
    colors = colors.map((key, value) {
      if (value + amount < 0) return MapEntry(key, 0);
      if (value + amount > 255) return MapEntry(key, 255);
      return MapEntry(key, value + amount);
    });
    return Color.fromRGBO(colors["red"], colors["green"], colors["blue"], 1);
  }

  List<Color> _getFlatGradients(baseColor, depth) {
    return [
      baseColor,
      baseColor,
    ];
  }

  List<Color> _getConcaveGradients(baseColor, depth) {
    return [
      _getAdjustColor(baseColor, 0 - depth),
      _getAdjustColor(baseColor, depth),
    ];
  }

  List<Color> _getConvexGradients(baseColor, depth) {
    return [
      _getAdjustColor(baseColor, depth),
      _getAdjustColor(baseColor, 0 - depth),
    ];
  }

  @override
  _ClayContainerState createState() => _ClayContainerState();
}

class _ClayContainerState extends State<ClayContainer> {
  Color _getAdjustColor(Color baseColor, amount) {
    Map colors = {
      "red": baseColor.red,
      "green": baseColor.green,
      "blue": baseColor.blue
    };
    colors = colors.map((key, value) {
      if (value + amount < 0) return MapEntry(key, 0);
      if (value + amount > 255) return MapEntry(key, 255);
      return MapEntry(key, value + amount);
    });
    return Color.fromRGBO(colors["red"], colors["green"], colors["blue"], 1);
  }

  List<Color> _getFlatGradients(baseColor, depth) {
    return [
      baseColor,
      baseColor,
    ];
  }

  List<Color> _getConcaveGradients(baseColor, depth) {
    return [
      _getAdjustColor(baseColor, 0 - depth),
      _getAdjustColor(baseColor, depth),
    ];
  }

  List<Color> _getConvexGradients(baseColor, depth) {
    return [
      _getAdjustColor(baseColor, depth),
      _getAdjustColor(baseColor, 0 - depth),
    ];
  }

  // ------------------------
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
    // --------------------------------
    final double heightValue = widget.height == null ? null : widget.height;
    final double widthValue = widget.width == null ? null : widget.width;
    final int depthValue = widget.depth == null ? 20 : widget.depth;
    Color colorValue = widget.color == null ? Color(0xFFf0f0f0) : widget.color;
    final Color parentColorValue =
        widget.parentColor == null ? colorValue : widget.parentColor;
    final Color surfaceColorValue =
        widget.surfaceColor == null ? colorValue : widget.surfaceColor;
    final double spreadValue = widget.spread == null ? 6 : widget.spread;
    final bool embossValue = widget.emboss == null ? false : widget.emboss;
    BorderRadius borderRadiusValue = widget.borderRadius == null
        ? BorderRadius.zero
        : BorderRadius.circular(widget.borderRadius);

    if (widget.customBorderRadius != null) {
      borderRadiusValue = widget.customBorderRadius;
    }
    final CurveType2 CurveType2Value =
        widget.curveType == null ? CurveType2.none : widget.curveType;

    List<BoxShadow> shadowList = [
      BoxShadow(
          color: _getAdjustColor(
              parentColorValue, embossValue ? 0 - depthValue : depthValue),
          offset: Offset(0 - spreadValue, 0 - spreadValue),
          blurRadius: spreadValue),
      BoxShadow(
          color: _getAdjustColor(
              parentColorValue, embossValue ? depthValue : 0 - depthValue),
          offset: Offset(spreadValue, spreadValue),
          blurRadius: spreadValue)
    ];

    if (embossValue) shadowList = shadowList.reversed.toList();
    if (embossValue)
      colorValue = _getAdjustColor(colorValue, 0 - depthValue ~/ 2);
    if (widget.surfaceColor != null) colorValue = surfaceColorValue;

    List<Color> gradientColors;
    switch (CurveType2Value) {
      case CurveType2.concave:
        gradientColors = _getConcaveGradients(colorValue, depthValue);
        break;
      case CurveType2.convex:
        gradientColors = _getConvexGradients(colorValue, depthValue);
        break;
      case CurveType2.none:
        gradientColors = _getFlatGradients(colorValue, depthValue);
        break;
    }
    // --------------------------------

    return Listener(
      onPointerDown: _onPointerDown,
      onPointerUp: _onPointerUp,
      child: Container(
        padding: (widget.imagen != null)
            ? EdgeInsets.all(2.0)
            : (widget.padding == 0)
                ? EdgeInsets.all(0)
                : EdgeInsets.only(
                    top: widget.padding - (widget.padding * 0.4),
                    bottom: widget.padding,
                    left: widget.padding + (widget.padding * 0.2),
                    right: widget.padding + (widget.padding * 0.2)),
        height: heightValue,
        width: widthValue,
        child: widget.child,
        decoration: BoxDecoration(
            borderRadius: borderRadiusValue,
            color: colorValue,
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: gradientColors),
            boxShadow: _isPressed ? null : shadowList),
      ),
    );
  }
}
