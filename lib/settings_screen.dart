import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Ayarlar")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Karanlık Mod Switch
          ListTile(
            title: const Text("Karanlık Mod"),
            trailing: Switch(
              value: settings.isDarkMode,
              onChanged: (value) => settings.toggleTheme(),
            ),
          ),
          const Divider(),
          // Yazı Büyüklüğü Ayarı
          const ListTile(title: Text("Yazı Büyüklüğü")),
          Slider(
            value: settings.fontSize,
            min: 12,
            max: 30,
            onChanged: (value) => settings.setFontSize(value),
          ),
          const Divider(),
          // Çıkış Yap Butonu
          ListTile(
            leading: const Icon(Icons.exit_to_app, color: Colors.red),
            title: const Text("Çıkış Yap", style: TextStyle(color: Colors.red)),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}