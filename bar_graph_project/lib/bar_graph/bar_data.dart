import 'package:bar_graph_project/bar_graph/individual_bar.dart';

class BarData {
  final double currentAmount;

  BarData({
    required this.currentAmount 
  });

  List<IndividualBar> barData = [];

  // initialize bar data
  void initializeBarData() {
    barData = [
      IndividualBar(x: 0, y: currentAmount)
    ];
  }
}
