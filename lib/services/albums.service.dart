import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/albums.model.dart';

// # Question
//
// Display the album data from this URL - https://jsonplaceholder.typicode.com/albums - in a list view.
// * Assume each object in the array is always fully formed
//
// How to implement is open-ended, with the "optimal solution" being something you would consider ready for a pull request.
//
// Priority should be given to completing "a solution" that shows UI. If you complete an initial solution with extra time, I will prompt you to make changes in the direction of what I consider an optimal solution.

class Albums {
  Future<List<AlbumsModel>> getAlbums() async {
    try {
      var url = Uri.parse('https://jsonplaceholder.typicode.com/albums');
      final response = await http.get(url);

      final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

      List<AlbumsModel> albums = parsed.map<AlbumsModel>((json) => AlbumsModel.fromJson(json)).toList();

      return albums;
    } catch (error) {
      throw (error);
    }
  }
}
