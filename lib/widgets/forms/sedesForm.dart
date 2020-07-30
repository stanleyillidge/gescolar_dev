import 'package:flutter/material.dart';
import 'package:gescolar_dev/models/sedes.dart';
import 'package:responsive_framework/responsive_framework.dart';

typedef OnDelete();
const List<Condition> blockWidthConstraints = [
  Condition.smallerThan(name: MOBILE, value: BoxConstraints(maxWidth: 451)),
  Condition.largerThan(name: TABLET, value: BoxConstraints(maxWidth: 450)),
  Condition.smallerThan(name: TABLET, value: BoxConstraints(maxWidth: 1001)),
  Condition.largerThan(name: DESKTOP, value: BoxConstraints(maxWidth: 1000)),
  Condition.largerThan(name: "4K", value: BoxConstraints(maxWidth: 1281)),
];

class UserForm extends StatefulWidget {
  final User user;
  final state = _UserFormState();
  final OnDelete onDelete;

  UserForm({Key key, this.user, this.onDelete}) : super(key: key);
  @override
  _UserFormState createState() => state;

  bool isValid() => state.validate();
}

class _UserFormState extends State<UserForm> {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ResponsiveConstraints(
      constraintsWhen: blockWidthConstraints,
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Container(
          width: 400,
          child: Material(
            elevation: 1,
            clipBehavior: Clip.antiAlias,
            borderRadius: BorderRadius.circular(8),
            child: Form(
              key: form,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AppBar(
                    leading: Icon(Icons.verified_user),
                    elevation: 0,
                    title: Text('User Details'),
                    backgroundColor: Theme.of(context).accentColor,
                    centerTitle: true,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: widget.onDelete,
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                    child: TextFormField(
                      initialValue: widget.user.fullName,
                      onSaved: (val) => widget.user.fullName = val,
                      validator: (val) =>
                          val.length > 3 ? null : 'Full name is invalid',
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        hintText: 'Enter your full name',
                        icon: Icon(Icons.person),
                        isDense: true,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                    child: TextFormField(
                      initialValue: widget.user.email,
                      onSaved: (val) => widget.user.email = val,
                      validator: (val) =>
                          val.contains('@') ? null : 'Email is invalid',
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'Enter your email',
                        icon: Icon(Icons.email),
                        isDense: true,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ///form validator
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}
