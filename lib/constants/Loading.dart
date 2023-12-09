// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class Loading extends StatelessWidget {
  final Color? color;
  const Loading({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.fallingDot(
            color: color ?? Colors.blueAccent, size: 60));
  }
}
