import 'package:flutter/material.dart';
import 'package:travel/core/util/number_convert.dart';

class IconWithNumber extends StatelessWidget {
  final int number;
  final Icon icon;
  const IconWithNumber({Key key, this.icon, this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (number == 0) {
      return icon;
    } else {
      return Container(
        height: 40.0,
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            icon,
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  NumberConvert.convertNumberToString(number),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }
  }
}
