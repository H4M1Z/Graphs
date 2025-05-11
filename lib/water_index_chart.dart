import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WaterIndexChart extends StatelessWidget {
  const WaterIndexChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 300,
        height: 150,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5, spreadRadius: 2, offset: const Offset(0, 2))],
        ),
        child: SfCartesianChart(
          backgroundColor: Colors.transparent,
          plotAreaBackgroundColor: Colors.transparent,
          plotAreaBorderWidth: 0,
          primaryXAxis: CategoryAxis(
            majorGridLines: const MajorGridLines(width: 0),
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0),
            labelStyle: TextStyle(color: Colors.grey[600], fontSize: 10),
          ),
          primaryYAxis: NumericAxis(
            plotBands: [
              PlotBand(
                color: Colors.grey.withValues(alpha: 0.2),
                start: 65,
                end: 65,
                borderColor: Colors.red,
                borderWidth: 1.5,
                dashArray: [4, 8],
              ),
            ],
            minimum: 0,
            maximum: 100,
            interval: 20,
            majorGridLines: MajorGridLines(width: 0.8, dashArray: [2, 2], color: Colors.grey.withValues(alpha: 0.3)),
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0),
            labelStyle: TextStyle(color: Colors.grey[600], fontSize: 10),
          ),
          zoomPanBehavior: ZoomPanBehavior(enablePanning: true, enablePinching: true, zoomMode: ZoomMode.xy),
          series: [
            ColumnSeries<ChartData, String>(
              dataSource: [
                ChartData('Sun', 10),
                ChartData('Mon', 10),
                ChartData('Tue', 70),
                ChartData('Wed', 10),
                ChartData('Thu', 45),
                ChartData('Fri', 10),
                ChartData('Sat', 30),
              ],
              xValueMapper: (ChartData data, _) => data.day,
              yValueMapper: (ChartData data, _) => data.value,
              width: 0.5, // Adjust bar width
              spacing: 0.2, // Space between bars
              color: Colors.grey[400],
              borderRadius: BorderRadius.only(topLeft: Radius.circular(3), topRight: Radius.circular(3)),
            ),
          ],
          tooltipBehavior: TooltipBehavior(
            enable: true,
            format: 'point.y',
            color: Colors.black87,
            textStyle: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.day, this.value);
  final String day;
  final double value;
}
