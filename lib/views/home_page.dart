import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Icon(Icons.home, color: Colors.white, size: 30,),
            Text(
              "Home",
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
            Icon(Icons.home_outlined, size: 50,),
            Text("Home Page",
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