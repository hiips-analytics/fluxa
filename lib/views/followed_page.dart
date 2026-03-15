import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'product_detail_page.dart';
import 'shopping_list_page.dart';

class FollowedPage extends StatefulWidget {
  const FollowedPage({super.key});

  @override
  State<FollowedPage> createState() => _FollowedPageState();
}

class _FollowedPageState extends State<FollowedPage> {
  final List<Map<String, dynamic>> _followedProducts = [
    {
      "name": "iPhone 15",
      "target": 600000.0,
      "current": 650000.0,
      "trend": [700000.0, 680000.0, 690000.0, 660000.0, 650000.0]
    },
    {
      "name": "Huile de Palme 1L",
      "target": 1000.0,
      "current": 1100.0,
      "trend": [1300.0, 1200.0, 1250.0, 1150.0, 1100.0]
    },
    {
      "name": "Lait Bonnet Rouge 1L",
      "target": 1000.0,
      "current": 1150.0,
      "trend": [1050.0, 1100.0, 1080.0, 1120.0, 1150.0]
    },
    {
      "name": "Riz Parfumé 5kg",
      "target": 4500.0,
      "current": 4800.0,
      "trend": [5500.0, 5200.0, 5000.0, 4900.0, 4800.0]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Mes Produits Suivis",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFFFC90E),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.sort_rounded, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSummaryHeader(),
          _buildShoppingListButton(),
          Expanded(
            child: _followedProducts.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    itemCount: _followedProducts.length,
                    itemBuilder: (context, index) {
                      final product = _followedProducts[index];
                      return _buildDismissibleCard(product, index);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Color(0xFFFFC90E),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem("Suivis", "${_followedProducts.length}"),
          Container(width: 1, height: 30, color: Colors.white24),
          _buildStatItem("Alertes", "2"),
          Container(width: 1, height: 30, color: Colors.white24),
          _buildStatItem("Économie", "25 000 FCFA"),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      ],
    );
  }

  Widget _buildShoppingListButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ShoppingListPage()),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.green.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                    color: Colors.green, shape: BoxShape.circle),
                child: const Icon(Icons.shopping_basket,
                    color: Colors.white, size: 20),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text("Optimiser mes courses",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.green)),
                    Text("Comparer mon panier complet",
                        style: TextStyle(color: Colors.green, fontSize: 12)),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.green, size: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDismissibleCard(Map<String, dynamic> product, int index) {
    return Dismissible(
      key: Key(product['name']),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 25),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.redAccent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 30),
      ),
      onDismissed: (direction) {
        final removedProduct = product['name'];
        setState(() {
          _followedProducts.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$removedProduct n'est plus suivi"),
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ProductDetailPage()),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: _buildFollowedProductCard(product),
        ),
      ),
    );
  }

  Widget _buildFollowedProductCard(Map<String, dynamic> product) {
    final List<double> trend =
        (product['trend'] as List).map((e) => (e as num).toDouble()).toList();
    final bool isDown = trend.last < trend.first;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4))
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(15)),
                child: const Icon(Icons.shopping_bag_outlined,
                    color: Colors.orange),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text("Cible : ${product['target'].toInt()} FCFA",
                        style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 13)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("${product['current'].toInt()} FCFA",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDown ? Colors.orange[800] : Colors.black87)),
                  Row(
                    children: [
                      Icon(isDown ? Icons.trending_down : Icons.trending_up,
                          size: 14, color: isDown ? Colors.green : Colors.red),
                      const SizedBox(width: 4),
                      Text(isDown ? "En baisse" : "En hausse",
                          style: TextStyle(
                              color: isDown ? Colors.green : Colors.red,
                              fontSize: 11,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 40,
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: trend
                        .asMap()
                        .entries
                        .map((e) => FlSpot(e.key.toDouble(), e.value))
                        .toList(),
                    isCurved: true,
                    color: isDown ? Colors.greenAccent : Colors.redAccent,
                    barWidth: 3,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: (isDown ? Colors.greenAccent : Colors.redAccent)
                          .withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border_rounded,
              size: 100, color: Colors.grey[300]),
          const SizedBox(height: 20),
          const Text("Aucun produit suivi",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey)),
          const SizedBox(height: 10),
          const Text(
              "Ajoutez des produits pour surveiller\nleurs variations de prix.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
