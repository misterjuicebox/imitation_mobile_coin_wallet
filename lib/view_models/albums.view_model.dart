import 'package:flutter/cupertino.dart';

import '../models/albums.model.dart';
import '../services/albums.service.dart';

class AlbumsViewModel with ChangeNotifier {
  Future<void> fetchAlbums() async {
    List<AlbumsModel> albums = await Albums().getAlbums();
    setAlbums(albums);
  }

  List<AlbumsModel> _albums = [];

  List<AlbumsModel> get albums => _albums;

  setAlbums(List<AlbumsModel> albums) {
    _albums = albums;
    notifyListeners();
  }
}
