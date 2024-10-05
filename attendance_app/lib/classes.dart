import 'package:flutter/material.dart';

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
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Show a dialog to add a new subject
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

  SubjectCard({required this.subjectName, required this.teacherName});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 8,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          // image: DecorationImage(
          //   image: AssetImage('assets/background.png'), // Add a background image
          //   fit: BoxFit.cover,
          //   colorFilter:
          //       ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.darken),
          // ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.book_rounded, color: Colors.white, size: 28),
                  SizedBox(width: 10),
                  Text(
                    subjectName,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.person_rounded, color: Colors.white70),
                  SizedBox(width: 10),
                  Text(
                    "Teacher: $teacherName",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
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
}