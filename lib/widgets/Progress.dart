import 'package:flutter/material.dart';

// 中间线型加载效果
// 中间线型加载效果
Widget centerProgress(
    {double width = 25.0, double height = 25.0, String type = 'circular'}) {
  return Center(
    child: Container(
      width: width,
      height: height,
      child: type == 'linear'
          ? LinearProgressIndicator()
          : CircularProgressIndicator(),
    ),
  );
}
