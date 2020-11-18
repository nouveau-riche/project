import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final _fireStoreInst = FirebaseFirestore.instance;
final _firebaseStorageInst = FirebaseStorage.instance;

void saveUserInfo({String uid, String email}) {
  final ref = _fireStoreInst.collection('users').doc(uid);
  ref.set({
    'id': uid,
    'email': email,
    'photoUrl': '',
  });
}

Future<String> uploadImageToFirebaseStorage(String uid, File img) async {
  final ref = _firebaseStorageInst.ref().child('ProfilePictures');
  StorageUploadTask storageUploadTask = ref.child(uid).putFile(img);
  StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask.onComplete;
  String downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();
  return downloadUrl;
}

void uploadTransactionOnFirebase(
    String uid, String transactionId,int amount) {
  final ref = _fireStoreInst
      .collection('transcations')
      .doc(uid)
      .collection('allTranscation')
      .doc();
  ref.set({
    'transactionId': transactionId,
    'timestamp': DateTime.now(),
    'amount': amount
  });
}
