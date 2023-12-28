import 'dart:ffi';

class Beats {
  final String title;
  final UnsignedInt likes;
  final List<String>? artists;
  final String key;
  final UnsignedInt bpm;
  final double price;
  final String imageUrl;
  final String producerId;

  const Beats(
      {required this.title,
      required this.likes,
      this.artists,
      required this.key,
      required this.bpm,
      required this.price,
      required this.imageUrl,
      required this.producerId});

  factory Beats.fromJson(Map<String, dynamic> json) {
    return Beats(
        title: json["title"] as String,
        likes: json["likes"] as UnsignedInt,
        artists: json["artists"] as List<String>?,
        key: json["key"] as String,
        bpm: json["bpm"] as UnsignedInt,
        price: json["price"] as double,
        imageUrl: json["imageUrl"] as String,
        producerId: json["producerId"] as String);
  }
}
