import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PriceChart extends StatelessWidget {
  const PriceChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true),
          titlesData: const FlTitlesData(show: true), // Afficher les axes
          borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey.withValues(alpha: 0.2))),

          // --- L'INTERACTIVITÉ EST ICI ---
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (touchedSpot) => Colors.deepPurpleAccent,
              getTooltipItems: (List<LineBarSpot> touchedSpots) {
                return touchedSpots.map((spot) {
                  return LineTooltipItem(
                    '${spot.y} €', // Affiche le prix au survol
                    const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  );
                }).toList();
              },
            ),
          ),

          lineBarsData: [
            LineChartBarData(
              spots: const [
                FlSpot(0, 10), // (x: temps/index, y: prix)
                FlSpot(1, 15),
                FlSpot(2, 12),
                FlSpot(3, 20),
              ],
              isCurved: true, // Courbe lisse
              color: Colors.deepPurple,
              barWidth: 4,
              belowBarData: BarAreaData(show: true, color: Colors.deepPurple.withValues(alpha: 0.2)),
              dotData: const FlDotData(show: true), // Points sur la courbe
            ),
          ],
        ),
      ),
    );
  }
}