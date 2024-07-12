import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BookingsChart extends StatelessWidget {
  final Map<int, int> data;
  final String view;

  const BookingsChart({Key? key, required this.data, required this.view}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: LineChart(
        LineChartData(
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  if (value % 1 == 0) {
                    return Text(
                      value.toInt().toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index < 0 || index >= data.keys.length) {
                    return const SizedBox.shrink();
                  }
                  final key = data.keys.toList()[index];
                  return Text(
                    view == 'Week' ? 'W$key' : (view == 'Month' ? 'M$key' : '$key'),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: data.entries
                  .toList()
                  .asMap()
                  .entries
                  .map((entry) {
                    final xValue = entry.key.toDouble();
                    final yValue = entry.value.value.toDouble();
                    return FlSpot(xValue, yValue);
                  })
                  .toList(),
              isCurved: true,
              color: Colors.blue,
              barWidth: 2,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    Colors.blue.withOpacity(0.3),
                    Colors.blue.withOpacity(0.0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
          minY: 0,
          maxY: (data.values.isNotEmpty)
              ? data.values.map((e) => e.toDouble()).reduce((a, b) => a > b ? a : b) + 1
              : 1,
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              tooltipPadding: const EdgeInsets.all(8.0),
              tooltipRoundedRadius: 8.0,
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((touchedSpot) {
                  final index = touchedSpot.x.toInt();
                  if (index < 0 || index >= data.keys.length) {
                    return null;
                  }
                  final key = data.keys.toList()[index];
                  final yValue = touchedSpot.y.toDouble();
                  return LineTooltipItem(
                    '${view == 'Week' ? 'Week' : (view == 'Month' ? 'Month' : 'Year')} $key: $yValue',
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      backgroundColor: Colors.blueAccent,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}
