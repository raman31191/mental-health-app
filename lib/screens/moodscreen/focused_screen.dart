import 'package:flutter/material.dart';

class FocusedScreen extends StatefulWidget {
  const FocusedScreen({super.key});

  @override
  _FocusedScreenState createState() => _FocusedScreenState();
}

class _FocusedScreenState extends State<FocusedScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      _showAppreciationDialog();
    });
  }

  void _showAppreciationDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Great Choice!'),
          content: Text('Focusing on your tasks will bring great results.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Thank You!'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stay Focused")),
      body: Center(
        child: Text(
          "Here are some productivity tips to stay focused...",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
