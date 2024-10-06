import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({Key? key}) : super(key: key);

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  Map<DateTime, String> _attendance = {
    DateTime.now().subtract(Duration(days: 2)): 'present',
    DateTime.now().subtract(Duration(days: 1)): 'absent',
    DateTime.now(): 'present',
    DateTime.now().add(Duration(days: 1)): 'not_conducted',
  };

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  Color _getDayColor(DateTime day) {
    if (_attendance.containsKey(day)) {
      switch (_attendance[day]) {
        case 'present':
          return Colors.green;
        case 'absent':
          return Colors.red;
        default:
          return Colors.grey;
      }
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                height: constraints.maxHeight * 0.5, // Half the available height
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
                      defaultBuilder: (context, day, focusedDay) {
                        return Container(
                          margin: const EdgeInsets.all(4.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: _getDayColor(day),
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
