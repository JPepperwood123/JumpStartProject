import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bar_graph_project/home_page.dart';
import 'package:bar_graph_project/main.dart';
import 'package:bar_graph_project/bar_graph/bar_graph.dart';

void main() {
  testWidgets('MyBarGraph renders correctly', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: MyBarGraph(
          summary: [75.0, 50.0, 25.0],
          index: 0,
        ),
      ),
    );

    // Verify that the widget is rendered correctly.
    expect(find.byType(MyBarGraph), findsOneWidget);

    // Check if the text 'RTP (%)' is present.
    expect(find.text('RTP (%)'), findsOneWidget);

    // Check if the arrow icon is present.
    expect(find.byIcon(Icons.arrow_upward), findsOneWidget);

    // Check if the gradient container is present.
    expect(find.byType(LinearGradient), findsOneWidget);

    // Example: Check if specific vertical lines are present.
    expect(find.byWidgetPredicate(
      (widget) =>
          widget is Container &&
          widget.color == Color.fromRGBO(246, 85, 64, 1),
    ), findsNWidgets(1));

    await tester.tap(find.byType(MyBarGraph));
    await tester.pump();
  });

  testWidgets('MyBarGraph color test', (WidgetTester tester) async {
    // Helper function to create the MyBarGraph widget with a specific value.
    Widget buildMyBarGraph(double value) {
      return MaterialApp(
        home: MyBarGraph(
          summary: [value],
          index: 0,
        ),
      );
    }

    // Check color for value in the range [75, 100]
    await tester.pumpWidget(buildMyBarGraph(80.0));
    expect(find.byType(MyBarGraph), findsOneWidget);
    expect(find.byWidgetPredicate(
      (widget) =>
          widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).color == Color.fromRGBO(153, 204, 51, 1),
    ), findsNWidgets(1));

    // Check color for value in the range [50, 74.99]
    await tester.pumpWidget(buildMyBarGraph(60.0));
    expect(find.byType(MyBarGraph), findsOneWidget);
    expect(find.byWidgetPredicate(
      (widget) =>
          widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).color == Color.fromRGBO(253, 219, 0, 1),
    ), findsNWidgets(1));

    // Check color for value in the range [35, 49.99]
    await tester.pumpWidget(buildMyBarGraph(40.0));
    expect(find.byType(MyBarGraph), findsOneWidget);
    expect(find.byWidgetPredicate(
      (widget) =>
          widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).color == Color.fromRGBO(255, 177, 60, 1),
    ), findsNWidgets(1));

    // Check color for value in the range [0, 34.99]
    await tester.pumpWidget(buildMyBarGraph(20.0));
    expect(find.byType(MyBarGraph), findsOneWidget);
    expect(find.byWidgetPredicate(
      (widget) =>
          widget is Container &&
          widget.decoration is BoxDecoration &&
          (widget.decoration as BoxDecoration).color == Color.fromRGBO(246, 85, 64, 1),
    ), findsNWidgets(1));
  });

  testWidgets('HomePage slider test', (WidgetTester tester) async {
    // Initial values
    final List<double> summary = [50.0, 60.0, 70.0];
    int selectedIndex = 0;
    double sliderValue = 0.0;

    // Function to handle slider changes
    void onSliderChanged(double value) {
      sliderValue = value;
    }

    // Build the widget and pump the initial frame.
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(
          summary: summary,
          selectedIndex: selectedIndex,
          onSliderChanged: onSliderChanged,
          onPausePlay: () {}, // Mock function for pause/play
        ),
      ),
    );

    // Check if the Slider widget is present.
    expect(find.byType(Slider), findsOneWidget);

    // Move the slider to a different position.
    await tester.drag(find.byType(Slider), const Offset(100.0, 0.0));
    await tester.pump();

    // Verify that the onSliderChanged function is called and updates the slider value.
    expect(sliderValue, equals(1.0));

    // You can add more tests based on your specific slider behavior and constraints.
  });
}
