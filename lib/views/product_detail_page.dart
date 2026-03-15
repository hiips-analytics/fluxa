import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'comparison_page.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> priceHistory = [
      {"date": DateTime(2024, 1, 15), "price": 1200.0},
      {"date": DateTime(2024, 1, 28), "price": 1150.0},
      {"date": DateTime(2024, 2, 05), "price": 1300.0},
      {"date": DateTime(2024, 2, 12), "price": 1100.0},
      {"date": DateTime(2024, 2, 25), "price": 1150.0},
      {"date": DateTime(2024, 3, 02), "price": 1050.0},
      {"date": DateTime(2024, 3, 10), "price": 1100.0},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Détails du produit",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFFC90E),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.compare_arrows),
            tooltip: "Comparer les prix",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ComparisonPage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child:
                    const Icon(Icons.shopping_bag, size: 100, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Huile de Palme 1L",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Vendu par : Dovv, Bastos",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            const Text(
              "1 100 FCFA",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
            ),
            const SizedBox(height: 30),
            const Text(
              "Historique des 7 dernières variations",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildPriceChart(priceHistory),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: () => _showThresholdDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC90E),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                icon: const Icon(Icons.notifications_active_outlined,
                    color: Colors.white),
                label: const Text(
                  "Suivre et définir une alerte",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceChart(List<Map<String, dynamic>> data) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: true, drawVerticalLine: false),
          titlesData: FlTitlesData(
            topTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles:
                const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  int idx = value.toInt();
                  if (idx >= 0 && idx < data.length) {
                    return SideTitleWidget(
                      meta: meta,
                      child: Text(
                        DateFormat('dd/MM').format(data[idx]["date"]),
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                getTitlesWidget: (value, meta) => Text("${value.toInt()}"),
              ),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            LineChartBarData(
              spots: data
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value["price"]))
                  .toList(),
              isCurved: true,
              color: Colors.orange,
              barWidth: 4,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: Colors.orange.withOpacity(0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showThresholdDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Définir une alerte"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                "Recevoir une notification quand le prix descend en dessous de :"),
            const SizedBox(height: 15),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                suffixText: "FCFA",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Annuler")),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFC90E)),
            child:
                const Text("Enregistrer", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
