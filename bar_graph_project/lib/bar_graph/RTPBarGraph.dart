import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:bar_graph_project/bar_graph/individual_bar.dart';


// class BarChartRodStackDecorator extends charts.BarRendererDecorator<String> {
//   final double width;
//   final BorderRadius borderRadius;

//   BarChartRodStackDecorator({required this.width, required this.borderRadius});

//   @override
//   void decorateBar(
//     charts.SeriesDatum<String> datum,
//     charts.BarRendererDetails<String> details,
//     int index,
//     List<charts.SeriesDatum<String>> series,
//   ) {
//     super.decorateBar(datum, details, index, series);

//     details.barWidth = width;
//     details.fill = details.fill?.change(
//       radius: borderRadius.topLeft.x,
//       topLeftRadius: borderRadius.topLeft,
//       topRightRadius: borderRadius.topRight,
//       bottomLeftRadius: borderRadius.bottomLeft,
//       bottomRightRadius: borderRadius.bottomRight,
//     );
//   }
// }

class SubscriberChart extends StatelessWidget {
  final List<IndividualBar> data;
  final int index;

  SubscriberChart({required this.data, required this.index});

  @override
  Widget build(BuildContext context) {
    List<IndividualBar> temp = [];
    temp.add(data[index]);

    List<charts.Series<IndividualBar, String>> seriesList = [
      charts.Series(
        id: 'Sales',
        data: temp,
        domainFn: (IndividualBar series, _) => series.x.toString(),
        measureFn: (IndividualBar series, _) => series.y,
        // colorFn: (IndividualBar series, _) => charts.Color.red,
        // seriesRendererFn: (charts.Series<IndividualBar, String> series, _) {
        //   return charts.BarRenderer<String>(
        //     // Customize the appearance of the bars
        //     barRendererDecorator: charts.BarLabelDecorator<String>(),
        //     barGroupingType: charts.BarGroupingType.stacked,
        //     barRendererDecorator: charts.BarLabelDecorator<String>(),
        //     barWidth: 25,
        //     cornerStrategy: const charts.ConstCornerStrategy(30),
        //   );
        // },
      ),
    ];

    print("hello 2");

    return charts.BarChart(
      seriesList,
      animate: true,
      vertical: true,
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(
          desiredTickCount: 7,
        ),
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 14,
            color: charts.MaterialPalette.black,
          ),
          lineStyle: charts.LineStyleSpec(
            color: charts.MaterialPalette.gray.shade400,
          ),
        ),
      ),
      domainAxis: charts.OrdinalAxisSpec(
        renderSpec: charts.SmallTickRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 14,
            color: charts.MaterialPalette.black,
          ),
          lineStyle: charts.LineStyleSpec(
            color: charts.MaterialPalette.gray.shade400,
          ),
        ),
      ),
      barRendererDecorator: charts.BarLabelDecorator<String>(),
      // defaultRenderer: charts.BarRendererConfig(
      //    barRendererDecorator: BarChartRodStackDecorator(
      //     width: 25,
      //     borderRadius: BorderRadius.circular(19),
      //   ),
      // ),
      behaviors: [
        charts.RangeAnnotation([
          charts.RangeAnnotationSegment(
            0,
            80,
            charts.RangeAnnotationAxisType.measure,
            startLabel: '',
            endLabel: '',
            color: charts.MaterialPalette.white,
          ),
          charts.RangeAnnotationSegment(
            80,
            100,
            charts.RangeAnnotationAxisType.measure,
            startLabel: '',
            endLabel: '',
            color: charts.MaterialPalette.green.shadeDefault,
          ),
        ]),
        // charts.LineAnnotation([
        //   charts.LineAnnotationSegment(
        //     100,
        //     charts.RangeAnnotationAxisType.measure,
        //     startLabel: '',
        //     endLabel: '',
        //     color: charts.MaterialPalette.red.shadeDefault,
        //   ),
        // ]),
        // charts.LinePointHighlighter(
        //   symbolRenderer: charts.CircleSymbolRenderer(),
        // ),
      ],
    );
  }
}
