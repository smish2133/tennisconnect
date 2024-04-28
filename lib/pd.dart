part of tennisconnect;

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Player Statistics'),
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Search bar
            const TextField(
              decoration: InputDecoration(
                labelText: 'Search Player',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
                width: 10.0,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/ranking');
                    },
                    child: const Text('Rankings'))),
            const SizedBox(height: 20.0),
            // Profile section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 20.0),
                // Player details
                Expanded(
                  child: StreamBuilder<DocumentSnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('Users')
                          .doc('KQxQBWpUDv8EZ57a9Oz8')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        }

                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Text(
                              'No data available'); // Handle the case where data is null or not available
                        }

                        var userData =
                            snapshot.data!.data() as Map<String, dynamic>;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8.0),
                            Text(
                              'Name: ${userData['username']}',
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            const Text('Age: XX'),
                            Text(
                              'Preferred Style: ${userData['preferredStyle']}',
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Dominant Hand: ${userData['dominantHand']}',
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ],
                        );
                      }),
                )
              ],
            ),
            const SizedBox(height: 40.0),
            // Head-to-head statistic section
            const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Search Opponent',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20.0),
                // Win rate percentage bar (Placeholder)
                Row(
                  children: [
                    Text(
                      'Win Rate: ',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Expanded(
                      child: LinearProgressIndicator(
                        value:
                            0.75, // Replace with actual win rate value (0.0 - 1.0)
                        backgroundColor: Colors.grey,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      '75%', // Replace with actual win rate percentage
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40.0),

            // Win count section
            const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Player 1 Wins:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      Text(
                        '50', // Replace with actual number of wins for Player 1
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Text(
                      'Player 2 Wins:',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                        '45', // Replace with actual number of wins for Player 2
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ))
                  ])
                ]),
          ],
        ),
      ),
    );
  }
}
