import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:wanted/models/app_state_manager.dart';

/// **SignInScreen**
/// Écran permettant aux utilisateurs de se connecter à Wanted.
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appStateManager = Provider.of<AppStateManager>(context, listen: false);

    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ✅ Titre
              const Text(
                "Se connecter",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // ✅ Champ Email
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),

              const SizedBox(height: 10),

              // ✅ Champ Mot de passe
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Mot de passe",
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),

              const SizedBox(height: 20),

              // ✅ Bouton Connexion
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();

                    // Appel à AppStateManager pour gérer la connexion
                    await appStateManager.loginUser("username", email, password);

                    GoRouter.of(context).go('/home'); 
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text("Connexion"),
                ),
              ),

              const SizedBox(height: 10),

              // ✅ Lien Mot de passe oublié
              TextButton(
                onPressed: () {
                  // TODO: Implémenter la récupération du mot de passe
                },
                child: const Text("Mot de passe oublié ?"),
              ),

              const SizedBox(height: 20),

              // ✅ Options de connexion alternatives
              const Text("Ou connectez-vous avec"),
              const SizedBox(height: 10),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(
                    icon: Icons.abc, // Remplacer par le logo Google
                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  _buildSocialButton(
                    icon: Icons.abc, // Remplacer par le logo Facebook
                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  _buildSocialButton(
                    icon: Icons.abc, // Remplacer par le logo TikTok
                    onPressed: () {},
                  ),
                  const SizedBox(width: 20),
                  _buildSocialButton(
                    icon: Icons.abc, // Remplacer par le logo X (Twitter)
                    onPressed: () {},
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ✅ Lien vers l'inscription
              TextButton(
                onPressed: () {
                  // 🔹 Rediriger vers l'écran d'inscription avec GoRouter
                  GoRouter.of(context).go('/auth');
                },
                child: const Text("Pas encore de compte ? Inscrivez-vous"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ Widget pour les boutons de connexion sociale (Google, Facebook, TikTok, X)
  Widget _buildSocialButton({required IconData icon, required VoidCallback onPressed}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 5),
          ],
        ),
        child: Icon(icon, size: 30, color: Colors.black),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:wanted/models/model.dart';
// import 'package:wanted/screens/screens.dart';

// /// **SignInScreen**
// /// This screen allows users to log in to the Wanted app.
// /// It includes fields for email and password, as well as social login options.
// class SignInScreen extends StatelessWidget {
//   const SignInScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               // ✅ Title
//               const Text(
//                 "Sign In",
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),

//               // ✅ Email Input Field
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: "Email",
//                   prefixIcon: const Icon(Icons.email),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),

//               const SizedBox(height: 10),

//               // ✅ Password Input Field
//               TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: "Password",
//                   prefixIcon: const Icon(Icons.lock),
//                   border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
//                 ),
//               ),

//               const SizedBox(height: 20),

//               // ✅ Sign In Button
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () async{
//                     // TODO: Implement sign-in logic (Firebase/Auth API)
//                     Provider.of<AppStateManager>(context, listen: false).loginUser("username", "email", "password");
//                   },
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 15),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                   ),
//                   child: const Text("Sign In"),
//                 ),
//               ),

//               const SizedBox(height: 10),

//               // ✅ Forgot Password Link
//               TextButton(
//                 onPressed: () {
//                   // TODO: Implement forgot password functionality
//                 },
//                 child: const Text("Forgot Password?"),
//               ),

//               const SizedBox(height: 20),

//               // ✅ Alternative Sign-in Options
//               const Text("Or sign in with"),
//               const SizedBox(height: 10),

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildSocialButton(
//                     icon: Icons.abc, // Replace with Google logo
//                     onPressed: () {},
//                   ),
//                   const SizedBox(width: 20),
//                   _buildSocialButton(
//                     icon: Icons.abc, // Replace with Facebook logo
//                     onPressed: () {},
//                   ),
//                   const SizedBox(width: 20),
//                   _buildSocialButton(
//                     icon: Icons.abc, // Replace with TikTok logo
//                     onPressed: () {},
//                   ),
//                   const SizedBox(width: 20),
//                   _buildSocialButton(
//                     icon: Icons.abc, // Replace with X (Twitter) logo
//                     onPressed: () {},
//                   ),
//                 ],
//               ),

//               const SizedBox(height: 20),

//               // ✅ Link to Sign Up Screen
//               TextButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => const SignUpScreen()),
//                   );
//                 },
//                 child: const Text("Don't have an account? Sign Up"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// ✅ Widget for Social Login Buttons (Google, Facebook, TikTok, Twitter)
//   Widget _buildSocialButton({required IconData icon, required VoidCallback onPressed}) {
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         width: 50,
//         height: 50,
//         decoration: const BoxDecoration(
//           shape: BoxShape.circle,
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(color: Colors.grey, blurRadius: 5),
//           ],
//         ),
//         child: Icon(icon, size: 30, color: Colors.black),
//       ),
//     );
//   }
// }
