import '../custom_navigation_drawer.dart';
import 'package:flutter/material.dart';

class CollapsingListTile extends StatefulWidget {
  final String title;
  final IconData icon;
  final AnimationController animationController;
  final bool isSelected;
  bool isExpanded;
  bool isCollapsed;
  final Function onTap;

  CollapsingListTile({
    @required this.title,
    @required this.icon,
    @required this.animationController,
    this.isSelected = false,
    this.onTap,
    this.isExpanded,
    this.isCollapsed,
  });

  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  Animation<double> widthAnimation, sizedBoxAnimation;

  @override
  void initState() {
    super.initState();
    widthAnimation = Tween<double>(begin: 210, end: 50)
        // .animate(widget.animationController);
        .animate(CurvedAnimation(
            parent: widget.animationController, curve: Curves.decelerate));
    sizedBoxAnimation = Tween<double>(begin: 5, end: 0)
        //.animate(widget.animationController);
        .animate(CurvedAnimation(
            parent: widget.animationController, curve: Curves.decelerate));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: widget.isExpanded
              ? BorderRadius.only(
                  topLeft: Radius.circular(6.0), topRight: Radius.circular(6.0))
              : BorderRadius.all(Radius.circular(6.0)),
          color: widget.isSelected
              ? Colors.transparent.withOpacity(0.3)
              : Colors.transparent,
        ),
        width: widthAnimation.value,
        margin: (widthAnimation.value > 50)
            ? EdgeInsets.symmetric(horizontal: 10)
            : EdgeInsets.symmetric(horizontal: 5),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
          mainAxisAlignment: (widthAnimation.value > 50)
              ? MainAxisAlignment.start
              : MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              widget.icon,
              color: widget.isSelected ? selectedColor : Colors.grey[350],
              size: 27.0,
            ),
            SizedBox(width: sizedBoxAnimation.value),
            (widthAnimation.value >= 200)
                ? Text(widget.title,
                    style: widget.isSelected
                        ? listTitleSelectedTextStyle
                        : listTitleDefaultTextStyle)
                : Container()
          ],
        ),
      ),
    );
  }
}
