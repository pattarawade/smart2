import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:connectfirebase/models/note.dart';


class WeightListItem extends StatelessWidget {
  final WeightEntry weightEntry;
  final double weightDifference;

  WeightListItem(this.weightEntry, this.weightDifference);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new Text(
            weightEntry.temp.toString(),
            textScaleFactor: 2.0,
            textAlign: TextAlign.center,
          ),
          new Text(
            "jduh"
          ),
          new Expanded(
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Text(
                  _differenceText(weightDifference),
                  textScaleFactor: 1.6,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _differenceText(double weightDifference) {
    if (weightDifference > 0) {
      return "+" + weightDifference.toStringAsFixed(1);
    } else if (weightDifference < 0) {
      return weightDifference.toStringAsFixed(1);
    } else {
      return "-";
    }
  }
}