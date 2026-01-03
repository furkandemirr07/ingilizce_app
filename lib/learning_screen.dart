import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';
import 'settings_provider.dart';
import 'ai_chat_screen.dart'; // Yapay zeka sayfasını buraya tanıttık

class LearningScreen extends StatefulWidget {
  final int day;
  const LearningScreen({super.key, required this.day});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  final FlutterTts flutterTts = FlutterTts();
  int currentWordIndex = -1; // -1: Başlangıç ekranı, 0-19: Kelimeler

  // Günlük 20 kelime listesi
  final List<Map<String, String>> words = [
    {"en": "Adventure", "tr": "Macera"},
    {"en": "Believe", "tr": "İnanmak"},
    {"en": "Challenge", "tr": "Zorluk"},
    {"en": "Discovery", "tr": "Keşif"},
    {"en": "Effort", "tr": "Çaba"},
    {"en": "Freedom", "tr": "Özgürlük"},
    {"en": "Growth", "tr": "Büyüme"},
    {"en": "Happiness", "tr": "Mutluluk"},
    {"en": "Imagine", "tr": "Hayal Etmek"},
    {"en": "Journey", "tr": "Yolculuk"},
    {"en": "Knowledge", "tr": "Bilgi"},
    {"en": "Loyalty", "tr": "Sadakat"},
    {"en": "Memory", "tr": "Hafıza"},
    {"en": "Nature", "tr": "Doğa"},
    {"en": "Opportunity", "tr": "Fırsat"},
    {"en": "Passion", "tr": "Tutku"},
    {"en": "Quality", "tr": "Kalite"},
    {"en": "Respect", "tr": "Saygı"},
    {"en": "Success", "tr": "Başarı"},
    {"en": "Travel", "tr": "Seyahat"},
  ];

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.day}. Gün Kelimeleri"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: currentWordIndex == -1 
            ? _buildStartScreen(settings) 
            : currentWordIndex < words.length 
              ? _buildWordCard(settings) 
              : _buildQuizRedirect(settings),
        ),
      ),
    );
  }

  // 1. EKRAN: Başla Butonu
  Widget _buildStartScreen(SettingsProvider settings) {
    return ElevatedButton(
      onPressed: () => setState(() => currentWordIndex = 0),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      child: Text(
        "${widget.day}. Güne Başlayalım",
        style: TextStyle(fontSize: settings.fontSize, color: Colors.white),
      ),
    );
  }

  // 2. EKRAN: Kelime Kartı
  Widget _buildWordCard(SettingsProvider settings) {
    var word = words[currentWordIndex];
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Kelime ${currentWordIndex + 1} / ${words.length}",
          style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 40),
        Text(
          word["en"]!,
          style: TextStyle(
            fontSize: settings.fontSize + 20,
            fontWeight: FontWeight.bold,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(height: 10),
        IconButton(
          icon: const Icon(Icons.volume_up, size: 50, color: Colors.blueAccent),
          onPressed: () => _speak(word["en"]!),
        ),
        const SizedBox(height: 20),
        Text(
          word["tr"]!,
          style: TextStyle(fontSize: settings.fontSize + 6, color: Colors.blueGrey),
        ),
        const SizedBox(height: 60),
        ElevatedButton(
          onPressed: () => setState(() => currentWordIndex++),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(250, 60),
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
          child: Text(
            currentWordIndex < words.length - 1 ? "Sonraki Kelime" : "Kelimeleri Bitir",
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ],
    );
  }

  // 3. EKRAN: AI Quiz Yönlendirme (İstediğin Güncelleme Burada)
  Widget _buildQuizRedirect(SettingsProvider settings) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.stars, color: Colors.orange, size: 100),
        const SizedBox(height: 20),
        Text(
          "Tebrikler!",
          style: TextStyle(fontSize: settings.fontSize + 10, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          "Bugünün kelimelerini tamamladın.\nŞimdi yapay zeka ile pratik yapalım mı?",
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        ElevatedButton.icon(
          onPressed: () {
            // Butona basıldığında AI Sohbet ekranına geçiyoruz
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AIChatScreen(learnedWords: words),
              ),
            );
          },
          icon: const Icon(Icons.auto_awesome, color: Colors.white),
          label: const Text("Yapay Zeka ile Quiz Yap", style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            minimumSize: const Size(280, 60),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
      ],
    );
  }
}