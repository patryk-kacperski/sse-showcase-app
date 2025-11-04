import 'package:http/http.dart';

const String baseUrl = 'http://localhost:5080';
const String numbersEndpoint = '/numbers';
const String textStreamEndpoint = '/text-stream';
const String shapesAndColorsEndpoint = '/shapes-and-colors';

Request createNumbersRequest() =>
    Request('GET', Uri.parse('$baseUrl$numbersEndpoint'))
      ..headers['Accept'] = 'text/event-stream'
      ..headers['Cache-Control'] = 'no-cache';

Request createTextStreamRequest() =>
    Request('GET', Uri.parse('$baseUrl$textStreamEndpoint'))
      ..headers['Accept'] = 'text/event-stream'
      ..headers['Cache-Control'] = 'no-cache';

Request createShapesAndColorsRequest() =>
    Request('GET', Uri.parse('$baseUrl$shapesAndColorsEndpoint'))
      ..headers['Accept'] = 'text/event-stream'
      ..headers['Cache-Control'] = 'no-cache';
