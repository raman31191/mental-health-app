import 'package:flutter/material.dart';

class CalmScreen extends StatefulWidget {
  const CalmScreen({super.key});

  @override
  _CalmScreenState createState() => _CalmScreenState();
}

class _CalmScreenState extends State<CalmScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      showAppreciationDialog();
    });
  }

  void showAppreciationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("You're Doing Great!"),
        content: Text("Staying calm is a great skill. Keep it up!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Thank You"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Calm Mode")),
      body: Center(
        child: Text(
          "Here are some relaxing activities and blogs for you.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
