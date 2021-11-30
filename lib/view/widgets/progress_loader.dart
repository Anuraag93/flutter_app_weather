import 'package:flutter/material.dart';

class ProgressLoader extends StatelessWidget {
  final String message;
  const ProgressLoader({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // CircularProgressIndicator(),
          LinearProgressIndicator(),
          SizedBox(height: 5),
          Text(message),
        ],
      ),
    );
  }
}
