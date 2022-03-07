import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/albums.view_model.dart';

class AlbumsList extends StatelessWidget {
  const AlbumsList();

  @override
  Widget build(BuildContext context) {
    final albums = Provider.of<AlbumsViewModel>(context).albums;

    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * .9,
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  itemCount: albums.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      height: 50,
                      color: Colors.orange,
                      child: Center(child: Text('Entry ${albums[index].title}')),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(),
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
