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
    Color textColor;
    Color greenShade = Color.fromRGBO(239, 255, 208, 1).withOpacity(0.7);

    if (summary[index] >= 75.0) {
      currColor = Color.fromRGBO(153, 204, 51, 1);
      textColor = Color.fromRGBO(96, 128, 32, 1);
      greenShade = Colors.transparent;

    } else if (summary[index] >= 50.0) {
      currColor = Color.fromRGBO(253, 219, 0, 1);
      textColor = Color.fromRGBO(137, 118, 0, 1);
    } else if (summary[index] >= 35.0) {
      currColor = Color.fromRGBO(255, 177, 60, 1);
      textColor = Color.fromRGBO(163, 82, 0, 1);
    } else if (summary[index] >= 0.0) {
      currColor = Color.fromRGBO(246, 85, 64, 1);
      textColor = Color.fromRGBO(160, 24, 5, 1);
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
                color: Colors.black,
              ),
            ),

            Stack(
              children:[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 40, top: 30, bottom: 0),
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
                                color: textColor, 
                                fontSize: 21,
                                fontFamily: 'Lato',
                                fontWeight: FontWeight.w700),
                                // children: [TextSpan(text: 'hello', style: TextStyle(color: Colors.black))]
                            );
                          },
                        ),
                      ),
                      gridData: FlGridData(
                        show: true, // Whether to show grid lines
                        horizontalInterval: 20.0, // Interval between horizontal grid lines
                        getDrawingHorizontalLine: (value) {
                          if (value == 0) {
                            // Primary horizontal grid lines (Y=0 and Y=100)
                            return FlLine(color: Colors.black, strokeWidth: 2.0, dashArray: [5]);
                          } else if (value % 20 == 0) {
                            // Dotted lines at Y=20, Y=40, Y=60, etc.
                            return FlLine(color: Color.fromRGBO(166, 187, 199, 1), strokeWidth: 0.5, dashArray: [3]);
                          } else {
                            // Other horizontal grid lines
                            return FlLine(color: Colors.transparent);
                          }
                        },
                        getDrawingVerticalLine: (value) {
                          return FlLine(color: Colors.transparent);
                        },
                      ),
                    ),
                  ),
                ),

                

                Padding(
                  padding: const EdgeInsets.only(
                    left: 65, 
                    right: 42, 
                    bottom: 68,
                    top: 30
                  ),
                  child: 
                  // Shaded area between 80 and 100
                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          greenShade,
                          greenShade,
                          Colors.transparent,
                          Colors.transparent,
                        ],
                       stops: [0.0, 0.5, 0.5, 0.1],
                      ),
                    ),
                  ),
                ),
              ]
            ),

            // Vertical lines on the right
            Positioned(
                right: 41,
                top: 148,
                bottom: 1,
                child:
                  Container(
                    height: 0, 
                    width: 6.0,
                    color: Color.fromRGBO(246, 85, 64, 1),
                  ),
            ),
            Positioned(
                right: 41,
                top: 115,
                bottom: 52,
                child:
                  Container(
                    height: 0,
                    width: 6.0, 
                    color: Color.fromRGBO(255, 177, 60, 1),
                  ),
            ),
            Positioned(
                right: 41,
                top: 80,
                bottom: 85,
                child:
                  Container(
                    height: 0,
                    width: 6.0, 
                    color: Color.fromRGBO(253, 219, 0, 1), 
                  ),
            ),
            Positioned(
                right: 41,
                top: 30,
                bottom: 120,
                child:
                  Container(
                    height: 0,
                    width: 6.0,
                    color: Color.fromRGBO(153, 204, 51, 1),
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
