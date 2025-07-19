import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'add_expense_screen.dart';
import 'statistics_screen.dart';
import 'homepage.dart';
import 'package:mhtechin/wallet/wallet_screen.dart';
import 'profile_screen.dart'; // Optional: if needed for refresh

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _navigateTo(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const StatisticsScreen()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const WalletScreen()),
        );
        break;
      case 4:
      // Already on ProfileScreen
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFF7F6),
      body: Column(
        children: [
          // 🟩 Profile Header
          Container(
            height: 250,
            decoration: const BoxDecoration(
              color: Color(0xFF0AB29F),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Stack(
              children: [
                const Positioned(
                  top: 50,
                  left: 20,
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ),
                const Positioned(
                  top: 50,
                  right: 20,
                  child: Icon(Icons.notifications, color: Colors.white),
                ),
                const Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 42,
                          backgroundImage: AssetImage(
                            'assets/images/avatar.png',
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        'Enjelin Morgeana',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        '@enjelin_morgeana',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: const [
                _ProfileMenuItem(
                  iconPath: 'assets/icons/diamond.png',
                  title: 'Invite Friends',
                ),
                _ProfileMenuItem(
                  iconData: Icons.person,
                  title: 'Account info',
                ),
                _ProfileMenuItem(
                  iconData: Icons.people,
                  title: 'Personal profile',
                ),
                _ProfileMenuItem(
                  iconData: Icons.mail,
                  title: 'Message center',
                ),
                _ProfileMenuItem(
                  iconData: Icons.security,
                  title: 'Login and security',
                ),
                _ProfileMenuItem(
                  iconData: Icons.lock,
                  title: 'Data and privacy',
                ),
              ],
            ),
          ),
        ],
      ),

      // 🟫 Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        selectedItemColor: const Color(0xFF0AB29F),
        unselectedItemColor: Colors.grey,
        onTap: (index) => _navigateTo(index, context),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}

class _ProfileMenuItem extends StatelessWidget {
  final IconData? iconData;
  final String? iconPath;
  final String title;

  const _ProfileMenuItem({
    this.iconData,
    this.iconPath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: iconPath != null
              ? CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Image.asset(
              iconPath!,
              height: 28,
              width: 28,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.diamond),
            ),
          )
              : Icon(iconData, color: Colors.black),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          onTap: () {
            // TODO: Add navigation or action
          },
        ),
        const Divider(),
      ],
    );
  }
}
