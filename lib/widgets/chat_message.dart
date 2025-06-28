// lib/widgets/chat_message.dart
import 'package:flutter/material.dart';
import 'package:sipeduli/utils/app_colors.dart';
import 'dart:io';

class ChatMessage extends StatelessWidget {
  final String text;
  final bool isMe;
  final String? avatarPath;

  const ChatMessage({
    super.key,
    required this.text,
    required this.isMe,
    this.avatarPath,
  });

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> avatarImage;
    if (avatarPath != null && avatarPath!.startsWith('assets/')) {
      // Jika path adalah asset
      avatarImage = AssetImage(avatarPath!);
    } else if (avatarPath != null && File(avatarPath!).existsSync()) {
      // Jika path adalah file lokal dan file tersebut ada
      avatarImage = FileImage(File(avatarPath!));
    } else {
      // Default jika path null, tidak valid, atau file tidak ditemukan
      avatarImage = const AssetImage('assets/user_avatar.png'); // Menggunakan user_avatar sebagai default
    }

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMe)
              CircleAvatar(backgroundImage: avatarImage, radius: 20),
            if (!isMe) const SizedBox(width: 10),
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isMe ? AppColors.primaryPurple : AppColors.lightGrey,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15),
                    bottomLeft:
                        isMe
                            ? const Radius.circular(15)
                            : const Radius.circular(0),
                    bottomRight:
                        isMe
                            ? const Radius.circular(0)
                            : const Radius.circular(15),
                  ),
                ),
                child: Text(
                  text,
                  style: TextStyle(color: isMe ? Colors.white : Colors.black),
                ),
              ),
            ),
            if (isMe) const SizedBox(width: 10),
            if (isMe)
              CircleAvatar(backgroundImage: avatarImage, radius: 20),
          ],
        ),
      ),
    );
  }
}