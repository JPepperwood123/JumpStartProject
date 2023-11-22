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
      currColor = Color.fromRGBO(153, 204, 51, 1);
    } else if (summary[index] >= 50.0) {
      currColor = Color.fromRGBO(253, 219, 0, 1);
    } else if (summary[index] >= 35.0) {
      currColor = Color.fromRGBO(255, 177, 60, 1);
    } else if (summary[index] >= 0.0) {
      currColor = Color.fromRGBO(246, 85, 64, 1);
    } else {
      throw UnimplementedError('No Value');
    }

    // Define positions for dotted lines on the y-axis
    List<LineChartBarData> extraLines = [
      LineChartBarData(
        spots: [
          FlSpot(0, 20),
        ],
        isCurved: false,
        color: Colors.grey,
        dotData: FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
      ),
    ];

    print("pos : ${summary[index]}");
    double arrowPosition = summary[index];

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            Positioned(
              left: 0,
              top: constraints.maxHeight / 3,
              child: RotatedBox(
                quarterTurns: 1,
                child: Text(
                  'RTP (%)',
                  style: TextStyle(
                    color: Color.fromRGBO(38, 49, 56, 1),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    fontFamily: 'Lato',
                  ),
                ),
              ),
            ),
            Positioned(
              // Calculate the position of the arrow based on the highest y value
              top: (110-arrowPosition)/2, // Adjust the top position of the arrow
              left: 310, // Adjust the left position of the arrow
              child: Icon(
                Icons.arrow_upward,
                size: 28,
                color: Colors.black, // Set the color as needed
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 40),
              child: 
              BarChart(
                BarChartData(
                  maxY: 100,
                  minY: 0,
                  titlesData: FlTitlesData(
                    show: true,
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    // leftTitles:
                    //   AxisTitles(sideTitles:
                    //     SideTitles(
                    //         showTitles: true,
                    //         getTitlesWidget: getLeftTitles,
                    //     ),
                    //   )
                  ),
                  barGroups: myBarData.barData
                      .map(
                          (data) => BarChartGroupData(
                            x: 0,
                            barRods: [
                              BarChartRodData(
                                toY: data.y,
                                color: currColor,
                                width: 25,
                                borderRadius: BorderRadius.circular(19),
                              ),
                            ],
                            showingTooltipIndicators: [0], // Show tooltip indicator for the first bar
                          ),
                        )
                      .toList(),
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            '${summary[index]}%',
                            TextStyle(
                              color: currColor, 
                              fontSize: 21,
                              fontFamily: 'Lato',
                              fontWeight: FontWeight.w700),
                              // children: [TextSpan(text: 'hello', style: TextStyle(color: Colors.black))]
                          );
                        },
                      ),
                    ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}

Widget getLeftTitles (double value, TitleMeta meta){
  const style = TextStyle(
    color: Color.fromRGBO(38, 49, 56, 1),
    fontWeight: FontWeight.w400,
    fontSize: 14,
    fontFamily: 'Lato',
    // wordWrap: 'break-word'
  );

  Widget text = Text(value.toString(), style: style);

  // return Flexible(child: text);

 return SideTitleWidget(child: text, axisSide: meta.axisSide);
}