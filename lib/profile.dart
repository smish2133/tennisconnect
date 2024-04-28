part of tennisconnect;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Mock data for the pie chart (replace with actual values)
  Map<String, double> dataMap = {
    'Wins': 70,
    'Losses': 30,
  };

  Future<void> _loadUserData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    QuerySnapshot userData =
        await users.where('userId', isEqualTo: 'orq0OWIjrL2ngBzjBs1b').get();

    if (userData.docs.isNotEmpty) {
      var user = userData.docs.first.data() as Map<String, dynamic>;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection('Users')
                    .doc('iCZsS0UvU8xYfIgTjqMz')
                    .get(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    var user = snapshot.data?.data() as Map<String, dynamic>;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          '${user['username']}',
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('Age: XX'),
                        Text(
                          'Preferred Style: ${user['preferredStyle']}',
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          'Dominant Hand: ${user['dominantHand']}',
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          'Strengths: ${user['strengths']}',
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        Text(
                          'Weaknesses: ${user['weaknesses']}',
                          style: const TextStyle(
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Win-Loss Chart',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Container(
                width: 300.0,
                height: 300.0,
                child: PieChart(
                  dataMap: dataMap,
                  chartType: ChartType.ring,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
