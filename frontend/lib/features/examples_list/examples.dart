enum Examples {
  standardHttp,
  standardHttp2;

  String get name {
    switch (this) {
      case Examples.standardHttp:
        return 'Standard HTTP';
      case Examples.standardHttp2:
        return 'Standard HTTP + SseService';
    }
  }
}
