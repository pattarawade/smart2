import 'dart:ffi';
import 'dart:typed_data';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:image_picker/image_picker.dart';

class Images extends StatefulWidget {
  @override
  _ImagesState createState() => new _ImagesState();
}

class _ImagesState extends State<Images> {
  Widget makeImagesGrid() {
    return GridView.builder(
        itemCount: 20,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        // ignore: missing_return
        itemBuilder: (context, index) {
          return ImagesGriditem(index+1);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: makeImagesGrid(),
    );
  }
}

class ImagesGriditem extends StatefulWidget {
  int _index;

  ImagesGriditem(int index) {
    this._index = index;
  }
  @override
  _ImagesGriditemState createState() => new _ImagesGriditemState();
}

class _ImagesGriditemState extends State<ImagesGriditem> {

  Uint8List imageFile;
  StorageReference photosReference = FirebaseStorage.instance.ref().child("photo");

  getImage() {
    int MAX_SIZE = 7 * 1024 * 1024;

    photosReference.child("image_${widget._index}.jpg")
        .getData(MAX_SIZE)
        .then((data) {
      this.setState((){
        imageFile = data;});
    }).catchError((error) {});
  }

  Widget deciderGridTileWidget() {
    if (imageFile == null) {
      return Center(child: Text('No Data'));
    } else {
      return Image.memory(imageFile,fit: BoxFit.cover,);
    }
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return GridTile(child: deciderGridTileWidget());
  }
}
