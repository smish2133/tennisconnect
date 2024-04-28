part of tennisconnect;

class ActivityLogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity Log',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ActivityLogPage(),
    );
  }
}

class ActivityLogPage extends StatefulWidget {
  @override
  _ActivityLogPageState createState() => _ActivityLogPageState();
}

class _ActivityLogPageState extends State<ActivityLogPage> {
  List<Map<String, String>> trainingHistory = [];
  List<Map<String, String>> matchHistory = [];
  List<Map<String, String>> currentHistory = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Activity Log'),
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
                  Navigator.pushReplacementNamed(context, '/profile');
                },
                icon: const Icon(Icons.person),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () async {
                  List<Map<String, String>> trainingData =
                      await _fetchData('training');
                  setState(() {
                    currentHistory = trainingData;
                  });
                },
                child: const Text('Training'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  List<Map<String, String>> matchData =
                      await _fetchData('matches');
                  setState(() {
                    currentHistory = matchData;
                  });
                },
                child: const Text('Matches'),
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Activity History',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: DataTable(
                  columns: [
                    const DataColumn(label: Text('Date')),
                    const DataColumn(label: Text('Description')),
                  ],
                  rows: currentHistory.map<DataRow>((activity) {
                    return DataRow(cells: [
                      DataCell(Text(activity['date'] ?? '')),
                      DataCell(Text(activity['description'] ?? '')),
                    ]);
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, String>>> _fetchData(String activityType) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Activities')
        .where('activity_type', isEqualTo: activityType)
        .get();

    return snapshot.docs
        .map((doc) => doc.data() as Map<String, String>)
        .toList();
  }
}