extension BoolParsing on String {
  bool parseBool() {
    return this.toLowerCase() ==
        'true'; //(this.toLowerCase() == 'true') ? true : false;
  }
}

extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }
  // ···
}
