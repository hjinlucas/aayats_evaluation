import 'dart:convert';
import 'package:http/http.dart' as http;

class BeatsApi {
  static const String baseUrl = 'http://localhost:5001/api/beats';

  static Future<List<Map<String, dynamic>>> getBeats() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      // Successful API call
      final List<dynamic> data = json.decode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      // Handle errors
      throw Exception('Failed to load beats');
    }
  }

  static Future<void> uploadBeat(Map<String, dynamic> beatData) async {
    final response = await http.post(
      Uri.parse(baseUrl + '/create'),
      body: json.encode(beatData),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      // Successful upload, you may want to refresh the beats list
      // Call the getBeats method or update the UI as needed
      print("hello Successful upload, you're in api.dart file");
    } else {
      throw Exception('Failed to upload beat');
    }
  }

}
