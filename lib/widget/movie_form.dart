import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MovieFormWidget extends StatefulWidget {
  final String img;
  final String? title;
  final String? director;
  final ValueChanged<String> onChangedImg;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  const MovieFormWidget({
    Key? key,
    this.img = '',
    this.title = '',
    this.director = '',
    required this.onChangedImg,
    required this.onChangedTitle,
    required this.onChangedDescription,
  }) : super(key: key);

  @override
  _MovieFormWidgetState createState() => _MovieFormWidgetState();
}

class _MovieFormWidgetState extends State<MovieFormWidget> {
  var _image;
  late String img = widget.img;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 200,
                height: 300,
                decoration: BoxDecoration(color: Colors.red[200]),
                child: img != ''
                    ? imageFromBase64String(img)
                    : Container(
                        decoration: BoxDecoration(color: Colors.red[200]),
                        width: 200,
                        height: 300,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    pickImageFromGallery();
                  },
                  child: Text('upload poster'),
                ),
              ),
              buildTitle(),
              SizedBox(height: 8),
              buildDescription(),
              SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: widget.title,
        style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: TextStyle(color: Colors.white70),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: widget.onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: widget.director,
        style: TextStyle(color: Colors.white60, fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Director Name',
          hintStyle: TextStyle(color: Colors.white60),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: widget.onChangedDescription,
      );

  pickImageFromGallery() {
    ImagePicker.pickImage(source: ImageSource.gallery).then((imgFile) {
      String imgString = base64String(imgFile.readAsBytesSync());
      setState(() {
        img = imgString;
        widget.onChangedImg(img);
      });
    });
  }

  static Image imageFromBase64String(String base64String) {
    return Image.memory(
      base64Decode(base64String),
      fit: BoxFit.fill,
    );
  }

  static Uint8List dataFromBase64String(String base64String) {
    return base64Decode(base64String);
  }

  static String base64String(Uint8List data) {
    return base64Encode(data);
  }
}
