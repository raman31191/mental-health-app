import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mental_health/screens/splashscreen1.dart';
import 'package:mental_health/utils/notification_service.dart';
import 'package:mental_health/providers/theme_provider.dart'; // add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  NotificationService notificationService = NotificationService();
  await notificationService.initNotifications(); // Initialize Notifications

  runApp(const MentalHealth());
}

class MentalHealth extends StatelessWidget {
  const MentalHealth({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Mental Health Journal',
            themeMode:
                themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              primarySwatch: Colors.pink,
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.white,
            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.pink,
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Colors.black,
            ),
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
