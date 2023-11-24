import 'package:bar_graph_project/bar_graph/RTPBarGraph.dart';
import 'package:bar_graph_project/bar_graph/bar_graph.dart';
import 'package:bar_graph_project/bar_graph/individual_bar.dart';
import 'package:flutter/material.dart';
import 'dart:async';

/*

Input: Take predetermined list

Output: DIsplay in nice bar graph

*/

class HomePage extends StatelessWidget {
  final List<double> summary; // [currentAmount]
  final int selectedIndex;

  const HomePage({
    Key? key,
    required this.summary,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 200,
          child: Stack(
            children: [
              MyBarGraph(
                key: UniqueKey(),
                summary: summary,
                index: selectedIndex,
              ),

              Positioned(
                top: 0,
                left: 75,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'RTP',
                      style: TextStyle(
                        color: Color.fromRGBO(38, 49, 56, 1),
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        fontFamily: 'Lato',
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.more_horiz_outlined),
                          onPressed: () {
                            // Handle the three dots icon tap
                          },
                        ),
                      ],
                    ),
                  ],
                )
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 215,
                child:IconButton(
                  icon: Icon(Icons.help_outline),
                  onPressed: () {
                    // Handle the question mark icon tap
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   final List<IndividualBar> summary;
//   final int selectedIndex;

//   const HomePage({
//     Key? key,
//     required this.summary,
//     required this.selectedIndex,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     print("hello 1");

//     return Scaffold(
//       body: Center(
//         child: SizedBox(
//           height: 200,
//           child: SubscriberChart(
//             data: summary,
//             index: selectedIndex,
//           ),
//         ),
//       ),
//     );
//   }
// }