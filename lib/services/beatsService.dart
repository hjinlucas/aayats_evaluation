import 'package:http/http.dart' as http;
import 'dart:convert';


class BeatsService {
  final String baseUrl = 'http://10.0.0.73:5001/api/beats';

  Future<List<dynamic>> fetchBeats() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load beats');
    }
  }

  // Future<http.Response> createBeat(Map<String, dynamic> newBeatData) async {
  //   final response = await http.post(
  //     Uri.parse(baseUrl),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(newBeatData),
  //   );

  //   return response;
  // }
}
