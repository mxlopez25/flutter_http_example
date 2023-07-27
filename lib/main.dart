import 'dart:convert';

import 'package:flutter/material.dart';
import 'components/photo_list.dart';
import 'models/photo.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MaterialApp(home: HomePage()));

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Network Example")),
      // Snapshot is the data that comes from the Future method
      // context is simply the current state of the app and device info.
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if(snapshot.hasError) {
            final errorMessage = snapshot.error?.toString();
            return Center(
              child: Text("Some shit just went down... Error: $errorMessage"),
            );
          } else if (snapshot.hasData) {
            return PhotosList(photos: snapshot.data!);
          } else {
            return const CircularProgressIndicator();
          }
        },
      )
    );
  }
}

// First convert the response into a List<Photo>
List<Photo> parsePhotos(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client
      .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));

  return parsePhotos(response.body);
}


