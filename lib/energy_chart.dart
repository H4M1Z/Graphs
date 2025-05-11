import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MoldChart extends StatelessWidget {
  MoldChart({super.key});

  final List<ChartData> chartData = [
    ChartData('Sun', 1.8),
    ChartData('Mon', 2.2),
    ChartData('Tue', 2.1),
    ChartData('Wed', 3.4),
    ChartData('Thu', 4.0),
    ChartData('Fri', 3.0),
    ChartData('Sat', 2.1),
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 170,
        // padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5, spreadRadius: 2, offset: const Offset(0, 2))],
        ),
        child: SfCartesianChart(
          backgroundColor: Colors.transparent,
          plotAreaBackgroundColor: Colors.transparent,
          plotAreaBorderWidth: 0,

          primaryXAxis: CategoryAxis(
            majorGridLines: MajorGridLines(width: 0), // No vertical grid
            axisLine: AxisLine(width: 0), // No bottom line
            majorTickLines: MajorTickLines(size: 0), // No ticks
            labelStyle: TextStyle(color: Colors.grey[600], fontSize: 10),
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 6,
            interval: 1,
            majorGridLines: const MajorGridLines(width: 0),
            axisLabelFormatter: (AxisLabelRenderDetails details) {
              if (details.value.toInt() == 6) {
                return ChartAxisLabel('', null);
              }
              return ChartAxisLabel(details.value.toInt().toString(), null);
            },
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0),
            labelStyle: TextStyle(color: Colors.grey[600]),
            plotBands: <PlotBand>[
              _plotBand(0, 'No Risk', Colors.green),
              _plotBand(1, 'Low Risk', Colors.orange),
              _plotBand(3, 'Medium Risk', Colors.red),
              _plotBand(5, 'High Risk', Colors.redAccent),
            ],
          ),
          zoomPanBehavior: ZoomPanBehavior(enablePinching: true, enablePanning: true, zoomMode: ZoomMode.xy),
          series: [
            // Main black line
            SplineSeries<ChartData, String>(
              dataSource: chartData,
              xValueMapper: (ChartData data, _) => data.day,
              yValueMapper: (ChartData data, _) => data.value,
              color: Colors.black,
              width: 2,
              markerSettings: const MarkerSettings(isVisible: false),
            ),
          ],
        ),
      ),
    );
  }

  PlotBand _plotBand(double value, String label, Color color) {
    return PlotBand(
      isVisible: true,
      start: value,
      verticalTextAlignment: TextAnchor.end,
      end: value,
      text: label,
      textStyle: TextStyle(color: color, fontSize: 10),
      borderWidth: 1,
      borderColor: color,
      dashArray: [2, 2],
      horizontalTextAlignment: TextAnchor.start,
    );
  }
}

class ChartData {
  final String day;
  final double value;

  ChartData(this.day, this.value);
}
