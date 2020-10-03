import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/material.dart';

class Tres extends StatelessWidget {
  const Tres({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingSearchBar.builder(
        itemCount: 100,
        padding: EdgeInsets.only(top: 10.0, left: 80),
        itemBuilder: (BuildContext context, int index) {
          /* return ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 80),
              child: Text(index.toString()),
            ),
          ); */
          return Container();
        },
        trailing: CircleAvatar(
          child: Text("RD"),
        ),
        /* drawer: Drawer(
          child: Container(),
        ), */
        onChanged: (String value) {},
        onTap: () {},
        decoration: InputDecoration.collapsed(
          hintText: "Search...",
        ),
      ),
      /* FloatingSearchBar.builder(
        pinned: true,
        itemCount: 100,
        padding: EdgeInsets.only(top: 10.0, left: 80),
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Padding(
              padding: const EdgeInsets.only(top: 10.0, left: 80),
              child: Text(index.toString()),
            ),
          );
        },
        leading: CircleAvatar(
          child: Text("RD"),
        ),
        endDrawer: Drawer(
          child: Container(),
        ),
        onChanged: (String value) {},
        onTap: () {},
        decoration: InputDecoration.collapsed(
          hintText: "Search...",
        ),
      ), */
    );
  }
}
