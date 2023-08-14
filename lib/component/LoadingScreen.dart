import 'package:colorful_circular_progress_indicator/colorful_circular_progress_indicator.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ColorfulCircularProgressIndicator(
          colors: [Colors.blue, Colors.red, Colors.amber, Colors.green],
          strokeWidth: 5,
          indicatorHeight: 40,
          indicatorWidth: 40,
        ),
      ),
    );
  }
}
