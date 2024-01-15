// To parse this JSON data, do
//
//     final beatsModel = beatsModelFromJson(jsonString);

import 'dart:convert';

BeatsModel beatsModelFromJson(String str) =>
    BeatsModel.fromJson(json.decode(str));

String beatsModelToJson(BeatsModel data) => json.encode(data.toJson());

class BeatsModel {
  int id;
  String imageUrl;
  String heading;
  String numOfLikes;
  String tags;
  String tune;
  String bpm;
  String price;

  BeatsModel({
    required this.id,
    required this.imageUrl,
    required this.heading,
    required this.numOfLikes,
    required this.tags,
    required this.tune,
    required this.bpm,
    required this.price,
  });

  factory BeatsModel.fromJson(Map<String, dynamic> json) => BeatsModel(
        id: json["id"],
        imageUrl: json["imageURL"],
        heading: json["heading"],
        numOfLikes: json["numOfLikes"],
        tags: json["tags"],
        tune: json["tune"],
        bpm: json["bpm"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "imageURL": imageUrl,
        "heading": heading,
        "numOfLikes": numOfLikes,
        "tags": tags,
        "tune": tune,
        "bpm": bpm,
        "price": price,
      };
}
