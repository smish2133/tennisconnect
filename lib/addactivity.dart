part of tennisconnect;

class ActivityTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ActivityPage(),
    );
  }
}

class ActivityPage extends StatelessWidget {
  void _scheduleActivityReminder() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'activity channel', // Replace with your channel ID
      'Activity Notifications', // Replace with your channel name
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // Schedule the notification for 10 seconds later
    tz.TZDateTime scheduledTime =
        tz.TZDateTime.from(DateTime.now().add(Duration(seconds: 10)), tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Reminder',
      'Don\'t forget to add an activity!',
      scheduledTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Activity'),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          SizedBox(
            width: 200,
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              icon: Icon(Icons.home),
            ),
          ),
          SizedBox(
            width: 200,
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
              icon: Icon(Icons.group),
            ),
          ),
          SizedBox(
            width: 200,
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/addactivity');
              },
              icon: Icon(Icons.add_circle),
            ),
          ),
          SizedBox(
            width: 200,
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/profile');
              },
              icon: Icon(Icons.person),
            ),
          )
        ],
      ),
      body: ActivityForm(),
    );
  }
}

class ActivityForm extends StatefulWidget {
  @override
  _ActivityFormState createState() => _ActivityFormState();
}

enum MatchOutcome { won, lost }

class _ActivityFormState extends State<ActivityForm> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _activityType = '';
  String _description = '';

  MatchOutcome? _matchOutcome;

  final Map<int, String> _dayOfWeek = {
    1: 'Monday',
    2: 'Tuesday',
    3: 'Wednesday',
    4: 'Thursday',
    5: 'Friday',
    6: 'Saturday',
    7: 'Sunday',
  };

  bool _isTrainingSelected = false;
  bool _isMatchSelected = false;

  void _saveActivity() async {
    try {
      final FirebaseFirestore firestore = FirebaseFirestore.instance;

      DateTime selectedDateTime = DateTime(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        _selectedTime.hour,
        _selectedTime.minute,
      );

      String formattedTime = "${_selectedTime.hour}:${_selectedTime.minute}";
      // Construct the data to be saved
      Map<String, dynamic> activityData = {
        'date': _selectedDate,
        'time': formattedTime,
        'activityType': _activityType,
        'description': _description,
      };

      var value = await firestore.collection('Activities').add(activityData);
      var user = await firestore.collection('Users').doc('userid').get();
      var oldList = user.data()!['Activities'];
      await firestore.collection('Users').doc('userid').update({
        'Activities': [...oldList, value.id]
      });
    } catch (e) {
      print('Error saving activity: $e');
    }
  }

  void _selectActivityType(String type) {
    setState(() {
      _activityType = type;

      if (type == 'Training') {
        _isTrainingSelected = true;
        _isMatchSelected = false;
      } else {
        _isTrainingSelected = false;
        _isMatchSelected = true;

        _promptMatchOutcome();
      }
    });
  }

  void _promptMatchOutcome() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Match Outcome'),
          content: const Text('Did you win or lose the match?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _matchOutcome = MatchOutcome.won;
                });
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Won'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _matchOutcome = MatchOutcome.lost;
                });
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Lost'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Date: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5.0),
                Text(
                  'Day: ${_dayOfWeek[_selectedDate.weekday]}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Time: ${_selectedTime.format(context)}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10.0),
                Row(
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('Select Date'),
                    ),
                    const SizedBox(width: 10.0),
                    ElevatedButton(
                      onPressed: () => _selectTime(context),
                      child: const Text('Select Time'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          const Text(
            'Choose Activity Type:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  _selectActivityType('Training');
                },
                style: ElevatedButton.styleFrom(
                  primary: _isTrainingSelected ? Colors.blue : Colors.grey[300],
                ),
                child: Text(
                  'Training',
                  style: TextStyle(
                    fontWeight: _isTrainingSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  _selectActivityType('Match');
                },
                style: ElevatedButton.styleFrom(
                  primary: _isMatchSelected ? Colors.blue : Colors.grey[300],
                ),
                child: Text(
                  'Match',
                  style: TextStyle(
                    fontWeight:
                        _isMatchSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          const Text(
            'Enter Description:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextFormField(
            onChanged: (value) {
              setState(() {
                _description = value;
              });
            },
            maxLines: 3,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
          Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () async {
                String formattedTime =
                    "${_selectedTime.hour}:${_selectedTime.minute}";

                var result = await FirebaseFirestore.instance
                    .collection('Activities')
                    .add({
                  'date': _selectedDate,
                  'activity_type': _activityType,
                  'description': _description,
                  'time': formattedTime,
                });
                var user = await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(userDocId)
                    .get();
                var oldList = user.data()?['Activities'] ?? [];
                await FirebaseFirestore.instance
                    .collection('Users')
                    .doc(userDocId)
                    .update({
                  'Activities': [...oldList, result.id]
                });
                if (mounted) {
                  Navigator.pushNamed(context, '/home');
                }
              },
              child: Text('Save'),
            ),
          ),
          if (_isMatchSelected && _matchOutcome != null)
            Text(
              'Match Outcome: ${_matchOutcome == MatchOutcome.won ? 'Won' : 'Lost'}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
