import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStoreInst = FirebaseFirestore.instance;

void saveUserInfo({String uid, String email}) {
  final ref = _fireStoreInst.collection('users').doc(uid);
  ref.set({
    'id': uid,
    'email': email,
    'photoUrl': '',
  });
}