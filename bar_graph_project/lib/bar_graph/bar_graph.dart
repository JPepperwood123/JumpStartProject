import 'package:bar_graph_project/bar_graph/bar_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyBarGraph extends StatelessWidget {
  final List summary; // [currentAmount]
  final int index;

  const MyBarGraph({ 
    super.key,
    required this.summary,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    // initilaize bar data
    BarData myBarData = BarData(
      currentAmount: summary[index]
    );

    print("index : ${index}");

    myBarData.initializeBarData();

    Color currColor;
    if (summary[index] >= 75.0) {
      currColor = Color.fromRGBO(239, 255, 208, 1);
    } else if (summary[index] >= 50.0) {
      currColor = Color.fromRGBO(253, 219, 0, 1);
    } else if (summary[index] >= 35.0) {
      currColor = Color.fromRGBO(255, 177, 60, 1);
    } else if (summary[index] >= 0.0) {
      currColor = Color.fromRGBO(246, 85, 64, 1);
    } else {
      throw UnimplementedError('No Value');
    }

    return BarChart(
      BarChartData(
        maxY: 100,
        minY: 0,
        barGroups: myBarData.barData
            .map(
                (data) => BarChartGroupData(
                  x: 500,
                  barRods: [
                    BarChartRodData(
                      toY: data.y,
                      color: currColor,
                      width: 25,
                      borderRadius: BorderRadius.circular(19),
                    ),
                  ],
                ),
            )
            .toList(),
      ),
    );
  }
}
