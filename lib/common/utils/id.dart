import 'dart:math';

String generateRandomHex(int length) {
  Random random = Random();
  return List.generate(length, (_) => random.nextInt(16).toRadixString(16))
      .join();
}
