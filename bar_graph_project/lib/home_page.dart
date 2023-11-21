import 'package:bar_graph_project/bar_graph/bar_graph.dart';
import 'package:flutter/material.dart';
import 'dart:async';

/*

Input: Take predetermined list

Output: DIsplay in nice bar graph

*/

// class HomePage extends StatefulWidget {
//   // const HomePage({super.key});
//   final List<double> summary; // [currentAmount]
//   final int selectedIndex;

//   const HomePage({
//     Key? key,
//     required this.summary,
//     required this.selectedIndex,
//   }) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<double> summary = [
//     84.40,
//     2.50,
//     42.42,
//     90.10
//   ];

//   var selectedIndex = 0;

//   late Timer timer;

//   @override
//   void initState() {
//     super.initState();

//     // Start the timer when the widget is initialized
//     timer = Timer.periodic(Duration(seconds: 10), (Timer t) {
//       setState(() {
//         // Increment selectedIndex and reset to 0 if it exceeds the length
//         selectedIndex = (selectedIndex + 1) % summary.length;
//       });

//       // If all elements in the summary have been displayed, cancel the timer
//       if (selectedIndex == 3) {
//         print("hello");
//         t.cancel();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     // Cancel the timer when the widget is disposed to avoid memory leaks
//     timer.cancel();
//     super.dispose();
//   }
   
//   @override
//   Widget build(BuildContext context) {
//     print("Selected Index: $selectedIndex");

//     return Scaffold(
//       body: Center(
//         child: SizedBox( 
//           height: 200,
//           child: MyBarGraph(
//             key: UniqueKey(),
//             summary: summary,
//             index: selectedIndex,
//           ),
//         ),
//       )
//     );
//   }
// }

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