import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MoneySavedChart extends StatelessWidget {
  const MoneySavedChart({super.key});

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
            labelPlacement: LabelPlacement.betweenTicks,
            labelPosition: ChartDataLabelPosition.outside,
          ),
          primaryYAxis: NumericAxis(
            minimum: 0,
            maximum: 250,
            interval: 50,
            plotBands: [
              PlotBand(start: 175, end: 175, borderWidth: 0.8, borderColor: Colors.red.withValues(alpha: 0.5), dashArray: [4, 8]),
            ],
            axisLabelFormatter: (axisLabelRenderArgs) {
              final value = axisLabelRenderArgs.value.toInt();
              if (value == 200) {
                return ChartAxisLabel('500', const TextStyle(color: Colors.grey, fontSize: 10));
              } else if (value > 200) {
                return ChartAxisLabel('1k+', const TextStyle(color: Colors.grey, fontSize: 10));
              } else if (value == 0) {
                return ChartAxisLabel('10', const TextStyle(color: Colors.grey, fontSize: 10));
              }
              return ChartAxisLabel('$value', const TextStyle(color: Colors.grey, fontSize: 10));
            },
            majorGridLines: MajorGridLines(width: 0.8, color: Colors.grey.withValues(alpha: 0.3), dashArray: [2, 2]),
            axisLine: const AxisLine(width: 0),
            majorTickLines: const MajorTickLines(size: 0),
          ),
          zoomPanBehavior: ZoomPanBehavior(enablePanning: true, enablePinching: true, zoomMode: ZoomMode.xy),
          series: [
            ColumnSeries<ChartData, String>(
              dataSource: [
                ChartData('Sun', 20),
                ChartData('Mon', 20),
                ChartData('Tue', 190),
                ChartData('Wed', 20),
                ChartData('Thu', 120),
                ChartData('Fri', 20),
                ChartData('Sat', 90),
              ],
              xValueMapper: (ChartData data, _) => data.day,
              yValueMapper: (ChartData data, _) => data.value,
              width: 0.5,
              spacing: 0.2,
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
