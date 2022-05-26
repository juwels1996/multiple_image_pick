import 'dart:async';

import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Asset> images = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> pickImages() async {
    List<Asset> resultList = [];

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 100,
        enableCamera: true,
        selectedAssets: images,
        materialOptions: MaterialOptions(
          actionBarTitle: "FlutterCorner.com",
        ),
      );
    } on Exception catch (e) {
      print(e);
    }

    setState(() {
      images = resultList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Multi Image Picker - FlutterCorner.com'),
        ),
        body: Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Pick images"),
              onPressed: pickImages,
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 1,
                children: List.generate(images.length, (index) {
                  Asset asset = images[index];
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: AssetThumb(
                      quality: 100,
                      asset: asset,
                      width: 150,
                      height: 120,
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
