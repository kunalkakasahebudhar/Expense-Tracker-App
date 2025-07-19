import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'homepage.dart';
import 'statistics_screen.dart';
import 'package:mhtechin/wallet/wallet_screen.dart';
import 'profile_screen.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = 'Netflix';
  final List<String> _categories = ['Netflix', 'Spotify', 'Groceries', 'Utilities', 'Transport'];
  String _currentNumberInput = '48.00';
  int _bottomNavBarSelectedIndex = 2;

  @override
  void initState() {
    super.initState();
    _amountController.text = '\$ $_currentNumberInput';
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _onNumberTap(String value) {
    setState(() {
      if (value == 'Clear') {
        _currentNumberInput = '0.00';
      } else if (value == 'backspace') {
        if (_currentNumberInput.isNotEmpty) {
          _currentNumberInput = _currentNumberInput.substring(0, _currentNumberInput.length - 1);
        }
        if (_currentNumberInput.isEmpty || _currentNumberInput == '.') {
          _currentNumberInput = '0.00';
        }
      } else if (value == '.') {
        if (!_currentNumberInput.contains('.')) {
          _currentNumberInput += '.';
        }
      } else {
        if (_currentNumberInput == '0.00' || _currentNumberInput == '0') {
          _currentNumberInput = value;
        } else {
          _currentNumberInput += value;
        }
      }

      try {
        final parsed = double.parse(_currentNumberInput);
        _amountController.text = '\$ ${parsed.toStringAsFixed(2)}';
      } catch (_) {
        _amountController.text = '\$ $_currentNumberInput';
      }
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF209E9F),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Color(0xFF209E9F)),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

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
        title: const Text('Add Expense', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(icon: const Icon(Icons.more_horiz, color: Colors.black), onPressed: () {}),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildInputCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          _buildNumericKeypad(),
        ],
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

  Widget _buildInputCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), spreadRadius: 2, blurRadius: 5)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('NAME', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedCategory,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
            icon: const Icon(Icons.keyboard_arrow_down),
            onChanged: (value) => setState(() => _selectedCategory = value!),
            items: _categories.map((value) {
              return DropdownMenuItem(
                value: value,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/${value.toLowerCase()}.png',
                      height: 24,
                      width: 24,
                      errorBuilder: (context, error, stackTrace) => const Icon(Icons.category, size: 24),
                    ),
                    const SizedBox(width: 10),
                    Text(value),
                  ],
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          const Text('AMOUNT', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          TextField(
            controller: _amountController,
            readOnly: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey.shade100,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              suffixIcon: TextButton(
                onPressed: () => _onNumberTap('Clear'),
                child: const Text('Clear', style: TextStyle(color: Colors.teal)),
              ),
            ),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          const Text('DATE', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: AbsorbPointer(
              child: TextField(
                controller: TextEditingController(text: DateFormat('EEE, dd MMM yyyy').format(_selectedDate)),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Text('INVOICE', style: TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_circle_outline, color: Colors.grey),
                SizedBox(width: 8),
                Text('Add Invoice', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumericKeypad() {
    final rows = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['.', '0', 'backspace'],
    ];

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)],
      ),
      child: Column(
        children: rows.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: row.map((value) {
              return _buildKeypadButton(
                value,
                icon: value == 'backspace' ? Icons.backspace_outlined : null,
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildKeypadButton(String value, {IconData? icon}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () => _onNumberTap(value),
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: icon != null
                  ? Icon(icon, size: 24, color: Colors.black)
                  : Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
          ),
        ),
      ),
    );
  }
}
