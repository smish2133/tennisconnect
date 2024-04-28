import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tennis Connect'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/pd');
                },
                child: const Text('Player Data'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/tip');
                },
                child: const Text('Tips'),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/activity');
                },
                child: const Text('Activity Log'),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/book');
                },
                child: const Text('Book a Court'),
              ),
            ),
            Expanded(
              child: Container(),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Next Activity:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Match Title: Your Match Title',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Date: DD/MM/YYYY',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Time: HH:MM AM/PM',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(),
            ),
            // Bottom Row of Buttons
            Row(
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
          ],
        ),
      ),
    );
  }
}
