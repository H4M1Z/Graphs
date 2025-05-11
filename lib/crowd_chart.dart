import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CrowdChart extends StatelessWidget {
  const CrowdChart({super.key});

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
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 5, spreadRadius: 2, offset: const Offset(0, 2))],
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
            labelPlacement: LabelPlacement.betweenTicks,
            labelPosition: ChartDataLabelPosition.outside,
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 10,
            interval: 2,
            majorGridLines: MajorGridLines(width: 0.8, dashArray: [2, 2], color: Colors.grey.withValues(alpha: 0.3)),
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0),
            labelStyle: TextStyle(color: Colors.grey[600], fontSize: 10),
          ),
          zoomPanBehavior: ZoomPanBehavior(enablePanning: true, enablePinching: true, zoomMode: ZoomMode.xy),
          series: [
            ColumnSeries<ChartData, String>(
              dataSource: [
                ChartData('Sun', 1),
                ChartData('Mon', 1),
                ChartData('Tue', 7),
                ChartData('Wed', 1),
                ChartData('Thu', 5),
                ChartData('Fri', 1),
                ChartData('Sat', 3),
              ],
              xValueMapper: (ChartData data, _) => data.day,
              yValueMapper: (ChartData data, _) => data.value,
              width: 0.5, // Bar Width
              spacing: 0.2, // Bar Spacing
              color: Colors.grey[400], // Bar Color
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
