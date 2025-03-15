import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wanted/models/model.dart'; // Import pour gérer l'état de l'app

/// **OnboardingScreen**
/// Ce fichier présente les fonctionnalités de l’application via plusieurs slides.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  /// **Données de l'onboarding (image, titre, description)**
  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/medias/want0.jpg",
      "title": "Bienvenue sur Wanted",
      "description": "Un espace pour se connecter, commémorer et agir."
    },
    {
      "image": "assets/medias/want0.jpg",
      "title": "Créez et Partagez",
      "description": "Organisez des événements et partagez vos souvenirs avec la communauté."
    },
    {
      "image": "assets/medias/want0.jpg",
      "title": "Honorez et Souvenez-vous",
      "description": "Rendez hommage aux moments et personnes qui comptent."
    }
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// **Redirige l'utilisateur après l'onboarding**
  void _onGetStarted() {
  final appStateManager = Provider.of<AppStateManager>(context, listen: false);
  appStateManager.isOnboardingComplete; // ✅ Marquer l'onboarding comme terminé

  Future.delayed(Duration.zero, () {
    if (mounted) {
      GoRouter.of(context).go('/home'); // ✅ Redirection après mise à jour de l'état
    }
  });
}



  /// **Bouton "Skip" (Passer l'onboarding)**
  Widget _buildSkipButton() {
    return TextButton(
      onPressed: () {
        _onGetStarted(); // Passe l'onboarding et va directement à l'accueil
      },
      child: const Text(
        "Passer",
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    );
  }

  /// **Indicateur de progression**
  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(onboardingData.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          height: 8.0,
          width: _currentPage == index ? 24.0 : 8.0,
          decoration: BoxDecoration(
            color: _currentPage == index ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(12),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /// **Bouton "Skip" en haut à droite**
            Padding(
              padding: const EdgeInsets.only(right: 16, top: 10),
              child: Align(
                alignment: Alignment.topRight,
                child: _buildSkipButton(),
              ),
            ),

            /// **Slides d'onboarding**
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: onboardingData.length,
                onPageChanged: (int page) {
                  setState(() => _currentPage = page);
                },
                itemBuilder: (context, index) {
                  final data = onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ✅ **Image associée au slide**
                        Image.asset(
                          data["image"]!,
                          height: 200,
                        ),
                        const SizedBox(height: 32),

                        // ✅ **Titre du slide**
                        Text(
                          data["title"]!,
                          style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        // ✅ **Description du slide**
                        Text(
                          data["description"]!,
                          style: const TextStyle(fontSize: 16, color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            /// **Indicateur de progression**
            _buildPageIndicator(),
            const SizedBox(height: 24),

            /// **Bouton "Get Started" visible uniquement sur le dernier slide**
            _currentPage == onboardingData.length - 1
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: ElevatedButton(
                      onPressed: _onGetStarted,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        minimumSize: const Size.fromHeight(50),
                      ),
                      child: const Text(
                        "Commencer",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  )
                : const SizedBox.shrink(), // Cache le bouton sauf sur la dernière page

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}



// import 'package:flutter/material.dart';

// /// **OnboardingScreen**
// /// This screen introduces new users to the Wanted app through a series of onboarding slides.
// /// It uses a `PageView` to navigate between different onboarding steps.
// class OnboardingScreen extends StatefulWidget {
//   const OnboardingScreen({super.key});

//   @override
//   State<OnboardingScreen> createState() => _OnboardingScreenState();
// }

// class _OnboardingScreenState extends State<OnboardingScreen> {
//   /// `PageController` to manage the PageView navigation
//   final PageController _pageController = PageController();
//   int _currentPage = 0; // Tracks the currently visible onboarding page

//   /// **Onboarding data**
//   /// Each entry represents a slide in the onboarding process.
//   final List<Map<String, String>> onboardingData = [
//     {
//       "title": "Welcome to Wanted",
//       "description": "Discover a new space to connect, commemorate, and take action."
//     },
//     {
//       "title": "Create & Share",
//       "description": "Create your events and share your stories with an engaged community."
//     },
//     {
//       "title": "Honor & Remember",
//       "description": "Commemorate important moments and honor the memories that matter."
//     }
//   ];

//   @override
//   void dispose() {
//     _pageController.dispose(); // Dispose of the PageController to free resources
//     super.dispose();
//   }

//   /// **Page Indicator**
//   /// Displays an animated dot indicator to show the user's progress in the onboarding flow.
//   Widget _buildPageIndicator() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: List.generate(onboardingData.length, (index) {
//         return AnimatedContainer(
//           duration: const Duration(milliseconds: 200),
//           margin: const EdgeInsets.symmetric(horizontal: 4.0),
//           height: 8.0,
//           width: _currentPage == index ? 24.0 : 8.0, // Active dot is wider
//           decoration: BoxDecoration(
//             color: _currentPage == index ? Colors.blue : Colors.grey,
//             borderRadius: BorderRadius.circular(12),
//           ),
//         );
//       }),
//     );
//   }

//   /// **Handles "Get Started" button click**
//   /// Redirects the user to the SignIn screen or Home screen after onboarding.
//   void _onGetStarted() {
//     Navigator.pushReplacementNamed(context, '/signin'); // Navigate to the sign-in screen
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             /// **Onboarding Slides**
//             Expanded(
//               child: PageView.builder(
//                 controller: _pageController,
//                 itemCount: onboardingData.length,
//                 onPageChanged: (int page) {
//                   setState(() {
//                     _currentPage = page; // Updates the indicator when user swipes
//                   });
//                 },
//                 itemBuilder: (context, index) {
//                   final data = onboardingData[index];
//                   return Padding(
//                     padding: const EdgeInsets.all(24.0),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         // **Placeholder for an image**
//                         // Uncomment and replace with actual image asset or network URL
//                         Image.network(
//                           data["image"]!,
//                           height: 250,
//                         ),
//                         const SizedBox(height: 32),

//                         /// **Title**
//                         Text(
//                           data["title"]!,
//                           style: const TextStyle(
//                               fontSize: 28,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black87),
//                           textAlign: TextAlign.center,
//                         ),

//                         const SizedBox(height: 16),

//                         /// **Description**
//                         Text(
//                           data["description"]!,
//                           style: const TextStyle(fontSize: 16, color: Colors.black54),
//                           textAlign: TextAlign.center,
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),

//             /// **Page Indicator**
//             _buildPageIndicator(),
//             const SizedBox(height: 24),

//             /// **"Get Started" Button**
//             /// Only displayed on the last page of onboarding.
//             _currentPage == onboardingData.length - 1
//                 ? Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                     child: ElevatedButton(
//                       onPressed: _onGetStarted,
//                       style: ElevatedButton.styleFrom(
//                         padding: const EdgeInsets.symmetric(vertical: 16.0),
//                         minimumSize: const Size.fromHeight(50),
//                       ),
//                       child: const Text(
//                         "Get Started",
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   )
//                 : const SizedBox.shrink(), // Keeps layout consistent for other pages

//             const SizedBox(height: 24),
//           ],
//         ),
//       ),
//     );
//   }
// }
