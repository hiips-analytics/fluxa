import 'package:flutter/material.dart';
import 'package:fluxa/components/chart_product.dart';
import 'package:fluxa/views/notifications_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

// Views imports
import '../views/home_page.dart';
import '../views/search_page.dart';
import '../views/followed_page.dart';
import '../views/settings_page.dart';
import '../views/profile_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // Le contrôleur pour gérer le changement d'onglets programmatiquement
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);

  // 1. Vos écrans (Remplacez par vos propres Widgets)
  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const SearchPage(),
      const PriceTrackerPage(),
      const NotificationsPage(),
      const SettingsPage(),
      const ProfilePage(),
    ];
  }

  // 2. Configuration esthétique des items (Style 9)
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_outlined),
        title: ("Accueil"),
        activeColorPrimary: Color(0xffffc900),
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search_outlined),
        title: ("Rechercher"),
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.shopping_cart_outlined),
        title: ("Suivi"),
        activeColorPrimary: Colors.red,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.notifications_active_outlined),
        title: ("Notifications"),
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings_outlined),
        title: ("Parametres"),
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_outline),
        title: ("Profil"),
        activeColorPrimary: Colors.green,
        inactiveColorPrimary: Colors.black,
      ),
    ];

  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
        boxShadow: [
          const BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
      ),

      // LA LIGNE CLÉ :
      navBarStyle: NavBarStyle.style9, // C'est ici que vous activez le style voulu
    );
  }
}
