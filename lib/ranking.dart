part of tennisconnect;

class RankingPage extends StatelessWidget {
  final List<UserData> users;

  RankingPage(this.users);

  @override
  Widget build(BuildContext context) {
    users.sort((a, b) => b.points
        .compareTo(a.points)); // Sort players by points in descending order

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Ranking Page'),
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
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Text('${index + 1}'), // Display ranking number
              title: Text(users[index].username),
              trailing: Text('${users[index].points} points'),
            );
          },
        ),
      ),
    );
  }
}
