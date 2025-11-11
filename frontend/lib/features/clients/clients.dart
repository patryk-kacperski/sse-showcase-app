enum Clients {
  simple,
  flutterClientSse,
  eventflux,
  sseChannel;

  String get name {
    switch (this) {
      case Clients.simple:
        return 'Simple';
      case Clients.flutterClientSse:
        return 'flutter_client_sse';
      case Clients.eventflux:
        return 'eventflux';
      case Clients.sseChannel:
        return 'sse_channel';
    }
  }
}
