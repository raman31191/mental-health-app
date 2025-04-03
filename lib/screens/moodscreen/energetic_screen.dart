import 'package:flutter/material.dart';

class EnergeticScreen extends StatefulWidget {
  const EnergeticScreen({super.key});

  @override
  _EnergeticScreenState createState() => _EnergeticScreenState();
}

class _EnergeticScreenState extends State<EnergeticScreen> {
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
          title: Text('Stay Energetic!'),
          content: Text('Keep your energy levels high and stay motivated!'),
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
      appBar: AppBar(title: Text("Boost Your Energy")),
      body: Center(
        child: Text(
          "Try some exercises or motivational music to boost your energy!",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
