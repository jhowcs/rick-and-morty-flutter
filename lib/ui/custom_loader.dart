import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final double width;
  final double height;

  const CustomLoader({this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: width,
          height: height,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
          ),
        ),
      ),
    );
  }
}
