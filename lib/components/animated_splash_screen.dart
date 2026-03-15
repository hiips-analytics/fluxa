import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

// Components imports
import 'package:fluxa/views/login_page.dart';

class AnimateSplashScreen extends StatefulWidget {
  const AnimateSplashScreen({super.key});

  @override
  State<AnimateSplashScreen> createState() => _AnimateSplashScreenState();
}

class _AnimateSplashScreenState extends State<AnimateSplashScreen> {
  double _opacity = 1.0;
  double _scale = 0.7;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 200), () {
      FlutterNativeSplash.remove(); // On enlève le splash natif figé
      setState(() {
        _opacity = 1.0;
        _scale = 1.0;
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      // Une fois l'animation finie, on va vers l'écran de connexion
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, a, sa) => const LoginPage(),
          transitionsBuilder: (context, a, sa, child) =>
              FadeTransition(opacity: a, child: child),
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
              duration: const Duration(milliseconds: 700),
              opacity: _opacity,
              child: AnimatedScale(
                duration: const Duration(milliseconds: 700),
                scale: _scale,
                curve: Curves.easeOutBack,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC90E).withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset("assets/logos/app_icon.png", width: 200),
                ),
              ),
            ),
            const Text(
              "Fluxa",
              style: TextStyle(
                fontSize: 30,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold,
                color: Color(0xFFFFC90E),
              ),
            ),
            const SizedBox(height: 30),
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(milliseconds: 2000),
              child: SizedBox(
                width: 150,
                child: LinearProgressIndicator(
                  backgroundColor: Colors.grey[200],
                  color: const Color(0xFFFFC90E),
                  minHeight: 4,
                ),
              ),
            ),
            const SizedBox(height: 75),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Développé par ",
                    style: TextStyle(
                      fontSize: 15,
                      // fontStyle: FontStyle.italic,
                      color: Color(0xffffc90e),
                    ),
                  ),
                  const Text(
                    "DevMobil-15",
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Color(0xffffc90e),
                    ),
                  )
                ]
            ),
            const SizedBox(height: 5),
            const Text(
              "IUT de NGAOUNDERE | Mars 2026",
              style: TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
                color: Color(0xffffc90e),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
