import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) => UserRepositoryImpl(FirebaseAuth.instance));

abstract class UserRepository {
  bool get signedIn;
  Future<void> logout();
}

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl(this._firebaseAuth);

  final FirebaseAuth _firebaseAuth;

  @override
  bool get signedIn => _firebaseAuth.currentUser != null;

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
