import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

var kColorSceme = ColorScheme.fromSeed(
  seedColor: const Color(0xFF275591)
);

var kDarkColorSceme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color(0xFF275591)
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp]
  ).then((fn) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorSceme
      ),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: kColorSceme,
        // appBarTheme: const AppBarTheme().copyWith(
        //   backgroundColor: kColorSceme.onPrimaryContainer,
        //   foregroundColor: kColorSceme.onPrimary
        // )
      ),
      // themeMode: ThemeMode.system,
      home: const Expenses(),
    );
  }
}