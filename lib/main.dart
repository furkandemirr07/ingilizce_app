import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'login_screen.dart';
import 'settings_provider.dart';

void main() async {
  // Flutter widget'larını ve Firebase'i başlatıyoruz
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    ChangeNotifierProvider(
      create: (_) => SettingsProvider(),
      child: const IngilizceApp(),
    ),
  );
}

class IngilizceApp extends StatelessWidget {
  const IngilizceApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Ayarlar sağlayıcısına bağlanıyoruz
    final settings = Provider.of<SettingsProvider>(context);

    return MaterialApp(
      title: 'İngilizce Kampı',
      debugShowCheckedModeBanner: false,
      // Tema modu ayarı (Karanlık/Aydınlık)
      themeMode: settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      
      // Aydınlık Tema Ayarları
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(backgroundColor: Colors.blueAccent),
      ),
      
      // Karanlık Tema Ayarları
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      
      home: const LoginScreen(),
    );
  }
}