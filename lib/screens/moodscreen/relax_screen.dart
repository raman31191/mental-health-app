import 'package:flutter/material.dart';

class RelaxScreen extends StatefulWidget {
  const RelaxScreen({super.key});

  @override
  _RelaxScreenState createState() => _RelaxScreenState();
}

class _RelaxScreenState extends State<RelaxScreen> {
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
          title: Text('Relax and Recharge!'),
          content:
              Text('Taking time to relax is important for your well-being.'),
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
      appBar: AppBar(title: Text("Relax and Unwind")),
      body: Center(
        child: Text(
          "Here are some guided meditation sessions for you...",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
