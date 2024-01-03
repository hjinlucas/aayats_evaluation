import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class MongoDatabase{
  static connect() async{
    await dotenv.load(fileName: ".env");
    final mongodbUrl = dotenv.env['MONGO_URL'];
    final collection_name = dotenv.env['COLLECTION_NAME'];
    var db = await Db.create(mongodbUrl!);
    await db.open();
    inspect(db);
    var collection = db.collection(collection_name!);
    // await collection.insertOne({
    //   "Username" : "Trial",
    //   "Email" : "trial@gmail.com"
    // });
    final result = await collection.find().toList();

    // await collection.updateMany(where.eq("Username", "Trial"), modify.set("Email", "test123@gmail.com"));

    await db.close();

    var data =  result.map((e) => e as Map<String, dynamic>).toList();

    String jsonString = jsonEncode(data);

  // Get the directory for storing files
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String filePath = '${appDocDir.path}/data.json';

  // Write JSON data to a file
  File jsonFile = File(filePath);
  await jsonFile.writeAsString(jsonString);

  print('Data saved as JSON file: $filePath');
  return filePath;

  }
}