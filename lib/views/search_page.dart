import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Icon(Icons.home, color: Colors.white, size: 30,),
            Text(
              "Search",
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
            Icon(Icons.search_outlined, size: 50,),
            Text("Research Page",
              style: TextStyle(
                  fontSize: 40
              ),
            ),
          ],
        ),
      ),
    );
  }
}
