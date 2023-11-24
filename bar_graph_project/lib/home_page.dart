import 'package:bar_graph_project/bar_graph/RTPBarGraph.dart';
import 'package:bar_graph_project/bar_graph/bar_graph.dart';
import 'package:bar_graph_project/bar_graph/individual_bar.dart';
import 'package:flutter/material.dart';
import 'dart:async';

/*

Input: Take predetermined list

Output: Display in nice bar graph

*/

class HomePage extends StatelessWidget {
  final List<double> summary;
  final int selectedIndex;
  final Function(double) onSliderChanged;
  final VoidCallback onPausePlay;

  HomePage({
    required this.summary,
    required this.selectedIndex,
    required this.onSliderChanged,
    required this.onPausePlay,
  });

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
                  mainAxisAlignment: MainAxisAlignment.start,
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
                          icon: Icon(Icons.help_outline),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                )
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(Icons.more_horiz_outlined),
                      onPressed: () {
                        // Handle the three dots icon tap
                      },
                    ),
                  ],
                ),
              ),

              Positioned(
                top: 160,
                bottom: 10,
                left: 0,
                right: 400,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Icon(Icons.pause),
                      onPressed: onPausePlay,
                    )
                  ],
                ),
              ),

              Positioned(
                top: 190,
                bottom: 0,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Slider(
                        value: selectedIndex.toDouble(),
                        min: 0,
                        max: (summary.length - 1).toDouble(),
                        onChanged: onSliderChanged,
                      ),
                    ),
                    
                    // ElevatedButton(
                    //   onPressed: onPausePlay,
                    // ),
                  ],
                ),
              ),
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
