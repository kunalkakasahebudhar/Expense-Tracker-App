import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'homepage.dart';
import 'add_expense_screen.dart';
import 'package:mhtechin/wallet//wallet_screen.dart';
import 'profile_screen.dart';

class StatisticsScreen extends ConsumerStatefulWidget {
  const StatisticsScreen({super.key});

  @override
  ConsumerState<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends ConsumerState<StatisticsScreen> {
  int _selectedTimePeriodIndex = 2;
  String _selectedFilter = 'Expense';
  int _bottomNavBarSelectedIndex = 1;

  void _onBottomNavBarItemTapped(int index) {
    if (index == _bottomNavBarSelectedIndex) return;

    setState(() {
      _bottomNavBarSelectedIndex = index;
    });

    final pages = [
      const HomePage(),
      const StatisticsScreen(),
      const AddExpenseScreen(),
      const WalletScreen(),
      const ProfileScreen(),
    ];

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => pages[index]),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Statistics',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.download, color: Colors.black),
            onPressed: () {
              // Download functionality if needed
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            _buildTimePeriodSelector(),
            const SizedBox(height: 20),
            _buildDropdownFilter(),
            const SizedBox(height: 20),
            _buildChartPlaceholder(context),
            const SizedBox(height: 30),
            _buildTopSpendingSection(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavBarSelectedIndex,
        selectedItemColor: const Color(0xFF209E9F),
        unselectedItemColor: Colors.grey,
        onTap: _onBottomNavBarItemTapped,
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

  Widget _buildTimePeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          _buildTimePeriodButton(0, 'Day'),
          _buildTimePeriodButton(1, 'Week'),
          _buildTimePeriodButton(2, 'Month'),
          _buildTimePeriodButton(3, 'Year'),
        ],
      ),
    );
  }

  Widget _buildTimePeriodButton(int index, String text) {
    bool isSelected = _selectedTimePeriodIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTimePeriodIndex = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF209E9F) : Colors.transparent,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownFilter() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedFilter,
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
            style: const TextStyle(color: Colors.black, fontSize: 14),
            onChanged: (String? newValue) {
              setState(() {
                _selectedFilter = newValue!;
              });
            },
            items: <String>['Expense', 'Income']
                .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildChartPlaceholder(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(painter: _ChartPainter(), child: Container()),
          Positioned(
            top: 40,
            left: MediaQuery.of(context).size.width / 2 - 50,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF209E9F),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '\$1,230',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const Icon(Icons.circle, color: Color(0xFF209E9F), size: 10),
              ],
            ),
          ),
          const Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Mar', style: TextStyle(color: Colors.grey)),
                Text('Apr', style: TextStyle(color: Colors.grey)),
                Text('May', style: TextStyle(color: Color(0xFF209E9F), fontWeight: FontWeight.bold)),
                Text('Jun', style: TextStyle(color: Colors.grey)),
                Text('Jul', style: TextStyle(color: Colors.grey)),
                Text('Aug', style: TextStyle(color: Colors.grey)),
                Text('Sep', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopSpendingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Top Spending', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            IconButton(
              icon: const Icon(Icons.filter_list),
              onPressed: () {
                // TODO: Implement filter functionality
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        const TransactionItem(
          imagePath: 'assets/icons/starbucks.png',
          name: 'Starbucks',
          date: 'Jan 12, 2022',
          amount: '- \$150.00',
          isIncome: false,
        ),
        const SizedBox(height: 10),
        const TransactionItem(
          imagePath: 'assets/icons/transfer.png',
          name: 'Transfer',
          date: 'Yesterday',
          amount: '- \$85.00',
          isIncome: false,
        ),
        const SizedBox(height: 10),
        const TransactionItem(
          imagePath: 'assets/icons/youtube.png',
          name: 'Youtube',
          date: 'Jan 16, 2022',
          amount: '- \$11.99',
          isIncome: false,
        ),
      ],
    );
  }
}

class _ChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = const Color(0xFF209E9F).withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final strokePaint = Paint()
      ..color = const Color(0xFF209E9F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.4, size.width * 0.5, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.9, size.width, size.height * 0.7)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, fillPaint);

    final strokePath = Path()
      ..moveTo(0, size.height * 0.7)
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.4, size.width * 0.5, size.height * 0.6)
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.9, size.width, size.height * 0.7);

    canvas.drawPath(strokePath, strokePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

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
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          height: 24,
          width: 24,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.category),
        ),
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
