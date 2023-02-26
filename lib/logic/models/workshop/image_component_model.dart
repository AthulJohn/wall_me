import 'package:flutter/material.dart';

class ImageComponent {
  String url;
  String mimeType;
  double width;
  double height;
  BoxFit fit;
  double overlayIntensity;
  Color overlayColor;

  ImageComponent({
    this.url = "https://picsum.photos/200",
    this.mimeType = "image/jpeg",
    this.width = 200,
    this.height = 200,
    this.fit = BoxFit.cover,
    this.overlayIntensity = 0,
    this.overlayColor = Colors.black,
  });

  ImageComponent copyWith({
    String? url,
    double? width,
    double? height,
    BoxFit? fit,
    double? overlayIntensity,
    Color? overlayColor,
    String? mimeType,
  }) {
    return ImageComponent(
      url: url ?? this.url,
      width: width ?? this.width,
      height: height ?? this.height,
      fit: fit ?? this.fit,
      overlayIntensity: overlayIntensity ?? this.overlayIntensity,
      overlayColor: overlayColor ?? this.overlayColor,
      mimeType: mimeType ?? this.mimeType,
    );
  }
}
