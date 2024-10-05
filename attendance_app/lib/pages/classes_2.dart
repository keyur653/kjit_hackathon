import 'package:flutter/material.dart';
import 'dart:math';

class SubjectListScreen2 extends StatefulWidget {
  @override
  _SubjectListScreen2State createState() => _SubjectListScreen2State();
}

class _SubjectListScreen2State extends State<SubjectListScreen2> {
  final List<Map<String, String>> subjects = [
    {"subject": "Physics", "teacher": "Mr. John Smith"},
    {"subject": "Maths", "teacher": "Mrs. Clara Johnson"},
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
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showAddSubjectDialog(context);
            },
          ),
        ],
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
            );
          },
        ),
      ),
    );
  }

  void _showAddSubjectDialog(BuildContext context) {
    String subjectName = '';
    String teacherName = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Subject'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Subject Name'),
                onChanged: (value) {
                  subjectName = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Teacher Name'),
                onChanged: (value) {
                  teacherName = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (subjectName.isNotEmpty && teacherName.isNotEmpty) {
                  addSubject(subjectName, teacherName);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

class SubjectCard extends StatelessWidget {
  final String subjectName;
  final String teacherName;
  final int cardIndex;

  SubjectCard({required this.subjectName, required this.teacherName, required this.cardIndex});

  final List<List<Color>> gradientColors = [
    [Colors.purple, Colors.blue],
    [Colors.orange, Colors.red],
    [Colors.green, Colors.lightGreenAccent],
    [Colors.pink, Colors.deepOrangeAccent],
    [Colors.cyan, Colors.blueAccent],
    [Colors.amber, Colors.deepOrange],
    [Colors.indigo, Colors.teal],
  ];

  @override
  Widget build(BuildContext context) {
    List<Color> colors = gradientColors[cardIndex % gradientColors.length];

    return Card(
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
