import 'package:flutter/material.dart';

class Beats_Model {
  final String imageURL;
  final String heading;
  final String numOfLikes;
  final String tags;
  final String tune;
  final String bpm;
  final String price;

  Beats_Model(this.imageURL, this.heading, this.numOfLikes, this.tags, this.tune, this.bpm, this.price);

  factory Beats_Model.fromJson(Map<String, dynamic> json) {
    return Beats_Model(
        json['imageURL'],
        json['heading'],
        json['numOfLikes'],
        json['tags'],
        json['tune'],
        json['bpm'],
        json['price'],
    );
  }
}