import 'package:flutter/material.dart';
import 'package:wanted/screens/screens.dart';

class WantedView extends StatefulWidget {
  const WantedView({super.key});

  @override
  State<WantedView> createState() => _WantedViewState();
}

class _WantedViewState extends State<WantedView> {
  final PageController wantController = PageController(initialPage: 1);

  void _onGoToLive() {
    wantController.animateToPage(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onOpenDrawer() {
    wantController.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _closePage() {
    wantController.animateToPage(
      1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: wantController,
      physics: const ClampingScrollPhysics(),
      children: [
        LiveScreen(closePage: _closePage),
        WantedTab(
          onNavigateToLive: _onGoToLive, // ✅ Passe correctement la fonction
          onOpenDrawer: _onOpenDrawer,  // ✅ Passe correctement la fonction
        ),
        NavigationEndDrawer(closePage: _closePage),
      ],
    );
  }
}


class NavigationEndDrawer extends StatelessWidget {
  final VoidCallback closePage;
  const NavigationEndDrawer({super.key, required this.closePage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: closePage,
        ),
      ),
      body: ListView(
        children: [
          DrawerHeader(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ProfileScreen()),
                    );
                  },
                  label: const Text('Username'),
                  icon: const Icon(Icons.person_rounded, size: 25),
                ),
                IconButton(onPressed: () {}, icon: const Icon(Icons.add_rounded)),
              ],
            ),
          ),
          ListTile(leading: Icon(Icons.cast_rounded), title: Text('Cast')),          
          ListTile(leading: Icon(Icons.settings_rounded), title: Text('Settings'), onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen()));
          }),
          ListTile(leading: Icon(Icons.logout_rounded), title: Text('Logout'), onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const LogoutScreen()));
          }
          ),
        ],
      ),
    );
  }
}
