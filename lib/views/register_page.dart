import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';
import '../components/main_screen.dart';
import '../components/merchant_main_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthService _authService = AuthService();

  String _userType = 'Client';
  bool _obscurePassword = true;
  bool _isLoading = false;

  void _handleSignUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showErrorSnackBar("Veuillez remplir tous les champs");
      return;
    }

    if (password.length < 6) {
      _showErrorSnackBar("Le mot de passe doit faire au moins 6 caractères");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = await _authService.signUp(name, email, password, _userType);

      setState(() => _isLoading = false);

      if (user != null) {
        if (mounted) {
          if (_userType == 'Commerçant') {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const MerchantMainScreen()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainScreen()),
            );
          }
        }
      } else {
        _showErrorSnackBar(
            "Une erreur inconnue est survenue lors de l'enregistrement Firestore.");
      }
    } on FirebaseAuthException catch (e) {
      setState(() => _isLoading = false);
      String message = "Échec de l'inscription";
      if (e.code == 'email-already-in-use') {
        message = "Cet email est déjà utilisé par un autre compte.";
      } else if (e.code == 'invalid-email') {
        message = "L'adresse email n'est pas valide.";
      } else if (e.code == 'weak-password') {
        message = "Le mot de passe est trop faible.";
      }
      _showErrorSnackBar(message);
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorSnackBar("Erreur: ${e.toString()}");
    }
  }

  void _showErrorSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFC90E).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Image.asset("assets/logos/app_icon.png", width: 120),
              ),
              const SizedBox(height: 20),
              const Text(
                "Fluxa",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFC90E)),
              ),
              const SizedBox(height: 10),
              const Text(
                "Rejoignez Fluxa et commencez à économiser.",
                style: TextStyle(color: Colors.grey, fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Vous êtes ?",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  _buildTypeCard(Icons.shopping_cart_outlined, "Client"),
                  const SizedBox(width: 20),
                  _buildTypeCard(Icons.storefront, "Commerçant"),
                ],
              ),
              const SizedBox(height: 30),
              _buildTextField("Nom complet", Icons.person_outline,
                  controller: _nameController),
              const SizedBox(height: 20),
              _buildTextField("Email", Icons.email_outlined,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 20),
              _buildTextField("Mot de passe", Icons.lock_outline,
                  isPassword: true, controller: _passwordController),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSignUp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC90E),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 0,
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text("Créer mon compte",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTypeCard(IconData icon, String label) {
    bool isSelected = _userType == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _userType = label),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFFFFC90E) : Colors.grey[50],
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: isSelected ? const Color(0xFFFFC90E) : Colors.grey[200]!),
          ),
          child: Column(
            children: [
              Icon(icon,
                  color: isSelected ? Colors.white : Colors.grey, size: 30),
              const SizedBox(height: 8),
              Text(label,
                  style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon,
      {bool isPassword = false,
      required TextEditingController controller,
      TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? _obscurePassword : false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        floatingLabelStyle: const TextStyle(color: Color(0xFFFFC90E)),
        prefixIcon: Icon(icon),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(_obscurePassword
                    ? Icons.visibility_off
                    : Icons.visibility),
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
              )
            : null,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Color(0xFFFFC90E), width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
    );
  }
}
