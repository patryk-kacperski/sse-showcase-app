enum Clients {
  simple,
  flutterClientSse;

  String get name {
    switch (this) {
      case Clients.simple:
        return 'Simple';
      case Clients.flutterClientSse:
        return 'flutter_client_sse';
    }
  }
}
