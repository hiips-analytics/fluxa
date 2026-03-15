import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Icon(Icons.home, color: Colors.white, size: 30,),
            Text(
              "Settings",
              style: TextStyle(
                color: Color(0xffffffff),
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xffffc90e),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.settings_outlined, size: 50,),
              Text("Settings Page",
                style: TextStyle(
                    fontSize: 40
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
