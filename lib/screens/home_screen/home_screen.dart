import 'package:flutter/material.dart';
import 'package:ttg/screens/courses_screen/courses_screen.dart';
import 'package:ttg/screens/dashboard_screen/dashboard_screen.dart';
import 'package:ttg/screens/staff_screen/staff_screen.dart';
import 'package:ttg/styles/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),
    CoursesScreen(),
    StaffScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _screens.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: AppColors.primaryColor,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), label: 'DashBoard'),
            BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Courses'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Staffs'),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
