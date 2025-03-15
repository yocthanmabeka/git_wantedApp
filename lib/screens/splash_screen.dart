import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:wanted/models/model.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // ✅ Animation du logo (fade-in)
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(_animationController);

    _animationController.forward();

    // ✅ Vérifier l'état de l'utilisateur après 3 secondes
    Future.delayed(const Duration(seconds: 3)
    , 
    
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // 🌌 Fond sombre pour un effet immersif
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ Logo Wanted (Remplacez par votre logo)
              Image.asset(
                'assets/medias/want4.jpg',
                //'assets/logo_wanted.png', // Assurez-vous que l'image est bien placée dans assets/
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),

              // ✅ Texte de bienvenue
              const Text(
                "Bienvenue sur Wanted",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 10),

              // ✅ Indicateur de chargement
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
