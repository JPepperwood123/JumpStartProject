import 'package:bar_graph_project/bar_graph/individual_bar.dart';
import 'package:flutter/material.dart';
// import 'home_page.dart';

import 'package:bar_graph_project/bar_graph/RTPBarGraph.dart';
import 'package:bar_graph_project/bar_graph/bar_graph.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
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

// bool isPlaying = true;
// int selectedIndex = 0;

// typedef void StateUpdaterCallback(bool isPlaying, int selectedIndex);

class _DelayedRebuilder extends StatefulWidget {
  @override
  State<_DelayedRebuilder> createState() => _DelayedRebuilderState();
}

class _DelayedRebuilderState extends State<_DelayedRebuilder> {
  // GlobalKey<_DelayedRebuilderState> _globalKey = GlobalKey<_DelayedRebuilderState>();
  // StateUpdaterCallback? stateUpdaterCallback;

  int selectedIndex = 0;
  List<double> rtpDataSet = [84.4, 62.7, 2.5, 42.4, 90.1];
  bool isPlaying = true;

  // List<double> rtpDataSet = [84.4, 62.7, 2.5, 42.4, 90.1];
  // List<IndividualBar> indivSumm = [IndividualBar(x: 0, y: 84.4), IndividualBar(x: 1, y: 2.5), IndividualBar(x: 2, y: 42.4)];

  // @override
  // void initState() {
  //   super.initState();
  //   _startTimer();
  //   // widget.setGlobalKey(_globalKey);
  //   // widget.setCallback((isPlaying, selectedIndex) {
  //   //   setState(() {
  //   //     this.isPlaying = isPlaying;
  //   //     this.selectedIndex = selectedIndex;
  //   //   });
  //   // });
  // }

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();

  //   Future.delayed(Duration.zero, () {
  //     setCallback((isPlaying, selectedIndex) {
  //       if (mounted) {
  //         setState(() {
  //           isPlaying = isPlaying;
  //           selectedIndex = selectedIndex;
  //         });
  //       }
  //     });
  //     setGlobalKey(_globalKey);
  //   });

  //   _startTimer();
  // }

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

  // void _startTimer() {
  //   if (isPlaying) {
  //     Future.delayed(const Duration(seconds: 10), () {
  //       setState(() {
  //         selectedIndex = (selectedIndex + 1) % rtpDataSet.length;
  //       });
  //       _startTimer(); // Schedule the next rebuild
  //     });
  //   }
  // }

  // void togglePlayPause() {
  //   print("reached here");
  //   isPlaying = !isPlaying;

  //   if (isPlaying) {
  //     print("also reached here");
  //     _startTimer();
  //   }
  // }

  // void onSliderChanged(double value) {
  //   print("also reached here with ${value}");
  //   selectedIndex = value.toInt();
  // }

  // void setCallback(StateUpdaterCallback callback) {
  //   stateUpdaterCallback = callback;
  // }

  // void setGlobalKey(GlobalKey<_DelayedRebuilderState> key) {
  //   _globalKey = key;
  // }

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

/*

Input: Take predetermined list

Output: DIsplay in nice bar graph

*/

class HomePage extends StatelessWidget {
  // final List<double> summary; // [currentAmount]
  // final int selectedIndex;

  // const HomePage({
  //   Key? key,
  //   required this.summary,
  //   required this.selectedIndex,
  // }) : super(key: key);

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
              ),

              Positioned(
                bottom: 16,
                left: 16,
                right: 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(Icons.pause),
                      // onPressed: () {
                      //   // Handle play/pause button tap
                      //   _DelayedRebuilderState().togglePlayPause();
                      // },
                      onPressed: onPausePlay,
                    ),
                    Expanded(
                      child: Slider(
                        value: selectedIndex.toDouble(),
                        min: 0,
                        max: (summary.length - 1).toDouble(),
                        // onChanged: (value) {
                        //   // Handle slider value change
                        //   _DelayedRebuilderState().onSliderChanged(value);
                        // },
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