import 'package:flutter/material.dart';

class LabelButtonRow extends StatelessWidget {
  final String label;         // Текст слева
  final String buttonText;    // Текст на кнопке
  final VoidCallback onPressed; // Действие

  const LabelButtonRow({
    super.key,
    required this.label,
    required this.buttonText, // Теперь это обязательный параметр
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(label),
        const SizedBox(width: 20),
        ElevatedButton(
          onPressed: onPressed,
          child: Text(buttonText), // Используем переданный текст
        ),
      ],
    );
  }
}