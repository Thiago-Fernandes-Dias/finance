import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/src/models/user_info.dart';
import 'package:firebase_auth/firebase_auth.dart' hide UserInfo;
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepositoryImpl(FirebaseAuth.instance, FirebaseFirestore.instance),
);

abstract class UserRepository {
  bool get signedIn;
  Future<void> logout();
  Stream<UserInfo> userInfoStream();
}

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl(this._firebaseAuth, this._firebaseFirestore);

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firebaseFirestore;

  CollectionReference<UserInfo> get _usersCollection {
    return _firebaseFirestore.collection('users').withConverter<UserInfo>(
          fromFirestore: (snapshot, _) => UserInfo.fromJson(snapshot.data()!),
          toFirestore: (userInfo, _) => userInfo.toJson(),
        );
  }

  @override
  bool get signedIn => _firebaseAuth.currentUser != null;

  @override
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
  
  @override
  Stream<UserInfo> userInfoStream() async* {
    if (signedIn) {
      final userId = _firebaseAuth.currentUser!.uid;
      final docReference = _usersCollection.doc(userId);
      final snapshot = await docReference.get();
      if (!snapshot.exists) {
        const newUser = UserInfo(cash: 10000, stocks: {});
        docReference.set(newUser);
        yield newUser;
      }
      final documentsSnapshots = docReference.snapshots();
      yield* documentsSnapshots.map((doc) => doc.data()!);
    }
  }
}
