import 'package:flutter/material.dart';
import 'notifications/notification_service.dart';
import 'screens/home_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter(); // initialize Hive
  await Hive.openBox('dailyReadings'); // box to store readings
  await NotificationService.init();
  NotificationService.showDailyVerseNotification(
      verse: "John 3:16 - For God so loved the world...",
      hour: 8,
      minute: 0);

  runApp(CatholicDailyApp());
}

class CatholicDailyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catholic Daily',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    Placeholder(), // Rosary
    Placeholder(), // Bible
    Placeholder(), // Prayers
    Placeholder(), // Settings
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
