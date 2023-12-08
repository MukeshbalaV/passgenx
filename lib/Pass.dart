import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PassPage extends StatelessWidget {
  final String username;
  final List<String> passwords;

  PassPage({required this.username, required this.passwords});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generated Passwords'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Generated Passwords for $username:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: passwords
                  .map((password) => buildPasswordItem(context, password))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildPasswordItem(BuildContext context, String password) {
    return Card(
      child: ListTile(
        title: Text(password),
        trailing: GestureDetector(
          onTap: () => copyToClipboard(context, password),
          child: Icon(Icons.copy),
        ),
      ),
    );
  }

  void copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Password copied to clipboard'),
      ),
    );
  }
}
