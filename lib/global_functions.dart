import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';

import 'constants/global_variables.dart';
import 'firebase_options.dart';

getWidth(context) {
  return MediaQuery.of(context).size.width;
}

getHeight(context) {
  return MediaQuery.of(context).size.width;
}

double getFontSize(size, maxWidth, id) {
  return size * maxWidth / (1500 * (textRatios[id] ?? 0.425));
}

double getRelativeHeight(double size, maxWidth) {
  return size * maxWidth / (1500);
}

double getRelSize(double size, BuildContext context) {
  return size * getWidth(context) / (1500);
}
