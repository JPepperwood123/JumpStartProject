import 'package:bar_graph_project/bar_graph/individual_bar.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

import 'package:bar_graph_project/bar_graph/RTPBarGraph.dart';
import 'package:bar_graph_project/bar_graph/bar_graph.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of the application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (BuildContext context) {
          return _DelayedRebuilder();
        },
      ),
    );
  }
}

class _DelayedRebuilder extends StatefulWidget {
  @override
  State<_DelayedRebuilder> createState() => _DelayedRebuilderState();
}

class _DelayedRebuilderState extends State<_DelayedRebuilder> {
  int selectedIndex = 0;
  List<double> rtpDataSet = [84.4, 62.7, 2.5, 42.4, 90.1];
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 10), () {
      print("this works");
      if (isPlaying) {
        setState(() {
          selectedIndex = (selectedIndex + 1) % rtpDataSet.length;
        });
        _startTimer(); // Schedule the next rebuild
      }

      // if (selectedIndex < rtpDataSet.length) {
      //   _startTimer();
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          builder: (BuildContext context) {
            // return HomePage(
            //   summary: rtpDataSet,
            //   // summary: indivSumm,
            //   selectedIndex: selectedIndex,
            // );
            return HomePage(
              summary: rtpDataSet,
              selectedIndex: selectedIndex,
              onSliderChanged: (value) {
                setState(() {
                  print("reached here");
                  selectedIndex = (value * rtpDataSet.length).round() % rtpDataSet.length;
                });
              },
              onPausePlay: () {
                setState(() {
                  isPlaying = !isPlaying;
                });
              },
            );
          },
        );
      },
    );
  }
}

//
// TRY THIS: Try running your application with "flutter run". You'll see
// the application has a purple toolbar. Then, without quitting the app,
// try changing the seedColor in the colorScheme below to Colors.green
// and then invoke "hot reload" (save your changes or press the "hot
// reload" button in a Flutter-supported IDE, or press "r" if you used
// the command line to start the app).
//
// Notice that the counter didn't reset back to zero; the application
// state is not lost during the reload. To reset the state, use hot
// restart instead.
//
// This works for code too, not just values: Most code changes can be
// tested with just a hot reload.
