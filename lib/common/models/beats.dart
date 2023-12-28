class Beats {
  final String title;
  final int likes;
  final List<dynamic> artists;
  final String key;
  final int bpm;
  final String price;
  final double priceRaw;
  final String imageUrl;
  final String producerId;

  const Beats(
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
        priceRaw: json["priceRaw"] as double,
        imageUrl: json["imageUrl"] as String,
        producerId: json["producerId"] as String);
  }
}
