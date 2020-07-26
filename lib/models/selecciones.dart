class Selected {
  String value;
  bool check;

  Selected({this.value, this.check});

  Map toJson() => {
        'value': value,
        'check': check,
      };
}
