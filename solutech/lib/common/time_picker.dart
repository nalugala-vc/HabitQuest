import 'package:flutter/material.dart';

class TimePickerScreen extends StatefulWidget {
  @override
  _TimePickerScreenState createState() => _TimePickerScreenState();
}

class _TimePickerScreenState extends State<TimePickerScreen> {
  int _selectedHour = 1; // 1-12
  int _selectedMinute = 0; // 00-59
  String _selectedPeriod = "AM"; // AM or PM

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("12-Hour Time Picker"),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Hour Picker
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 50,
                  perspective: 0.003,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedHour = (index % 12) + 1; // Convert to 1-12
                    });
                  },
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      final hour = (index % 12) + 1; // Ensure 1-12 cycle
                      return Center(
                        child: Text(
                          hour.toString().padLeft(2, '0'),
                          style: TextStyle(
                            fontSize: 24,
                            color: _selectedHour == hour
                                ? Colors.purple
                                : Colors.grey,
                          ),
                        ),
                      );
                    },
                    childCount: 12, // Only 12 hours
                  ),
                ),
              ),
              const Text(
                ":",
                style: TextStyle(fontSize: 24),
              ),
              // Minute Picker
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 50,
                  perspective: 0.003,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedMinute = index;
                    });
                  },
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      if (index >= 0 && index < 60) {
                        return Center(
                          child: Text(
                            index.toString().padLeft(2, '0'),
                            style: TextStyle(
                              fontSize: 24,
                              color: _selectedMinute == index
                                  ? Colors.purple
                                  : Colors.grey,
                            ),
                          ),
                        );
                      }
                      return null;
                    },
                    childCount: 60, // 0-59 minutes
                  ),
                ),
              ),
              // AM/PM Picker
              Expanded(
                child: ListWheelScrollView.useDelegate(
                  itemExtent: 50,
                  perspective: 0.003,
                  onSelectedItemChanged: (index) {
                    setState(() {
                      _selectedPeriod = index == 0 ? "AM" : "PM";
                    });
                  },
                  physics: const FixedExtentScrollPhysics(),
                  childDelegate: ListWheelChildBuilderDelegate(
                    builder: (context, index) {
                      final period = index == 0 ? "AM" : "PM";
                      return Center(
                        child: Text(
                          period,
                          style: TextStyle(
                            fontSize: 24,
                            color: _selectedPeriod == period
                                ? Colors.purple
                                : Colors.grey,
                          ),
                        ),
                      );
                    },
                    childCount: 2, // AM and PM
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          // Display Selected Time
          Text(
            "Selected Time: ${_selectedHour.toString().padLeft(2, '0')}:${_selectedMinute.toString().padLeft(2, '0')} $_selectedPeriod",
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
