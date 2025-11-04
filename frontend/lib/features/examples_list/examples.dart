enum Examples {
  standardHttp,
  standardHttp2,
  loremIpsum,
  shapesAndColors;

  String get name {
    switch (this) {
      case Examples.standardHttp:
        return 'Standard HTTP';
      case Examples.standardHttp2:
        return 'Standard HTTP + SseService';
      case Examples.loremIpsum:
        return 'Lorem Ipsum Text Stream';
      case Examples.shapesAndColors:
        return 'Shapes and Colors';
    }
  }
}
