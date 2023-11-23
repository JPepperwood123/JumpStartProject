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
            
            // Vertical lines on the right
            Positioned(
                right: 10,
                top: 10,
                bottom: 10,
                child:
                  Container(
                    height: 2.0, // Adjust the height as needed
                    width: 20.0, // Adjust the width as needed
                    color: Colors.red,
                  ),
            ),

            Stack(
              children:[
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 40),
                  child: 
                  BarChart(
                    BarChartData(
                      // extraLinesData: ExtraLinesData(
                      //   horizontalLines: [
                      //     HorizontalLine(
                      //       y: 85,
                      //       color: Color.fromRGBO(239, 255, 208, 1),
                      //       strokeWidth: 52,
                      //     ),
                      //   ],
                      // ),
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
                          // Customize vertical grid lines if needed
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
                    bottom: 75,
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
                          Color.fromRGBO(239, 255, 208, 1).withOpacity(0.7),
                          Color.fromRGBO(239, 255, 208, 1).withOpacity(0.7),
                          Colors.transparent, // Adjust the opacity as needed
                          Colors.transparent,
                        ],
                       stops: [0.0, 0.5, 0.5, 0.1],
                      ),
                    ),
                  ),
                ),
              ]
            ),
          ],
        );
      }
    );

    // return LayoutBuilder(
    //   builder: (context, constraints) {
    //     return Padding(
    //       padding: const EdgeInsets.only(left: 20, right: 40),
    //       child: Row(
    //         children: [
    //           Expanded(
    //             child: Stack(
    //               children: [
    //                 BarChart(
    //                   BarChartData(
    //                     maxY: 100,
    //                     minY: 0,
    //                     titlesData: FlTitlesData(
    //                       show: true,
    //                       topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    //                       bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    //                       rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
    //                     ),
    //                     barGroups: myBarData.barData
    //                         .map(
    //                           (data) => BarChartGroupData(
    //                             x: 0,
    //                             barRods: [
    //                               BarChartRodData(
    //                                 toY: data.y,
    //                                 color: currColor,
    //                                 width: 25,
    //                                 borderRadius: BorderRadius.circular(19),
    //                               ),
    //                             ],
    //                             showingTooltipIndicators: [0],
    //                           ),
    //                         )
    //                         .toList(),
    //                     barTouchData: BarTouchData(
    //                       touchTooltipData: BarTouchTooltipData(
    //                         tooltipBgColor: Colors.transparent,
    //                         getTooltipItem: (group, groupIndex, rod, rodIndex) {
    //                           return BarTooltipItem(
    //                             '${summary[index]}%',
    //                             TextStyle(
    //                               color: currColor,
    //                               fontSize: 21,
    //                               fontFamily: 'Lato',
    //                               fontWeight: FontWeight.w700,
    //                             ),
    //                           );
    //                         },
    //                       ),
    //                     ),
    //                     gridData: FlGridData(
    //                       show: true,
    //                       horizontalInterval: 20.0,
    //                       getDrawingHorizontalLine: (value) {
    //                         if (value == 0 || value == 100) {
    //                           return FlLine(color: Colors.black, strokeWidth: 2.0, dashArray: [5]);
    //                         } else if (value % 20 == 0) {
    //                           return FlLine(
    //                               color: Color.fromRGBO(166, 187, 199, 1), strokeWidth: 0.5, dashArray: [3]);
    //                         } else {
    //                           return FlLine(color: Colors.transparent);
    //                         }
    //                       },
    //                       getDrawingVerticalLine: (value) {
    //                         return FlLine(color: Colors.transparent);
    //                       },
    //                     ),
    //                   ),
    //                 ),
    //                 Padding(
    //                   padding: const EdgeInsets.only(
    //                     left: 65,
    //                     right: 42,
    //                     bottom: 75,
    //                   ),
    //                   child: Container(
    //                     height: double.infinity,
    //                     width: double.infinity,
    //                     decoration: BoxDecoration(
    //                       gradient: LinearGradient(
    //                         begin: Alignment.topCenter,
    //                         end: Alignment.bottomCenter,
    //                         colors: [
    //                           Color.fromRGBO(239, 255, 208, 1).withOpacity(0.7),
    //                           Color.fromRGBO(239, 255, 208, 1).withOpacity(0.7),
    //                           Colors.transparent,
    //                           Colors.transparent,
    //                         ],
    //                         stops: [0.0, 0.5, 0.5, 0.1],
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //           // Vertical lines on the right
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Container(width: 10, color: Colors.black),
    //               Container(width: 2, color: Colors.blue),
    //               Container(width: 2, color: Colors.green),
    //               Container(width: 2, color: Colors.grey),
    //             ],
    //           ),
    //         ],
    //       ),
    //     );
    //   },
    // );
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