import 'package:flutter/material.dart';
import 'dart:math';

import 'Pass.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: PasswordGenerator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PasswordGenerator extends StatefulWidget {
  @override
  _PasswordGeneratorState createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  bool isDarkMode = false;
  TextEditingController usernameController = TextEditingController();
  List<String> generatedPasswords = [];

  // Password conditions
  bool includeUppercase = false;
  bool includeLowercase = false;
  bool includeNumbers = false;
  bool includeSpecialChars = false;
  bool includeAlphanumeric = false;

  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  void toggleCondition(String condition) {
    setState(() {
      switch (condition) {
        case 'Uppercase':
          includeUppercase = !includeUppercase;
          break;
        case 'Lowercase':
          includeLowercase = !includeLowercase;
          break;
        case 'Numbers':
          includeNumbers = !includeNumbers;
          break;
        case 'SpecialChars':
          includeSpecialChars = !includeSpecialChars;
          break;
        case 'Alphanumeric':
          includeAlphanumeric = !includeAlphanumeric;
          break;
      }
    });
  }

  void submitForm() {
  String username = usernameController.text.trim();
  if (username.isNotEmpty) {
    // Generate 10 passwords for the username
    List<String> newPasswords = List.generate(10, (index) => _generatePassword(username));

    // Navigate to PassPage with generated passwords and replace the current route
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => PassPage(username: username, passwords: newPasswords),
      ),
    );
  }
}


  String _generatePassword(String username) {
    Random random = Random();
    const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#%^&*()";
    String password = List.generate(8, (index) => charset[random.nextInt(charset.length)]).join();
    return "$username-$password";
  }

  Widget buildConditionCheckbox(String label, bool isSelected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: isSelected,
          onChanged: (value) => toggleCondition(label),
        ),
        Text(label),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Password Generator'),
          shadowColor: Color.fromARGB(255, 59, 58, 58),
          elevation: 2,
          actions: [
            IconButton(
              icon: Icon(Icons.brightness_4),
              onPressed: toggleDarkMode,
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Toggle Dark Mode',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Enter your username',
                    labelStyle: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  style: TextStyle(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Password Conditions:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                buildConditionCheckbox('Uppercase', includeUppercase),
                buildConditionCheckbox('Lowercase', includeLowercase),
                buildConditionCheckbox('Numbers', includeNumbers),
                buildConditionCheckbox('SpecialChars', includeSpecialChars),
                buildConditionCheckbox('Alphanumeric', includeAlphanumeric),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: submitForm,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
