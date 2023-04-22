import 'package:flutter/material.dart';

import '../../theme/text_style.dart';

class BulletList extends StatelessWidget {
  final List<String> items;

  BulletList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((item) => Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 4.0),
                    child: Text(
                      '• ',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: small(),
                    ),
                  ),
                ],
              ))
          .toList(),
    );
  }
}
