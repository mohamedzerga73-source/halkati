import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/auth_gate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const HalqatiApp());
}

class HalqatiApp extends StatelessWidget {
  const HalqatiApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'حَلْقَتِي',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF087A52))),
    home: const AuthGate(),
  );
}
