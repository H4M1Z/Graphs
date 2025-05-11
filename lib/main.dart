import 'package:flutter/material.dart';
import 'package:hands_test/crowd_chart.dart';
import 'package:hands_test/energy_chart.dart';
import 'package:hands_test/money_saved_chart.dart';
import 'package:hands_test/motion_chart.dart';
import 'package:hands_test/noise_graph.dart';
import 'package:hands_test/occupancy_graphs.dart';
import 'package:hands_test/water_index_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 24),
                NoiseChart(),
                SizedBox(height: 50),
                MotionChart(),
                SizedBox(height: 50),
                OccupancyChart(),
                SizedBox(height: 50),
                CrowdChart(),
                SizedBox(height: 50),
                // Security Chart same as crowd Chart
                CrowdChart(),
                SizedBox(height: 50),
                MoldChart(),
                SizedBox(height: 50),
                WaterIndexChart(),
                SizedBox(height: 50),
                MoneySavedChart(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
