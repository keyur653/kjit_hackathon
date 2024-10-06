import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  // Normalize DateTime to remove time part
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  // Updated attendance map with normalized dates
  Map<DateTime, String> _attendance = {
    DateTime.utc(2024, 10, 1): 'present',
    DateTime.utc(2024, 10, 2): 'absent',
    DateTime.utc(2024, 10, 3): 'present',
    DateTime.utc(2024, 10, 4): 'not_conducted',
    DateTime.utc(2024, 10, 5): 'absent',
    DateTime.utc(2024, 10, 6): 'present',
    DateTime.utc(2024, 10, 7): 'not_conducted',
  };

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // Get color for each day based on attendance
  Color _getDayColor(DateTime day) {
    DateTime normalizedDay = _normalizeDate(day);
    if (_attendance.containsKey(normalizedDay)) {
      switch (_attendance[normalizedDay]) {
        case 'present':
          return Colors.green;
        case 'absent':
          return Colors.red;
        case 'not_conducted':
          return Colors.grey;
        default:
          return Colors.grey;
      }
    } else {
      return Colors.grey;
    }
  }

  // Calculate the attendance percentage
  double _calculateAttendancePercentage() {
    int totalDays = _attendance.length;
    int presentDays = _attendance.values.where((status) => status == 'present').length;
    return totalDays == 0 ? 0 : presentDays / totalDays;
  }

  @override
  Widget build(BuildContext context) {
    double attendancePercentage = _calculateAttendancePercentage(); // Calculate attendance percentage

    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance & Announcements"),
        backgroundColor: Colors.teal[800],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // Calendar covering half the screen
              Container(
                height: constraints.maxHeight * 0.4, // Reduce to fit progress bar
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: TableCalendar(
                    focusedDay: _focusedDay,
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    },
                    calendarFormat: _calendarFormat,
                    onFormatChanged: (format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    },
                    calendarBuilders: CalendarBuilders(
                      // Use the defaultBuilder to control the colors
                      defaultBuilder: (context, day, focusedDay) {
                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _getDayColor(focusedDay),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Text(
                            '${day.day}',
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Attendance percentage progress bar
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  children: [
                    Text(
                      'Attendance: ${(attendancePercentage * 100).toStringAsFixed(1)}%',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    LinearProgressIndicator(
                      value: attendancePercentage,
                      backgroundColor: Colors.grey[300],
                      color: Colors.green,
                      minHeight: 10,
                    ),
                  ],
                ),
              ),
              // Scrollable cards for announcements and materials
              Expanded(
                child: ListView.builder(
                  itemCount: 5, // Just for example, you can have dynamic count
                  itemBuilder: (context, index) {
                    return Card(
                      margin: EdgeInsets.all(8.0),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.announcement, color: Colors.teal[800]),
                        title: Text('Announcement $index'),
                        subtitle: Text('Details about the announcement or material posted.'),
                        trailing: Icon(Icons.arrow_forward_ios, color: Colors.teal[800]),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
