import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StudentDashboard extends StatefulWidget {
  @override
  _StudentDashboardState createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  String _selectedSubject = 'Math';
  List<String> _subjects = ['Math', 'Science', 'History', 'English'];
  
  // Sample attendance data for different subjects
  Map<String, List<double>> _attendanceData = {
    'Math': [90, 85, 88, 92, 75, 80, 78],
    'Science': [85, 80, 78, 85, 87, 90, 88],
    'History': [80, 82, 88, 80, 84, 86, 82],
    'English': [92, 90, 88, 94, 89, 92, 95],
  };

  // Sample assignment status data
  Map<String, int> _assignmentStatus = {
    'Late/Overdue': 3,
    'Pending': 2,
    'Submitted on time': 5,
  };

  // List of Pending Assignments
  List<String> _pendingAssignments = [
    'Math Homework - Chapter 3',
    'Science Project - Experiment',
    'History Essay - World War II',
  ];

  // Dropdown to select subject
  Widget _buildSubjectDropdown() {
    return DropdownButton<String>(
      value: _selectedSubject,
      onChanged: (String? newValue) {
        setState(() {
          _selectedSubject = newValue!;
        });
      },
      items: _subjects.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  // Line Graph for Attendance
  Widget _buildAttendanceGraph() {
    // Ensure data is not null or empty
    if (_attendanceData[_selectedSubject] == null || _attendanceData[_selectedSubject]!.isEmpty) {
      return Center(child: Text('No data available'));
    }

    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true),
        titlesData: FlTitlesData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: _attendanceData[_selectedSubject]!
                .asMap()
                .entries
                .map((e) => FlSpot(e.key.toDouble(), e.value))
                .toList(),
            isCurved: true,
            barWidth: 4,
            color: Colors.blue,
            belowBarData: BarAreaData(show: false),
          ),
        ],
      ),
    );
  }

  // Calculate total attendance percentage
  double _calculateAttendancePercentage() {
    if (_attendanceData[_selectedSubject] == null || _attendanceData[_selectedSubject]!.isEmpty) {
      return 0.0;
    }

    // Average attendance percentage for the selected subject
    List<double> attendance = _attendanceData[_selectedSubject]!;
    double total = attendance.reduce((a, b) => a + b); // Sum all attendance values
    return total / attendance.length; // Calculate average
  }

  // Pie Chart for Assignment Status
  Widget _buildAssignmentPieChart() {
    // Handle empty or null data case
    if (_assignmentStatus.isEmpty) {
      return Center(child: Text('No assignment data available'));
    }

    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            color: Colors.red,
            value: _assignmentStatus['Late/Overdue']?.toDouble() ?? 0,
            title: 'Late/Overdue',
          ),
          PieChartSectionData(
            color: Colors.yellow,
            value: _assignmentStatus['Pending']?.toDouble() ?? 0,
            title: 'Pending',
          ),
          PieChartSectionData(
            color: Colors.green,
            value: _assignmentStatus['Submitted on time']?.toDouble() ?? 0,
            title: 'On Time',
          ),
        ],
        sectionsSpace: 2,
        centerSpaceRadius: 60,
      ),
    );
  }

  // List of Pending Assignments
  Widget _buildPendingAssignments() {
    // Handle empty or null assignments case
    if (_pendingAssignments.isEmpty) {
      return Center(child: Text('No pending assignments'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _pendingAssignments.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            leading: Icon(Icons.assignment, color: Colors.teal[800]),
            title: Text(_pendingAssignments[index]),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Calculate attendance percentage for selected subject
    double attendancePercentage = _calculateAttendancePercentage() / 100;

    return Scaffold(
      appBar: AppBar(
        title: Text("Student Dashboard"),
        backgroundColor: Colors.teal[800],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Subject Dropdown and Attendance Graph
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Attendance for $_selectedSubject",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  _buildSubjectDropdown(),
                ],
              ),
              SizedBox(height: 10),
              
              // Horizontal Progress Indicator for Attendance
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Attendance: ${(_calculateAttendancePercentage()).toStringAsFixed(1)}%'),
                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: attendancePercentage,
                    backgroundColor: Colors.grey[300],
                    color: Colors.green,
                    minHeight: 8,
                  ),
                ],
              ),
              SizedBox(height: 20),
              
              // Line Chart for Attendance Graph
              Container(
                height: 200,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: _buildAttendanceGraph(),
              ),
              SizedBox(height: 20),

              // Pie Chart for Assignment Status
              Text("Assignment Status",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Container(
                height: 200,
                child: _buildAssignmentPieChart(),
              ),
              SizedBox(height: 20),

              // List of Pending Assignments
              Text("Pending Assignments",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              _buildPendingAssignments(),
            ],
          ),
        ),
      ),
    );
  }
}
