import 'package:flutter/material.dart';
import 'package:gescolar_dev/widgets/sta_search_bar/search_bar.dart';

class Dos extends StatelessWidget {
  const Dos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 75),
      child: SearchBar(),
    );
  }
}
