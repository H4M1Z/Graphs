import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OccupancyChart extends StatelessWidget {
  final List<Map<String, dynamic>> occupancyData;

  const OccupancyChart({super.key, required this.occupancyData});

  @override
  Widget build(BuildContext context) {
    // Get the currnet time
    final now = DateTime.now();
    final oneHourAgo = now.subtract(const Duration(hours: 1));

    // Filter and prepare chart data for the last hour
    final lastHourData =
        occupancyData
            .where((entry) => DateTime.parse(entry['timestamp']).isAfter(oneHourAgo))
            .map(
              (entry) => _ChartData(
                DateTime.parse(entry['timestamp']),
                entry['value'].toDouble(),
                entry['min_value'].toDouble(),
                entry['max_value'].toDouble(),
              ),
            )
            .toList();

    if (lastHourData.isEmpty || lastHourData.last.time.isBefore(now)) {
      lastHourData.add(_ChartData(now, 0, 0, 0));
    }

    // Calculate 5 evenly spaced labels for the x axsis
    final duration = now.difference(oneHourAgo).inMinutes;
    final interval = (duration / 4).floor();

    return SfCartesianChart(
      backgroundColor: Colors.transparent,
      plotAreaBackgroundColor: Colors.transparent,
      plotAreaBorderWidth: 0,
      margin: EdgeInsets.zero,
      primaryXAxis: DateTimeAxis(
        minimum: oneHourAgo,
        maximum: now,
        intervalType: DateTimeIntervalType.auto,
        interval: 15,
        majorGridLines: const MajorGridLines(width: 0),
        axisLine: const AxisLine(width: 0),
        majorTickLines: const MajorTickLines(size: 0),
        labelStyle: TextStyle(color: Colors.grey[600], fontSize: 12),
        edgeLabelPlacement: EdgeLabelPlacement.shift,
        axisLabelFormatter: (AxisLabelRenderDetails details) {
          // get the date data here
          final date = DateTime.fromMillisecondsSinceEpoch(details.value.toInt());

          // check if it is between the next 15 minutes
          if (date.isAtSameMomentAs(now) || (now.isAfter(date) && now.isBefore(date.add(Duration(minutes: interval))))) {
            return ChartAxisLabel('NOW', const TextStyle(color: Colors.green, fontSize: 10));
          }
          // return the time
          return ChartAxisLabel(DateFormat('h:mm a').format(date), const TextStyle(color: Colors.grey, fontSize: 10));
        },
      ),
      primaryYAxis: NumericAxis(
        plotBands: [
          // Maximum capacity
          PlotBand(start: 8, end: 8, borderColor: Colors.red.withValues(alpha: 0.5), borderWidth: 1.5, dashArray: [3, 5]),
        ],
        minimum: 0,
        maximum: 10,
        interval: 3,
        majorTickLines: const MajorTickLines(size: 0),
        majorGridLines: MajorGridLines(width: 0.8, dashArray: [2, 2], color: Colors.grey.withValues(alpha: 0.3)),
        labelFormat: '{value} ppl',
        labelStyle: TextStyle(fontSize: 10, color: Colors.grey[600]),
        axisLine: const AxisLine(width: 0),
      ),
      series: [
        //Plot range
        RangeAreaSeries<_ChartData, DateTime>(
          dataSource: lastHourData,
          xValueMapper: (_ChartData data, _) => data.time,
          lowValueMapper: (_ChartData data, _) => data.minValue,
          highValueMapper: (_ChartData data, _) => data.maxValue,
          color: Colors.grey.withValues(alpha: 0.3),
        ),
        //Plot data
        LineSeries<_ChartData, DateTime>(
          dataSource: lastHourData,
          xValueMapper: (_ChartData data, _) => data.time,
          yValueMapper: (_ChartData data, _) => data.value,
          color: Colors.black,
          width: 2,
          markerSettings: const MarkerSettings(isVisible: false),
        ),
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.time, this.value, this.minValue, this.maxValue);
  final DateTime time;
  final double value;
  final double minValue;
  final double maxValue;
}
