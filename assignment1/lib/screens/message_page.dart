import 'package:flutter/material.dart';

import '../widgets/gradient_button.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  String _message = 'Hello, Flutter!';

  void _toggleMessage() {
    setState(() {
      if (_message == 'Hello, Flutter!') {
        _message = 'Flutter is awesome!';
      } else {
        _message = 'Hello, Flutter!';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _message,
              style: const TextStyle(fontSize: 26),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 18),
            GradientButton(text: 'Change Message', onPressed: _toggleMessage),
          ],
        ),
      ),
    );
  }
}
