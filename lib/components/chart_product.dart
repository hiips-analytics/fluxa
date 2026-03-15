import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PriceTrackerPage extends StatefulWidget {
  const PriceTrackerPage({super.key});

  @override
  State<PriceTrackerPage> createState() => _PriceTrackerPageState();
}

class _PriceTrackerPageState extends State<PriceTrackerPage> {
  // 1. Nos données (initialisées avec quelques exemples)
  final List<Map<String, dynamic>> _data = [
    {"date": DateTime(2026, 2, 10), "price": 45.0},
    {"date": DateTime(2026, 2, 15), "price": 38.0},
    {"date": DateTime(2026, 2, 20), "price": 42.0},
  ];

  final double _targetPrice = 35.0; // Votre objectif
  final TextEditingController _priceController = TextEditingController();

  // Fonction pour ajouter un nouveau prix avec la date du jour
  void _addNewPrice() {
    final double? enteredPrice = double.tryParse(_priceController.text);
    if (enteredPrice != null && enteredPrice > 0) {
      setState(() {
        _data.add({
          "date": DateTime.now(),
          "price": enteredPrice,
        });
        _priceController.clear();
      });
      // Fermer le clavier
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final double currentPrice = _data.last["price"];
    final Color targetColor = currentPrice <= _targetPrice
        ? Colors.greenAccent
        : Colors.orangeAccent;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // --- SECTION GRAPHIQUE ---
        const Text(
          "Historique des variations",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        AspectRatio(
          aspectRatio: 1.4,
          child: LineChart(
            LineChartData(
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (spot) => Colors.deepPurple.withValues(alpha: 0.9),
                ),
              ),
              gridData: const FlGridData(show: true, drawVerticalLine: false),
              titlesData: FlTitlesData(
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index >= 0 && index < _data.length) {
                        return SideTitleWidget(
                          meta: meta, // On passe l'objet meta entier ici
                          space: 8,   // L'espace entre le texte et l'axe
                          child: Text(
                            DateFormat('dd/MM').format(_data[index]["date"]),
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 45,
                    getTitlesWidget: (value, meta) => Text("${value.toInt()}€"),
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              extraLinesData: ExtraLinesData(
                horizontalLines: [
                  HorizontalLine(
                    y: _targetPrice,
                    color: targetColor,
                    strokeWidth: 2,
                    dashArray: [5, 5],
                    label: HorizontalLineLabel(
                      show: true,
                      alignment: Alignment.topRight,
                      labelResolver: (line) => 'Cible: ${line.y}€',
                      style: TextStyle(color: targetColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: _data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value["price"])).toList(),
                  isCurved: true,
                  color: Color(0xffff0000),
                  barWidth: 4,
                  dotData: const FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Color(0xffff0000).withValues(alpha: 0.1),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),

        // --- SECTION FORMULAIRE ---
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text("Ajouter un relevé", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _priceController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: "Nouveau prix",
                          suffixText: "€",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: _addNewPrice,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      ),
                      child: const Icon(Icons.add_chart),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}