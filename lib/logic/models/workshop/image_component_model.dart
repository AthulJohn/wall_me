import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageComponent {
  String url;
  double width;
  double height;
  BoxFit fit;
  double overlayIntensity;
  Color overlayColor;

  ImageComponent({
    this.url = "https://picsum.photos/200",
    this.width = 200,
    this.height = 200,
    this.fit = BoxFit.cover,
    this.overlayIntensity = 0,
    this.overlayColor = Colors.black,
  });
}
