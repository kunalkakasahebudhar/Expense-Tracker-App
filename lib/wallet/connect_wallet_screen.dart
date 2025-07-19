import 'package:flutter/material.dart';
import 'package:mhtechin/wallet/connect_card.dart';
import 'package:mhtechin/pages/homepage.dart';
import 'package:mhtechin/pages/statistics_screen.dart';
import 'package:mhtechin/pages/profile_screen.dart';

class ConnectWalletScreen extends StatefulWidget {
  const ConnectWalletScreen({super.key});

  @override
  State<ConnectWalletScreen> createState() => _ConnectWalletScreenState();
}

class _ConnectWalletScreenState extends State<ConnectWalletScreen> {
  bool isCardsSelected = false;
  String selectedMethod = 'Bank Link';

  void _onBottomNavTap(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const StatisticsScreen()));
        break;
      case 2:
      // Already on Wallet
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ProfileScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C9A8B),
        elevation: 0,
        title: const Text('Connect Wallet', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.2),
              child: const Icon(Icons.notifications, color: Colors.white),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            color: const Color(0xFF1C9A8B),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    // 🟢 Cards / Accounts Toggle
                    Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          _buildToggleButton('Cards', false),
                          _buildToggleButton('Accounts', true),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // 🏦 Connection Options
                    _buildOptionTile(
                      icon: Icons.account_balance,
                      title: 'Bank Link',
                      subtitle: 'Connect your bank account to deposit & fund',
                      selected: selectedMethod == 'Bank Link',
                      onTap: () => setState(() => selectedMethod = 'Bank Link'),
                    ),
                    const SizedBox(height: 12),
                    _buildOptionTile(
                      icon: Icons.attach_money,
                      title: 'Microdeposits',
                      subtitle: 'Connect bank in 5–7 days',
                      selected: selectedMethod == 'Microdeposits',
                      onTap: () => setState(() => selectedMethod = 'Microdeposits'),
                    ),
                    const SizedBox(height: 12),
                    _buildOptionTile(
                      icon: Icons.account_balance_wallet_outlined,
                      title: 'Paypal',
                      subtitle: 'Connect your PayPal account',
                      selected: selectedMethod == 'Paypal',
                      onTap: () => setState(() => selectedMethod = 'Paypal'),
                    ),

                    const SizedBox(height: 30),

                    // ✅ Next Button
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Proceeding with $selectedMethod')),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF1C9A8B)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(color: Color(0xFF1C9A8B), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: const Color(0xFF1C9A8B),
        unselectedItemColor: Colors.grey,
        onTap: _onBottomNavTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String label, bool selected) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (label == 'Cards') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ConnectCardScreen()),
            );
          } else {
            setState(() => isCardsSelected = false);
          }
        },
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? const Color(0xFF1C9A8B) : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOptionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE8F5F3) : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(15),
          border: selected ? Border.all(color: const Color(0xFF1C9A8B)) : null,
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        child: Row(
          children: [
            Icon(icon, size: 28, color: selected ? const Color(0xFF1C9A8B) : Colors.grey),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: selected ? const Color(0xFF1C9A8B) : Colors.black,
                      )),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            if (selected)
              const Icon(Icons.check_circle, color: Color(0xFF1C9A8B))
          ],
        ),
      ),
    );
  }
}
