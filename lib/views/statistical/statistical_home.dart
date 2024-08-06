import 'package:expenditure_management/views/statistical/pie_chart.dart';
import 'package:expenditure_management/views/statistical/statistical_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticalHomeScreen extends StatefulWidget {
  const StatisticalHomeScreen({super.key});

  @override
  State<StatisticalHomeScreen> createState() => _StatisticalHomeScreenState();
}

class _StatisticalHomeScreenState extends State<StatisticalHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [StatisticalScreen(), PieChartScreen()],
      ),
    );
  }
}
