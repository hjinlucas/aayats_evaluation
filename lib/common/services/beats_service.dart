import 'dart:convert';
import 'package:aayats_evaluation/common/models/beats.dart';

final String baseUrlAndroid = "" 

Future<List<Beats>?> getAllBeats() async {
  var url = Uri.https(baseUrlAndroid, 'api/beats');
  print(url);
  try {
    // var response = await http.get(url);
    // print(response);
    // Map<String, dynamic> json = jsonDecode(response.body);
    // print(json);
    return [];
  } catch (error) {
    print(error);
    throw error;
  }
}
