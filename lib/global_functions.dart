import 'package:flutter/widgets.dart';

import 'global_variables.dart';

getWidth(context) {
  return MediaQuery.of(context).size.width;
}

getHeight(context) {
  return MediaQuery.of(context).size.width;
}

double getFontSize(size, maxWidth, id) {
  return size * maxWidth / (1500 * (textRatios[id] ?? 0.425));
}

double getRelativeHeight(size, maxWidth) {
  return size * maxWidth / (1500);
}
