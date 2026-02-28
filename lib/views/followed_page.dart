import 'package:flutter/material.dart';
import '../components/price_chart.dart';
import '../components/chart_product.dart';

class FollowedPage extends StatelessWidget {
  const FollowedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Icon(Icons.home, color: Colors.white, size: 30,),
            Text(
              "Followed Products",
              style: TextStyle(
                color: Color(0xffffffff),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xffffc90e),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_cart_outlined, size: 50,),
            Text("Followed Products Page",
              style: TextStyle(
                  fontSize: 40
              ),
            ),
            PriceTrackerPage(),
          ],
        ),
      ),
    );
  }
}
