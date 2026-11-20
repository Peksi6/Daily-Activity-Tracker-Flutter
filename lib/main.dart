import 'package:flutter/material.dart';
import 'data/activity_data.dart';
import 'repositories/activity_repository.dart';
import 'viewmodels/activity_viewmodel.dart';
import 'views/home_view.dart';

void main() => runApp(const DailyActivityApp());

class DailyActivityApp extends StatefulWidget {
  const DailyActivityApp({super.key});

  @override
  State<DailyActivityApp> createState() => _DailyActivityAppState();
}

class _DailyActivityAppState extends State<DailyActivityApp> {
  late final ActivityViewModel viewModel = ActivityViewModel(
    ActivityRepository(ActivityData()),
  );

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Daily Activity Tracker',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,

        // Warna utama dari palet gambar
        scaffoldBackgroundColor: const Color(0xFFE0F0D5),

        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF72A24E),
          brightness: Brightness.light,
          primary: const Color(0xFF54862D),
          onPrimary: Colors.white,
          secondary: const Color(0xFF9AC47C),
          onSecondary: const Color(0xFF253D1D),
          surface: const Color(0xFFE0F0D5),
          onSurface: const Color(0xFF253D1D),
        ),

        // AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE0F0D5),
          foregroundColor: Color(0xFF253D1D),
          centerTitle: false,
          elevation: 0,
          surfaceTintColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Color(0xFF54862D),
          ),
          titleTextStyle: TextStyle(
            color: Color(0xFF253D1D),
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Kartu aktivitas
        cardTheme: CardThemeData(
          color: const Color(0xFFF7FBF3),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: Color(0xFFC5E3AF),
            ),
          ),
        ),

        // TextField
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF7FBF3),
          labelStyle: const TextStyle(
            color: Color(0xFF54862D),
          ),
          hintStyle: const TextStyle(
            color: Color(0xFF648257),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFFC5E3AF),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: Color(0xFF54862D),
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 16,
          ),
        ),

        // ElevatedButton
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF9AC47C),
            foregroundColor: const Color(0xFF253D1D),
            elevation: 0,
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),

        // FilledButton
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF54862D),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),

        // OutlinedButton
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color(0xFF54862D),
            side: const BorderSide(
              color: Color(0xFF9AC47C),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
        ),

        // IconButton
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: const Color(0xFF54862D),
          ),
        ),

        // SnackBar
        snackBarTheme: SnackBarThemeData(
          backgroundColor: const Color(0xFF54862D),
          contentTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),

        // AlertDialog
        dialogTheme: DialogThemeData(
          backgroundColor: const Color(0xFFF7FBF3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          titleTextStyle: const TextStyle(
            color: Color(0xFF253D1D),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: const TextStyle(
            color: Color(0xFF506B43),
            fontSize: 15,
          ),
        ),

        // Teks aplikasi
        textTheme: const TextTheme(
          headlineMedium: TextStyle(
            color: Color(0xFF253D1D),
            fontWeight: FontWeight.bold,
          ),
          titleLarge: TextStyle(
            color: Color(0xFF253D1D),
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: TextStyle(
            color: Color(0xFF253D1D),
          ),
          bodyMedium: TextStyle(
            color: Color(0xFF506B43),
          ),
        ),
      ),
      home: HomeView(viewModel: viewModel),
    );
  }
}
