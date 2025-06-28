// lib/pages/chat_page.dart
import 'package:flutter/material.dart';
import 'package:sipeduli/utils/app_colors.dart';
import 'package:sipeduli/widgets/chat_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io'; // Penting: Import ini untuk tipe File

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final List<ChatMessage> _messages = [];
  String? _userAvatarPath; // Untuk menyimpan path avatar pengguna

  @override
  void initState() {
    super.initState();
    _loadUserAvatar();
    _messages.add(
      const ChatMessage(
        text:
            'Halo! Saya adalah asisten Terapis SiPeduli. Ada yang bisa saya bantu?',
        isMe: false,
        avatarPath: 'assets/dr_budi_avatar.png',
      ),
    );
  }

  Future<void> _loadUserAvatar() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userAvatarPath = prefs.getString('profileImagePath');
    });
  }

  void _handleSubmitted(String text) {
    _messageController.clear();
    setState(() {
      _messages.insert(
        0,
        ChatMessage(
          text: text,
          isMe: true,
          avatarPath: _userAvatarPath, // Gunakan _userAvatarPath langsung
        ),
      );
    });

    _generateBotResponse(text);
  }

  void _generateBotResponse(String userMessage) {
    String botResponse =
        'Maaf, saya tidak mengerti pertanyaan Anda. Bisakah Anda mengulanginya atau bertanya hal lain?';

    if (userMessage.toLowerCase().contains('halo') ||
        userMessage.toLowerCase().contains('hi')) {
      botResponse = 'Halo! Senang bisa membantu Anda.';
    } else if (userMessage.toLowerCase().contains('bantuan') ||
        userMessage.toLowerCase().contains('tolong')) {
      botResponse =
          'Tentu, saya siap membantu. Apa yang ingin Anda ketahui atau butuhkan?';
    } else if (userMessage.toLowerCase().contains('tidak') ||
        userMessage.toLowerCase().contains('enggak')) {
      botResponse = 'Maaf, untuk hal itu. Bisakah menjelaskan lebih spesifik?';
    } else if (userMessage.toLowerCase().contains('mood')) {
      botResponse =
          'Anda bisa melacak mood Anda di bagian "Mood Log" pada aplikasi. Apakah Anda ingin tahu lebih banyak tentang itu?';
    } else if (userMessage.toLowerCase().contains('profesional')) {
      botResponse =
          'Untuk berbicara dengan profesional, Anda bisa kembali ke halaman utama dan pilih "Chat with professionals".';
    } else if (userMessage.toLowerCase().contains('terima kasih')) {
      botResponse =
          'Sama-sama! Jangan ragu untuk bertanya lagi jika ada yang lain.';
    } else if (userMessage.toLowerCase().contains('bagaimana kabar') ||
        userMessage.toLowerCase().contains('apa kabar')) {
      botResponse = 'Saya baik-baik saja, terima kasih!';
    } else if (userMessage.toLowerCase().contains('senang') ||
        userMessage.toLowerCase().contains('gembira') ||
        userMessage.toLowerCase().contains('bahagia')) {
      botResponse =
          'Senang sekali mendengarnya! Semoga perasaanmu semakin membaik kedepannya';
    }
    // --- New additions for a therapy-like conversation ---
    else if (userMessage.toLowerCase().contains('sedih') ||
        userMessage.toLowerCase().contains('depresi')) {
      botResponse =
          'Saya mengerti Anda merasa sedih. hal apa yang membuat anda sedih saat ini?';
    } else if (userMessage.toLowerCase().contains('cemas') ||
        userMessage.toLowerCase().contains('khawatir') ||
        userMessage.toLowerCase().contains('gelisah')) {
      botResponse =
          'Rasa cemas bisa sangat melelahkan. Ada hal spesifik yang memicu kecemasan Anda?';
    } else if (userMessage.toLowerCase().contains('tidur') ||
        userMessage.toLowerCase().contains('insomnia')) {
      botResponse =
          'Kesulitan tidur seringkali berhubungan dengan stres atau kecemasan. Sudah berapa lama Anda mengalami ini?';
    } else if (userMessage.toLowerCase().contains('stres') ||
        userMessage.toLowerCase().contains('tekanan')) {
      botResponse =
          'Merasa stres itu wajar, terutama saat menghadapi banyak hal. Apa yang paling memberatkan Anda saat ini?';
    } else if (userMessage.toLowerCase().contains('hari') ||
        userMessage.toLowerCase().contains('bulan') ||
        userMessage.toLowerCase().contains('minggu') ||
        userMessage.toLowerCase().contains('tahun') ||
        userMessage.toLowerCase().contains('tugas') ||
        userMessage.toLowerCase().contains('keluarga') ||
        userMessage.toLowerCase().contains('masa depan') ||
        userMessage.toLowerCase().contains('pekerjaan') ||
        userMessage.toLowerCase().contains('kuliah')) {
      // This is a more general catch-all for emotional statements
      botResponse =
          'Terima kasih sudah berbagi perasaan Anda. Kami akan segera menghubungi Terapis yang cocok untuk masalah Anda';
    } else {
      botResponse =
          'Maaf, saya tidak yakin bagaimana merespons itu. Bisakah Anda mencoba kalimat lain atau memperjelas?';
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        _messages.insert(
          0,
          ChatMessage(
            text: botResponse,
            isMe: false,
            avatarPath: 'assets/dr_budi_avatar.png',
          ),
        );
      });
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('SiPeduli Chat'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) => _messages[index],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  // Perbaikan di sini: Gunakan FileImage jika _userAvatarPath tidak null dan file ada
                  backgroundImage:
                      _userAvatarPath != null &&
                              File(_userAvatarPath!).existsSync()
                          ? FileImage(File(_userAvatarPath!))
                              as ImageProvider<Object> // Cast eksplisit
                          : const AssetImage(
                            'assets/user_avatar.png',
                          ), // Default jika tidak ada
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    onSubmitted: _handleSubmitted,
                    decoration: InputDecoration(
                      hintText: 'Enter Something',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: AppColors.lightGrey,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.send, color: AppColors.primaryPurple),
                  onPressed: () => _handleSubmitted(_messageController.text),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
