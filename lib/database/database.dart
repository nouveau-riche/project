import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStoreInst = FirebaseFirestore.instance;

void saveUserInfoToFirestore(
    {String uid, String name, String imageURL, String email}) {
  final ref = _fireStoreInst.collection('users').doc(uid);

  ref.set({'id': uid, 'name': name, 'email': email, 'imageURL': imageURL});
}

void uploadTransactionOnFirebase(
    {String uid,
    String transactionId,
    int amount,
    String carName,
    String carModel,
    String carNumber,
    bool isSuccessful}) {
  final ref = _fireStoreInst
      .collection('transcations')
      .doc(uid)
      .collection('allTranscation')
      .doc();
  ref.set({
    'transactionId': transactionId,
    'timestamp': DateTime.now(),
    'amount': amount,
    'carName': carName,
    'carModel': carModel,
    'carNumber': carNumber,
    'success': isSuccessful,
  });
}
