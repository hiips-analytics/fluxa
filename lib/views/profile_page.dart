import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            // Icon(Icons.home, color: Colors.white, size: 30,),
            Text(
              "Profile",
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
            Icon(Icons.person_outline, size: 50,),
            Text("Profile Page",
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
