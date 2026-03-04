import 'package:catholic_daily/screens/bible_screen.dart';
import 'package:catholic_daily/screens/prayers_screen.dart';
import 'package:catholic_daily/screens/rosary_hub_screen.dart';
import 'package:catholic_daily/screens/settings_screen.dart';
import 'package:catholic_daily/screens/splash_screen.dart';
import 'package:catholic_daily/services/settings_service.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Hive.openBox('dailyReadings');

  runApp(CatholicDailyApp());
}

class CatholicDailyApp extends StatelessWidget {
  const CatholicDailyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catholic Daily',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: SplashScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomePage(),
    RosaryHubScreen(),
    BibleScreen(),
    PrayersPage(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Rosary'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Bible'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Prayers'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
