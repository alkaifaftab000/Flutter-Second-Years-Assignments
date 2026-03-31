import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'details_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assignment 2',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFF5A5A5A), // dark warm grey
          onPrimary: Colors.white,
          secondary: Color(0xFF9E9E9E), // lighter warm grey
          onSecondary: Colors.black,
          surface: Color(0xFFF7F4EF), // warm off-white surface style
          onSurface: Color(0xFF2A2A2A),
          error: Color(0xFFB00020),
          onError: Colors.white,
          tertiary: Color(0xFF424242),
          onTertiary: Colors.white,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F4EF),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF333333),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color(0xFF222222)),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF1A1A1A),
            side: const BorderSide(color: Color(0xFF303030)),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xFFF2EEE9),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF888888)),
          ),
        ),
      ),
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (_) => const LoginScreen(),
        HomeScreen.routeName: (_) => const HomeScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == DetailsScreen.routeName) {
          final message = settings.arguments as String? ?? 'No message passed';
          return MaterialPageRoute(
            builder: (_) => DetailsScreen(message: message),
          );
        }
        return null;
      },
    );
  }
}
