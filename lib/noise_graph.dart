import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class NoiseChart extends StatelessWidget {
  const NoiseChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 320,
        height: 200,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: SfCartesianChart(
          backgroundColor: Colors.transparent,
          plotAreaBackgroundColor: Colors.transparent,
          plotAreaBorderWidth: 0,
          margin: EdgeInsets.zero,
          primaryXAxis: NumericAxis(
            majorGridLines: const MajorGridLines(width: 0),
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0),
            labelStyle: TextStyle(color: Colors.grey[600], fontSize: 12),
            minimum: 0,
            maximum: 6,
            interval: 1,
            axisLabelFormatter: (AxisLabelRenderDetails details) {
              const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
              final index = details.value.toInt();
              return ChartAxisLabel(
                index >= 0 && index < days.length ? days[index] : '',
                const TextStyle(color: Colors.grey, fontSize: 12),
              );
            },
          ),
          primaryYAxis: NumericAxis(
            plotBands: [
              PlotBand(isVisible: true, start: 80, end: 80, color: Colors.red, borderColor: Colors.red),
              PlotBand(
                isVisible: true,
                start: 60,
                end: 60,
                color: Colors.red,
                borderColor: Colors.red,
                dashArray: [4, 8],
                borderWidth: 1.5,
              ),
            ],
            minimum: 40,
            maximum: 100,
            interval: 10,
            majorTickLines: const MajorTickLines(size: 0),
            majorGridLines: MajorGridLines(width: 0.8, dashArray: [2, 2], color: Colors.grey.withValues(alpha: 0.3)),
            labelFormat: '{value} dB',
            labelStyle: TextStyle(fontSize: 10, color: Colors.grey[600]),
            axisLine: const AxisLine(width: 0),
          ),
          zoomPanBehavior: ZoomPanBehavior(enablePinching: true, enablePanning: true, zoomMode: ZoomMode.xy),
          series: [
            LineSeries<_ChartData, double>(
              dataSource: [
                _ChartData(0, 48),
                _ChartData(1, 55),
                _ChartData(2, 60),
                _ChartData(3, 68),
                _ChartData(3.5, 78),
                _ChartData(4, 65),
                _ChartData(5, 60),
                _ChartData(6, 58),
              ],
              xValueMapper: (_ChartData data, _) => data.x,
              yValueMapper: (_ChartData data, _) => data.y,
              color: Colors.black,
              width: 2,
              markerSettings: const MarkerSettings(isVisible: false),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);
  final double x;
  final double y;
}
