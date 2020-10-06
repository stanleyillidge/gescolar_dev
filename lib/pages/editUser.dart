import "package:flutter/material.dart";

class EditUser extends StatefulWidget {
  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('POPUP_MENU_BUTTON'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //our code.
            SizedBox(height: 600)
          ],
        ),
      ),
    );
  }
}
