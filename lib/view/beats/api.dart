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
}
