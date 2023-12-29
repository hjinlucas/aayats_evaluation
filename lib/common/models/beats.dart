import 'dart:convert';

class Beats {
  String title;
  int likes;
  List<String> artists;
  String key;
  int bpm;
  String price;
  double priceRaw;
  String imageUrl;
  String producerId;

  Beats(
      {required this.title,
      required this.likes,
      required this.artists,
      required this.key,
      required this.bpm,
      required this.price,
      required this.priceRaw,
      required this.imageUrl,
      required this.producerId});

  factory Beats.fromJson(Map<String, dynamic> json) {
    //convert to from list dynamic to list string, and filter null types
    List<String> revisedArtists =
        json["artists"].map((e) => e?.toString()).whereType<String>().toList();
    return Beats(
        title: json["title"] as String,
        likes: json["likes"] as int,
        artists: revisedArtists,
        key: json["key"] as String,
        bpm: json["bpm"] as int,
        price: json["price"] as String,
        priceRaw: json["priceRaw"].toDouble(),
        imageUrl: json["imageUrl"] as String,
        producerId: json["producerId"] as String);
  }

  String toJson() => jsonEncode({
        'title': title,
        'likes': likes,
        'artists': artists,
        'key': key,
        'bpm': bpm,
        'price': price,
        'priceRaw': priceRaw,
        'imageUrl': imageUrl,
        'producerId': producerId
      });
}
