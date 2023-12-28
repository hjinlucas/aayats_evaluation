import 'dart:convert';
import 'package:aayats_evaluation/common/models/beats.dart';
import 'package:http/http.dart' as http;

//TODO:Change api path during production
const String port = "5001";
const String baseLocalUrlAndroid = "10.0.2.2:$port";
const String baseLocalUrlIos = "localhost:$port";

Future<List<Beats>?> getAllBeats() async {
  //CHANGE FOR DEVICE
  var url = Uri.http(baseLocalUrlAndroid, 'api/beats');
  try {
    var response = await http.get(url);
    print(response);
    List<dynamic> json = jsonDecode(response.body);
    print(json[0].title);
    return [];
  } catch (error) {
    print(error);
    throw error;
  }
}
