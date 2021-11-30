import 'package:flutter/material.dart';

class GridItemWidget extends StatelessWidget {
  final String title;
  final String value;
  const GridItemWidget({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white54),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Text(
              title,
              style: TextStyle(fontSize: 10),
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                value,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
