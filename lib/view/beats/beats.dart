import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../services/beatsService.dart';
import '../../common/widgets.dart';

final beatsService = BeatsService();

class Beats extends StatelessWidget {
  const Beats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<List<dynamic>>(
        future: beatsService.fetchBeats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No beats found"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var beat = snapshot.data![index];
                return beatsListingForm(
                  imageURL: beat['imageUrl'] as String? ?? 'default_image_url',
                  heading: beat['title'] as String? ?? 'No Title',
                  numOfLikes: (beat['likes'] as int? ?? 0).toString(),
                  tags: _formatTags(beat['tags']),
                  tune: beat['key'] as String? ?? 'No Key',
                  bpm: (beat['bpm'] as int? ?? 0).toString(),
                  price: "\$${(beat['price'] as double? ?? 0.0).toStringAsFixed(2)}",
                );
              },
            );
          }
        },
      ),
    );
  }

  String _formatTags(dynamic tags) {
    if (tags is List<dynamic>) {
      return tags.join(', ');
    }
    return '';
  }
}