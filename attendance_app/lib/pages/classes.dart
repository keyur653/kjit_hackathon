import 'package:attendance_app/pages/class_detail.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/theme.dart';

class SubjectListScreen extends StatefulWidget {
  @override
  _SubjectListScreenState createState() => _SubjectListScreenState();
}

class _SubjectListScreenState extends State<SubjectListScreen> {
  final List<Map<String, String>> subjects = [
    {"subject": "Mathematics", "teacher": "Mr. John Smith"},
    {"subject": "Physics", "teacher": "Mrs. Clara Johnson"},
    {"subject": "Chemistry", "teacher": "Mr. Michael Brown"},
    {"subject": "English Literature", "teacher": "Ms. Emily Davis"},
    {"subject": "Biology", "teacher": "Dr. Susan Wilson"},
    {"subject": "Computer Science", "teacher": "Mr. David Clark"},
    {"subject": "History", "teacher": "Mrs. Mary Lewis"},
  ];

  void addSubject(String subjectName, String teacherName) {
    setState(() {
      subjects.add({"subject": subjectName, "teacher": teacherName});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Classroom Subjects'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: CustomTheme.primaryGradient,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView.builder(
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            return SubjectCard(
              subjectName: subjects[index]["subject"]!,
              teacherName: subjects[index]["teacher"]!,
              cardIndex: index,
              onTap: () {
                // Navigate to SubjectDetailScreen when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendancePage(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String subjectName;
  final String teacherName;
  final int cardIndex;
  final VoidCallback onTap;

  SubjectCard({
    required this.subjectName,
    required this.teacherName,
    required this.cardIndex,
    required this.onTap,
  });

  final List<List<Color>> gradientColors = [
    [CustomTheme.loginGradientStart, CustomTheme.loginGradientEnd],
    [Colors.purple, Colors.blue],
    [Colors.green, Colors.lightGreenAccent],
    [Colors.pink, Colors.deepOrangeAccent],
    [Colors.cyan, Colors.blueAccent],
    [Colors.amber, Colors.deepOrange],
    [Colors.indigo, Colors.teal],
  ];

  @override
  Widget build(BuildContext context) {
    List<Color> colors = gradientColors[cardIndex % gradientColors.length];

    return InkWell(
      onTap: onTap, // Handle tap event
      borderRadius: BorderRadius.circular(15), // Match card's border radius for ripple effect
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 8,
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      _getRandomIcon(),
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        subjectName,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.person_rounded, color: Colors.white70),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Teacher: $teacherName",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _getRandomIcon() {
    List<IconData> icons = [
      Icons.book,
      Icons.science,
      Icons.calculate,
      Icons.computer,
      Icons.history,
      Icons.biotech,
      Icons.language,
    ];
    return icons[cardIndex % icons.length];
  }
}

// New page to display subject details
