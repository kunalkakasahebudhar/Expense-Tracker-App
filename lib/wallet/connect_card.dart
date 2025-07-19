import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../pages/add_expense_screen.dart';
import '../pages/homepage.dart';
import '../pages/profile_screen.dart';
import '../pages/statistics_screen.dart';

class ConnectCardScreen extends ConsumerStatefulWidget {
  const ConnectCardScreen({super.key});

  @override
  ConsumerState<ConnectCardScreen> createState() => _ConnectCardScreenState();
}

class _ConnectCardScreenState extends ConsumerState<ConnectCardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _bottomNavBarSelectedIndex = 3;

  final TextEditingController _nameOnCardController = TextEditingController(text: 'IRVAN MOSES');
  final TextEditingController _debitCardNumberController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();
  final TextEditingController _zipController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameOnCardController.dispose();
    _debitCardNumberController.dispose();
    _cvcController.dispose();
    _expirationController.dispose();
    _zipController.dispose();
    super.dispose();
  }

  void _onBottomNavBarItemTapped(int index) {
    if (index == _bottomNavBarSelectedIndex) return;

    setState(() => _bottomNavBarSelectedIndex = index);

    late final Widget target;
    switch (index) {
      case 0:
        target = const HomePage();
        break;
      case 1:
        target = const StatisticsScreen();
        break;
      case 2:
        target = const AddExpenseScreen();
        break;
      case 4:
        target = const ProfileScreen();
        break;
      default:
        return; // invalid index
    }

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => target),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7F9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF209E9F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Connect Card',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: const [
          Icon(Icons.notifications_none, color: Colors.white),
          SizedBox(width: 16),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(text: 'Cards'),
            Tab(text: 'Accounts'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCardTab(),
                const Center(
                  child: Text(
                    'Accounts Tab Content',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          BottomNavigationBar(
            selectedItemColor: const Color(0xFF209E9F),
            unselectedItemColor: Colors.grey,
            currentIndex: _bottomNavBarSelectedIndex,
            onTap: _onBottomNavBarItemTapped,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCardPreview(),
          const SizedBox(height: 20),
          const Text(
            'Add your debit Card',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          const Text(
            'This card must be connected to a bank account under your name',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          _buildTextField(_nameOnCardController, 'NAME ON CARD'),
          const SizedBox(height: 15),
          _buildTextField(_debitCardNumberController, 'DEBIT CARD NUMBER', keyboardType: TextInputType.number),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: _buildTextField(_cvcController, 'CVC', keyboardType: TextInputType.number)),
              const SizedBox(width: 15),
              Expanded(child: _buildTextField(_expirationController, 'EXPIRATION MM/YY', keyboardType: TextInputType.datetime)),
            ],
          ),
          const SizedBox(height: 15),
          _buildTextField(_zipController, 'ZIP', keyboardType: TextInputType.number),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Connect Card button pressed!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF209E9F),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text(
              'Connect Card',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardPreview() {
    return Container(
      width: double.infinity,
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF209E9F), Color(0xFF1D8F90)]),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Stack(
        children: [
          const Positioned(
            top: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Debit Card', style: TextStyle(color: Colors.white70, fontSize: 16)),
                SizedBox(height: 5),
                Text('Mono', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: Image.asset(
              'assets/icons/chip.png',
              height: 40,
              width: 40,
              errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.credit_card, color: Colors.white, size: 40),
            ),
          ),
          const Positioned(
            bottom: 70,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('6219', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                Text('8610', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                Text('2888', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                Text('8075', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: Text(
              _nameOnCardController.text.toUpperCase(),
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const Positioned(
            bottom: 20,
            right: 20,
            child: Text('22/01', style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText, {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 12),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
    );
  }
}
