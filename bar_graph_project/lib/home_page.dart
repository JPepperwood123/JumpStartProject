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
          child: MyBarGraph(
            key: UniqueKey(),
            summary: summary,
            index: selectedIndex,
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