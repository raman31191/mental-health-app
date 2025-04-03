import 'package:flutter/material.dart';
import 'package:mental_health/screens/moodscreen/calm_screen.dart';
import 'package:mental_health/screens/moodscreen/energetic_screen.dart';
import 'package:mental_health/screens/moodscreen/focused_screen.dart';
import 'package:mental_health/screens/moodscreen/happy_screen.dart';
import 'package:mental_health/screens/moodscreen/relax_screen.dart';
import 'package:mental_health/screens/notes_screen.dart';
import 'package:mental_health/screens/quiz_option.dart';

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});

  @override
  HomeScreenContentState createState() => HomeScreenContentState();
}

void _showConfirmationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Drink Water Reminder"),
        content:
            const Text("You've completed the task! Want to set a reminder?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              scheduleWaterReminder(); // Call the alarm function
            },
            child: const Text("OK"),
          ),
        ],
      );
    },
  );
}

void scheduleWaterReminder() {
  print("Water reminder alarm set!");
}

class HomeScreenContentState extends State<HomeScreenContent> {
  final List<Map<String, dynamic>> moods = [
    {
      'label': 'Happy',
      'image': 'images/happy.png',
      'screen': HappyMoodScreen()
    },
    {'label': 'Calm', 'image': 'images/calm.png', 'screen': const CalmScreen()},
    {
      'label': 'Relax',
      'image': 'images/relaxation.png',
      'screen': const RelaxScreen()
    },
    {
      'label': 'Energetic',
      'image': 'images/energy.png',
      'screen': const EnergeticScreen()
    },
    {
      'label': 'Focused',
      'image': 'images/focused.png',
      'screen': const FocusedScreen()
    },
  ];

  final List<Map<String, String>> tasks = [
    {'title': 'Meditation', 'description': 'Spend 10 mins meditating'},
    {
      'title': 'Gratitude Journal',
      'description': 'Write 3 things you are grateful for'
    },
    {'title': 'Go for a Walk', 'description': 'Take a 15 min walk outside'},
    {
      'title': 'Drink Water',
      'description': 'Stay hydrated with at least 8 glasses'
    },
    {'title': 'Read a Book', 'description': 'Read at least 10 pages of a book'},
    {'title': 'Listen to Music', 'description': 'Enjoy some relaxing music'},
    {'title': 'Stretching', 'description': 'Do a 5-minute full-body stretch'},
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome Back!",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text("How are you feeling today?",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                _buildMoodScroll(),
                const SizedBox(height: 20),
                _buildTestCard(context),
                const SizedBox(height: 20),
                _buildNotesCard(context),
                const SizedBox(height: 20),
                Text("Daily Reminder!",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                _buildTaskScroll(screenWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMoodScroll() {
    return SizedBox(
      height: 80,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: moods.map((mood) {
          return MoodButton(
            label: mood['label']!,
            imagePath: mood['image']!,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => mood['screen']),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  Widget _buildTestCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Take a Test',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text('Assess your current mental well-being with a quick test.',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TestSelectionScreen()));
              },
              child: const Text('Start Test'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Jot down your thoughts!',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text('Take notes, suggest things, share your thoughts!',
              style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotesScreen()));
              },
              child: const Text('Open!'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskScroll(double screenWidth) {
    return SizedBox(
      height: 400,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return _buildTaskCard(screenWidth, tasks[index]['title']!,
              tasks[index]['description']!);
        },
      ),
    );
  }

  Widget _buildTaskCard(double screenWidth, String title, String description) {
    return Container(
      width: screenWidth * 0.9,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 5),
          Text(description, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
              onPressed: () {
                if (title == 'Drink Water') {
                  _showConfirmationDialog(context);
                }
              },
              child: const Text("Complete"),
            ),
          ),
        ],
      ),
    );
  }
}

class MoodButton extends StatelessWidget {
  final String label;
  final String imagePath;
  final VoidCallback onTap;

  const MoodButton({
    super.key,
    required this.label,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 90,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imagePath, width: 35, height: 35),
            const SizedBox(height: 5),
            Text(label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
