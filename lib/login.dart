part of tennisconnect;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to TennisConnect!'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    username = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    password = value;
                  });
                },
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (username == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Enter your username.'),
                    ),
                  );
                }

                if (password == '') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Password field is blank.'),
                    ),
                  );
                }

                var query = await db
                    .collection('Users')
                    .where('username', isEqualTo: username)
                    .where('password', isEqualTo: password)
                    .get();
                if (query.size > 0) {
                  userDocId = query.docs.first.id;
                  userData = query.docs.first.data();
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Login Failed. Please check your username and password.'),
                    ),
                  );
                }
              },
              child: const Text('Login'),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: () {
                // Navigate to the registration page
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationPage()));
              },
              child: const Text('Create a new account?'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  String username = '';
  String password = '';
  String confirmPassword = '';
  String preferredStyle = ''; // Added field for preferred style
  String dominantHand = ''; // Added field for dominant hand
  String strengths = ''; // Added field for strengths
  String weaknesses = '';
  String registrationError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign-Up Page'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Registration',
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(labelText: 'Username'),
                onChanged: (value) => username = value,
              ),
              const SizedBox(height: 10),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                onChanged: (value) => password = value,
              ),
              const SizedBox(height: 10),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Confirm Password',
                ),
                onChanged: (value) => confirmPassword = value,
              ),
              const SizedBox(height: 10),
              // Textfield for Preferred Style
              TextField(
                decoration: const InputDecoration(labelText: 'Preferred Style'),
                onChanged: (value) {
                  setState(() {
                    preferredStyle = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              // Textfield for Dominant Hand
              TextField(
                decoration: const InputDecoration(labelText: 'Dominant Hand'),
                onChanged: (value) {
                  setState(() {
                    dominantHand = value;
                  });
                },
              ),
              const SizedBox(height: 10),
              // Textfield for Strengths
              TextField(
                decoration: const InputDecoration(labelText: 'Strengths'),
                onChanged: (value) => strengths = value,
              ),
              const SizedBox(height: 10),
              // Textfield for Weaknesses
              TextField(
                decoration: const InputDecoration(labelText: 'Weaknesses'),
                onChanged: (value) => weaknesses = value,
              ),

              if (registrationError.isNotEmpty)
                Text(
                  registrationError,
                  style: const TextStyle(color: Colors.red),
                ),

              ElevatedButton(
                onPressed: () async {
                  if (password == confirmPassword) {
                    try {
                      await db.collection('Users').add({
                        'username': username,
                        'password': password,
                        'preferredStyle': preferredStyle,
                        'dominantHand': dominantHand,
                        'strengths': strengths,
                        'weaknesses': weaknesses,
                      });
                      print("Account created");
                      Navigator.pop(context);
                    } catch (e) {
                      print("Error creating account: $e");
                      setState(() {
                        registrationError =
                            'Error creating account. Please try again';
                      });
                    }
                  } else {
                    setState(() {
                      registrationError =
                          'Password does not match. Please re-enter your password.';
                    });
                  }
                },
                child: Text('Register'),
              )
            ],
          ),
        ),
      ),
    );
  }
}


// class RegistrationPage extends StatefulWidget {
//   @override
//   RegistrationPageState createState() => RegistrationPageState();
// }

// class RegistrationPageState extends State<RegistrationPage> {
//   String username = '';
//   String password = '';
//   String confirmPassword = '';
//   String preferredStyle = ''; // Added field for preferred style
//   String dominantHand = ''; // Added field for dominant hand
//   String strengths = ''; // Added field for strengths
//   String weaknesses = ''; // Added field for weaknesses
//   String registrationError = '';

//   // Options for preferred style
//   List<String> preferredStyleOptions = [
//     "Serve and Volley",
//     "Big Server",
//     "Attacking Baseliner",
//     "Solid Baseliner",
//     "Counter Puncher",
//   ];

//   // Options for dominant hand
//   List<String> dominantHandOptions = [
//     "Right Hand",
//     "Left Hand",
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign-Up Page'),
//       ),
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               const Text(
//                 'Registration',
//                 style: TextStyle(fontSize: 20.0),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 decoration: const InputDecoration(labelText: 'Username'),
//                 onChanged: (value) => username = value,
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   labelText: 'Password',
//                 ),
//                 onChanged: (value) => password = value,
//               ),
//               const SizedBox(height: 10),
//               TextField(
//                 obscureText: true,
//                 decoration: const InputDecoration(
//                   labelText: 'Confirm Password',
//                 ),
//                 onChanged: (value) => confirmPassword = value,
//               ),
//               const SizedBox(height: 10),
//               // Dropdown for Preferred Style
//               DropdownButtonFormField(
//                 decoration: const InputDecoration(labelText: 'Preferred Style'),
//                 value: preferredStyle,
//                 items: preferredStyleOptions.map((style) {
//                   return DropdownMenuItem(
//                     value: style,
//                     child: Text(style),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     preferredStyle = value as String;
//                   });
//                 },
//               ),
//               const SizedBox(height: 10),
//               // Dropdown for Dominant Hand
//               DropdownButtonFormField(
//                 decoration: const InputDecoration(labelText: 'Dominant Hand'),
//                 value: dominantHand,
//                 items: dominantHandOptions.map((hand) {
//                   return DropdownMenuItem(
//                     value: hand,
//                     child: Text(hand),
//                   );
//                 }).toList(),
//                 onChanged: (value) {
//                   setState(() {
//                     dominantHand = value as String;
//                   });
//                 },
//               ),
//               const SizedBox(height: 10),
//               // Textfield for Strengths
//               TextField(
//                 decoration: const InputDecoration(labelText: 'Strengths'),
//                 onChanged: (value) => strengths = value,
//               ),
//               const SizedBox(height: 10),
//               // Textfield for Weaknesses
//               TextField(
//                 decoration: const InputDecoration(labelText: 'Weaknesses'),
//                 onChanged: (value) => weaknesses = value,
//               ),

//               if (registrationError.isNotEmpty)
//                 Text(
//                   registrationError,
//                   style: const TextStyle(color: Colors.red),
//                 ),

//               ElevatedButton(
//                 onPressed: () async {
//                   if (password == confirmPassword) {
//                     try {
//                       await db.collection('users').add({
//                         'username': username,
//                         'password': password,
//                         'preferredStyle': preferredStyle,
//                         'dominantHand': dominantHand,
//                         'strengths': strengths,
//                         'weaknesses': weaknesses,
//                       });
//                       print("Account created");
//                       Navigator.pop(context);
//                     } catch (e) {
//                       print("Error creating account: $e");
//                       setState(() {
//                         registrationError =
//                             'Error creating account. Please try again';
//                       });
//                     }
//                   } else {
//                     setState(() {
//                       registrationError =
//                           'Password does not match. Please re-enter your password.';
//                     });
//                   }
//                 },
//                 child: Text('Register'),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }