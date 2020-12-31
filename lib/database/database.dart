import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

final _fireStoreInst = FirebaseFirestore.instance;

void saveUserInfoToFirestore(
    {String uid, String name, String imageURL, String email}) {
  final ref = _fireStoreInst.collection('users').doc(uid);

  ref.set({
    'id': uid,
    'name': name,
    'email': email,
    'imageURL': imageURL,
  });
}

void uploadTransactionOnFirebase(
    {String uid,
    String transactionId,
    int amount,
    String carName,
    String carModel,
    String carNumber,
    bool isSuccessful,
    String name,
    String contact,
    String address,
    String pinCode}) {
  var rng = new Random();
  var code = rng.nextInt(100000000);

  final ref = _fireStoreInst
      .collection('transactions')
      .doc(uid)
      .collection('allTransaction')
      .doc();
  ref.set({
    'transactionId': transactionId,
    'timestamp': DateTime.now(),
    'amount': amount,
    'carName': carName,
    'carModel': carModel,
    'carNumber': carNumber,
    'success': isSuccessful,
    'name': name,
    'contact': contact,
    'address': address,
    'pinCode': pinCode,
    'orderId': '$code',
    'docId': ref.id
  });

  final ref1 = _fireStoreInst.collection('portal').doc(ref.id);
  ref1.set({
    'transactionId': transactionId,
    'timestamp': DateTime.now(),
    'amount': amount,
    'carName': carName,
    'carModel': carModel,
    'carNumber': carNumber,
    'success': isSuccessful,
    'name': name,
    'contact': contact,
    'address': address,
    'pinCode': pinCode,
    'orderId': '$code',
    'assignTo': null,
    'docId': ref.id
  });
}

void updateDetails(String uid, String contact, String address) {
  final ref = _fireStoreInst.collection('users').doc(uid);
  ref.update({'contact': contact, 'address': address});
}
