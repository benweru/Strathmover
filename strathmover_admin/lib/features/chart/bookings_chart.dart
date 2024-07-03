import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BookingsBarChart extends StatelessWidget {
  final Map<String, int> routeCounts;

  const BookingsBarChart({required this.routeCounts, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barGroups = routeCounts.entries.map((entry) {
      final index = routeCounts.keys.toList().indexOf(entry.key);
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: entry.value.toDouble(),
            color: Colors.blue,
          ),
        ],
      );
    }).toList();

    return BarChart(
      BarChartData(
        barGroups: barGroups,
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                return Text(value.toInt().toString());
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                return Text(routeCounts.keys.toList()[index]);
              },
            ),
          ),
        ),
      ),
    );
  }
}
