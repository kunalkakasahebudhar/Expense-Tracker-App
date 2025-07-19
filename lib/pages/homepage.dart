import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'statistics_screen.dart';
import 'add_expense_screen.dart';
import 'package:mhtechin/wallet/wallet_screen.dart';
import 'profile_screen.dart';

// 🔧 Riverpod provider to manage selected bottom tab index
final homeTabIndexProvider = StateProvider<int>((ref) => 0);

// 🏠 Converted HomePage using ConsumerWidget
class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  void _onItemTapped(BuildContext context, WidgetRef ref, int index) {
    final currentIndex = ref.read(homeTabIndexProvider);

    if (index == currentIndex) return;

    ref.read(homeTabIndexProvider.notifier).state = index;

    final pages = [
      null,
      const StatisticsScreen(),
      const AddExpenseScreen(),
      const WalletScreen(),
      const ProfileScreen(),
    ];

    if (index != 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pages[index]!),
      ).then((_) {
        ref.read(homeTabIndexProvider.notifier).state = 0; // Reset back to Home
      });
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(homeTabIndexProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      body: SafeArea(
        child: Column(
          children: [
            // 🟩 Header & Balance Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Color(0xFF209E9F),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Good afternoon,', style: TextStyle(color: Colors.white70, fontSize: 16)),
                  const Text('Enjelin Morgeana',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1D8F90),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Balance', style: TextStyle(color: Colors.white70)),
                            Icon(Icons.more_horiz, color: Colors.white),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text('\$ 2,548.00', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                        SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(Icons.arrow_downward, color: Colors.green),
                              SizedBox(width: 6),
                              Text('Income', style: TextStyle(color: Colors.white70)),
                              SizedBox(width: 6),
                              Text('\$ 1,840.00', style: TextStyle(color: Colors.white)),
                            ]),
                            Row(children: [
                              Icon(Icons.arrow_upward, color: Colors.red),
                              SizedBox(width: 6),
                              Text('Expenses', style: TextStyle(color: Colors.white70)),
                              SizedBox(width: 6),
                              Text('\$ 284.00', style: TextStyle(color: Colors.white)),
                            ]),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🟨 Transactions Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text('Transactions History', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('See all', style: TextStyle(color: Colors.teal)),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🟨 Transactions List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                children: const [
                  TransactionItem(
                    imagePath: 'assets/icons/upwork.png',
                    name: 'Upwork',
                    date: 'Today',
                    amount: '+ \$850.00',
                    isIncome: true,
                  ),
                  TransactionItem(
                    imagePath: 'assets/icons/transfer.png',
                    name: 'Transfer',
                    date: 'Yesterday',
                    amount: '- \$85.00',
                    isIncome: false,
                  ),
                  TransactionItem(
                    imagePath: 'assets/icons/paypal.png',
                    name: 'Paypal',
                    date: 'Jan 30, 2022',
                    amount: '+ \$1,406.00',
                    isIncome: true,
                  ),
                  TransactionItem(
                    imagePath: 'assets/icons/youtube.png',
                    name: 'Youtube',
                    date: 'Jan 16, 2022',
                    amount: '- \$11.99',
                    isIncome: false,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // 🟦 Send Again Avatars
            SizedBox(
              height: 80,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: const [
                  CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/avatars/user1.png')),
                  SizedBox(width: 12),
                  CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/avatars/user2.png')),
                  SizedBox(width: 12),
                  CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/avatars/user3.png')),
                  SizedBox(width: 12),
                  CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/avatars/user4.png')),
                  SizedBox(width: 12),
                  CircleAvatar(radius: 30, backgroundImage: AssetImage('assets/avatars/user5.png')),
                ],
              ),
            ),
          ],
        ),
      ),

      // 🟫 Bottom Navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: const Color(0xFF209E9F),
        unselectedItemColor: Colors.grey,
        onTap: (index) => _onItemTapped(context, ref, index),
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

// 💳 Transaction ListTile
class TransactionItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final String date;
  final String amount;
  final bool isIncome;

  const TransactionItem({
    super.key,
    required this.imagePath,
    required this.name,
    required this.date,
    required this.amount,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.grey.shade200,
        backgroundImage: AssetImage(imagePath),
      ),
      title: Text(name),
      subtitle: Text(date),
      trailing: Text(
        amount,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isIncome ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
