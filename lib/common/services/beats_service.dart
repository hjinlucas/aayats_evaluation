import 'dart:convert';
import 'package:aayats_evaluation/common/models/beats.dart';
import 'package:http/http.dart' as http;

//Change api path during production
const String port = "5001"; //change to 5002 if 5001 is being used
const String baseLocalUrlAndroid = "10.0.2.2:$port";
const String baseLocalUrlIos = "localhost:$port";
const String baseUrl = baseLocalUrlAndroid;
Future<List<Beats>?> getAllBeats() async {
  //CHANGE FOR DEVICE
  var url = Uri.http(baseUrl, 'api/beats');
  try {
    var response = await http.get(url);
    List<dynamic> json = jsonDecode(response.body);
    List<Beats>? res = json.map((e) => Beats.fromJson(e)).toList();
    return res;
  } catch (error) {
    // print(error);
    throw error;
  }
}

Future addBeats(Beats newBeats) async {
  var url = Uri.http(baseUrl, 'api/beats/add');
  try {
    await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: newBeats.toJson());
  } catch (error) {
    // print(error);
    throw error;
  }
}
