import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movies_list/model/movie.dart';

class MovieCardWidget extends StatelessWidget {
  MovieCardWidget({
    Key? key,
    required this.movie,
    required this.index,
  }) : super(key: key);

  final Movie movie;
  final int index;

  @override
  Widget build(BuildContext context) {
    /// Pick colors from the accent colors based on index
    final time = DateFormat.yMMMd().format(movie.createdTime);
    final minHeight = 200.0;
    return Card(
      color: Colors.black54,
      child: Container(
        constraints: BoxConstraints(minHeight: minHeight),
        padding: EdgeInsets.fromLTRB(4.0, 1.0, 4.0, 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 3),
            Container(
              // padding: ,
              width: 200,
              height: 200,
              decoration: BoxDecoration(color: Colors.red[200]),
              child: movie.img != ''
                  ? imageFromBase64String(movie.img)
                  : Container(
                      decoration: BoxDecoration(color: Colors.red[200]),
                      height: 200,
                      child: Icon(
                        Icons.camera_alt,
                        color: Colors.grey[800],
                      ),
                    ),
            ),
            SizedBox(height: 4),
            Center(
              child: Text(
                time,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                ),
              ),
            ),
            SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  // child: Center(
                  child: Center(
                    child: Text(
                      movie.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // )
              ],
            ),
            SizedBox(height: 2),
          ],
        ),
      ),
    );
  }

  /// To return different height for different widgets
  double getMinHeight(int index) {
    switch (index % 4) {
      case 0:
        return 100;
      case 1:
        return 150;
      case 2:
        return 150;
      case 3:
        return 100;
      default:
        return 100;
    }
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
}
