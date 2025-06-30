enum Examples {
  standardHttp;

  String get name {
    switch (this) {
      case Examples.standardHttp:
        return 'Standard HTTP';
    }
  }
}
