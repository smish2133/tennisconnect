part of tennisconnect;

const FirebaseOptions webOptions = FirebaseOptions(
  apiKey: "AIzaSyCxfgAbL1g3G8r7n0XPge49decvdlIrFeo",
  authDomain: "tennisconnect-db.firebaseapp.com",
  databaseURL:
      "https://tennisconnect-db-default-rtdb.asia-southeast1.firebasedatabase.app",
  projectId: "tennisconnect-db",
  storageBucket: "tennisconnect-db.appspot.com",
  messagingSenderId: "1076982160956",
  appId: "1:1076982160956:web:4a0ad1dc77627ce22e2d39",
  measurementId: "G-N34W6H9JD4",
);

final db = FirebaseFirestore.instance
  ..useFirestoreEmulator(
    '127.0.0.1',
    8082,
  );

class DB {
  static Future<void> init() async {
    await Firebase.initializeApp(
      options: webOptions,
    );
    await db.enablePersistence();
  }
}

class UserData {
  final String username;
  final String password;
  final int points;
  final String dominantHand;
  final String preferredStyle;
  final String strength;
  final String weakness;
  UserData({
    required this.username,
    required this.password,
    required this.points,
    required this.dominantHand,
    required this.preferredStyle,
    required this.strength,
    required this.weakness,
  });
}

class ActivityData {
  final String activity_type;
  final String date;
  final String description;
  final String time;

  ActivityData({
    required this.activity_type,
    required this.date,
    required this.description,
    required this.time,
  });
}

class BookingData {
  final String court;
  final String date;
  final int slot;

  BookingData({
    required this.court,
    required this.date,
    required this.slot,
  });
}

class RankingData {
  final int match_win;
  final int match_loss;
  final int points;

  RankingData({
    required this.match_win,
    required this.match_loss,
    required this.points,
  });
}

List<UserData> sampleUsers = [
  UserData(
      username: 'Satvik',
      password: 'tennis2101',
      points: 150,
      dominantHand: 'right',
      preferredStyle: 'baseline',
      strength: 'i am good',
      weakness: 'i am bad'),
  UserData(
      username: 'user2',
      password: 'password2',
      points: 200,
      dominantHand: 'right',
      preferredStyle: 'baseline',
      strength: 'i am good',
      weakness: 'i am bad'),
  UserData(
      username: 'user3',
      password: 'password3',
      points: 180,
      dominantHand: 'right',
      preferredStyle: 'baseline',
      strength: 'i am good',
      weakness: 'i am bad'),
];
