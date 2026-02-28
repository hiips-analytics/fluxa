import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

// Components imports
import 'package:fluxa/components/main_screen.dart';

class AnimateSplashScreen extends StatefulWidget {
  const AnimateSplashScreen({super.key});

  @override
  State<AnimateSplashScreen> createState() => _AnimateSplashScreenState();
}

class _AnimateSplashScreenState extends State<AnimateSplashScreen> {
  double _opacity = 0.0;
  double _scale = 0.8;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      FlutterNativeSplash.remove(); // On enlève le splash natif figé
      setState(() {
        _opacity = 1.0;
        _scale = 1.0;
      });
    });

    Future.delayed(const Duration(seconds: 10), () {
      // Une fois l'animation finie, on va vers l'écran de navigation
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, a, sa) => const MainScreen(),
          transitionsBuilder: (context, a, sa, child) => FadeTransition(opacity: a, child: child),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 800),
              opacity: _opacity,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 800),
                scale: _scale,
                curve: Curves.easeOutBack,
                child: Image.asset("assets/logos/fluxa_icon.png", width: 200),
              ),
            ),
            Text("Fluxa Market",
              style: TextStyle(
                fontSize: 30,
                fontStyle: FontStyle.italic,
                color: Color(0xffffc90e),
              ),
            ),
            SizedBox(height: 30),
            AnimatedOpacity(
              opacity: _opacity, // Elle apparaîtra en même temps que le logo
              duration: const Duration(milliseconds: 2000),
              child: SizedBox(
                width: 150,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  color: const Color(0xffffc90e),
                  minHeight: 4,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}