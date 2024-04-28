part of tennisconnect;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class CourtBooking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tennis Court Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookingPage(),
    );
  }
}

class BookingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tennis Court Booking'),
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
              icon: const Icon(Icons.home),
            ),
          ),
          SizedBox(
            width: 200,
            child: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/addactivity');
              },
              icon: const Icon(Icons.add_circle),
            ),
          ),
          SizedBox(
            width: 200,
            child: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile');
              },
              icon: const Icon(Icons.person),
            ),
          )
        ],
      ),
      body: BookingForm(),
    );
  }
}

class BookingForm extends StatefulWidget {
  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  DateTime _selectedDate = DateTime.now();
  String _selectedCourt = '';
  List<String> selectedSlots = [];

  void _saveBooking() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    Map<String, dynamic> bookingData = {
      'date': _selectedDate!.toIso8601String(),
      'courtNumber': _selectedCourt,
      'timeSlots': selectedSlots,
    };

    var value = await firestore.collection('Booking').add(bookingData);
    var user = await firestore.collection('Users').doc('userid').get();
    var oldList = user.data()!['Bookings'];
    await firestore.collection('Users').doc('userid').update({
      'Bookings': [...oldList, value.id]
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Select Date:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 1),
              );
              if (pickedDate != null) {
                setState(() {
                  _selectedDate = pickedDate;
                });
              }
            },
            child: Text(_selectedDate == null
                ? 'Choose Date'
                : _selectedDate.toString().substring(0, 10)),
          ),
          const SizedBox(height: 20),
          const Text(
            'Select Court:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Column(
            children: [
              RadioListTile(
                title: const Text('Court 1'),
                value: 'Court 1',
                groupValue: _selectedCourt,
                onChanged: (value) {
                  setState(() {
                    _selectedCourt = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: const Text('Court 2'),
                value: 'Court 2',
                groupValue: _selectedCourt,
                onChanged: (value) {
                  setState(() {
                    _selectedCourt = value.toString();
                  });
                },
              ),
              RadioListTile(
                title: const Text('Court 3'),
                value: 'Court 3',
                groupValue: _selectedCourt,
                onChanged: (value) {
                  setState(() {
                    _selectedCourt = value.toString();
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Select Slots (Max 2):',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  for (int hour = 7; hour <= 17; hour++)
                    CheckboxListTile(
                      title: Text(
                          '$hour:00 - ${(hour + 1).toString().padLeft(2, '0')}:00'),
                      value: selectedSlots.contains(hour.toString()),
                      onChanged: (value) {
                        setState(() {
                          if (value != null && value) {
                            if (selectedSlots.length < 2) {
                              selectedSlots.add(hour.toString());
                            }
                          } else {
                            selectedSlots.remove(hour.toString());
                          }
                        });
                      },
                    ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () async {
                var value = await _firestore.collection('Booking').add({
                  'date': _selectedDate!.toIso8601String(),
                  'courtNumber': _selectedCourt,
                  'timeSlots': selectedSlots,
                });
                var user =
                    await _firestore.collection('Users').doc(userDocId).get();
                var oldList = user?.data()?['Booking'] ?? [];
                await _firestore.collection('Users').doc(userDocId).update({
                  'Booking': [...oldList, value.id]
                });
                if (mounted) {
                  Navigator.pushNamed(context, '/home');
                }
              },
              child: const Text('Book'),
            ),
          )
        ],
      ),
    );
  }
}
