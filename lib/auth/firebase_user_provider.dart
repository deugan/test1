import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class Test1FirebaseUser {
  Test1FirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

Test1FirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<Test1FirebaseUser> test1FirebaseUserStream() => FirebaseAuth.instance
    .authStateChanges()
    .debounce((user) => user == null && !loggedIn
        ? TimerStream(true, const Duration(seconds: 1))
        : Stream.value(user))
    .map<Test1FirebaseUser>((user) => currentUser = Test1FirebaseUser(user));
