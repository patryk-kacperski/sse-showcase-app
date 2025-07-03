import 'package:http/http.dart';

const String baseUrl = 'http://localhost:5080';
const String numbersEndpoint = '/numbers';

Request createNumbersRequest() {
  final request = Request('GET', Uri.parse('$baseUrl$numbersEndpoint'));
  request.headers['Accept'] = 'text/event-stream';
  request.headers['Cache-Control'] = 'no-cache';

  return request;
}
