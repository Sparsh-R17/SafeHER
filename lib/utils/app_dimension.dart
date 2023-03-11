import 'package:flutter/material.dart';

verticalSpacing(double givenHeight) {
  return SizedBox(
    height: givenHeight,
  );
}

horizontalSpacing(double givenWidth) {
  return SizedBox(
    width: givenWidth,
  );
}

mixedSpacing(double givenHeight, double givenWidth) {
  return SizedBox(
    height: givenHeight,
    width: givenWidth,
  );
}
