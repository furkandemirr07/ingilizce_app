import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';
import 'settings_screen.dart';
import 'learning_screen.dart'; // Bu dosyanın oluşturulmuş olması gerekir

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Kullanıcının tamamladığı gün sayısı
  int completedDay = 0; 

  @override
  Widget build(BuildContext context) {
    // Ayarlar sağlayıcısını dinliyoruz (Yazı boyutu için)
    final settings = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("30 Günlük Kamp"),
        backgroundColor: Colors.blueAccent,
        // Sol üstteki AI Logosuna basınca Ayarlar açılır
        leading: IconButton(
          icon: const Icon(Icons.psychology, size: 30, color: Colors.white), 
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsScreen()),
            );
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Yan yana 3 kutu
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: 30,
          itemBuilder: (context, index) {
            int currentDay = index + 1;
            // Eğer gün tamamlanan günden fazlaysa kilitli görünür
            bool isLocked = currentDay > (completedDay + 1);

            return InkWell(
              onTap: () {
                if (isLocked) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Bu gün henüz kilitli! Önceki günleri bitirmelisiniz.")),
                  );
                } else {
                  // Kilitli değilse ders ekranına gider
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LearningScreen(day: currentDay),
                    ),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isLocked ? Colors.grey.shade400 : Colors.blueAccent,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    if (!isLocked)
                      BoxShadow(color: Colors.blue.withOpacity(0.3), blurRadius: 4, spreadRadius: 1)
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isLocked ? Icons.lock : Icons.menu_book,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "$currentDay. Gün",
                      style: TextStyle(
                        color: Colors.white,
                        // Ayarlardan gelen font boyutunu buraya uyguluyoruz
                        fontSize: settings.fontSize - 2, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}