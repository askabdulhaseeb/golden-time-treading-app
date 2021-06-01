import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:golden_time_treading_app/Auth/shared_preferences_helper.dart';

// all database methods are here
class DatabaseMethods {
  // add new user's info on firebase
  Future addUserInfoToDB(
      String userId, Map<String, dynamic> userInfoMap) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .set(userInfoMap);
  }

  // upgrade user to a VIP user on firebase
  updateUserToVIP(uid) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .update({'isVIP': true});
  }

  // get a user info with the help of unique user id
  Future<DocumentSnapshot> getUserInfo(uid) async {
    return await FirebaseFirestore.instance.collection("users").doc(uid).get();
  }

  // get user by his email
  Future<Stream<QuerySnapshot>> getUserByEmail() async {
    return FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: SharedPreferenceHelper().getUserEmail())
        .snapshots();
  }

  // add new message to firebase live support collection
  addMessageToFirebaseLiveSupport(messageMap) async {
    await FirebaseFirestore.instance
        .collection('LiveSupport')
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  // get all the message from firebase
  Future<Stream<QuerySnapshot>> getMessageToFirebaseLiveSupport() async {
    return FirebaseFirestore.instance
        .collection('LiveSupport')
        .orderBy("ts", descending: true)
        .snapshots();
  }

  // Local Signals
  // geting all the local signal
  Future<Stream<QuerySnapshot>> getLocalSignalFromFirebase(
      String search) async {
    return FirebaseFirestore.instance
        .collection('local')
        .where('name', isGreaterThanOrEqualTo: search.toUpperCase())
        .snapshots();
  }

  // fetch complete ingo of a local signal from firebase
  Future<DocumentSnapshot> getDataOfOneLocalSignalBySIDFromFirebase(
      String sid) async {
    return await FirebaseFirestore.instance
        .collection('local')
        .doc(sid)
        .get()
        .catchError((Object obj) {
      print('Error in Database');
    });
  }

  // update local signal info on firebase
  updateLocalSignalInfoOnFirebase(
      String sid, Map<String, dynamic> localMap) async {
    await FirebaseFirestore.instance
        .collection('local')
        .doc(sid)
        .update(localMap);
  }

  // get live feed messahe from the firebase
  Future<Stream<QuerySnapshot>> getLiveFeedSignalFromFirebase(
      String search) async {
    return FirebaseFirestore.instance
        .collection('LiveFeed')
        .where('name', isGreaterThanOrEqualTo: search.toUpperCase())
        .snapshots();
  }

  // add local signals to firebase
  addLocalSignalsToFirebase(messageMap) async {
    // String _sid;
    CollectionReference _localReference =
        await FirebaseFirestore.instance.collection('local');
    _localReference.add(messageMap).then((value) async {
      value.update({'sid': value.id});
    }).catchError((e) {
      print(e.toString());
    });
  }

  // delete local signals to firebase
  deleteLocalSignalFromFirebase(String sid) async {
    await FirebaseFirestore.instance.collection('local').doc(sid).delete().then(
          (value) => Fluttertoast.showToast(
            msg: 'Signal Deleted',
          ),
        );
  }

  // Live Feed
  addLiveFeedSignalsToFirebase(messageMap) async {
    // String _sid;
    CollectionReference _localReference =
        await FirebaseFirestore.instance.collection('LiveFeed');
    _localReference.add(messageMap).then((value) async {
      value.update({'sid': value.id});
    }).catchError((e) {
      print(e.toString());
    });
  }

  // get Data Of One LiveFeedSignal By SID From Firebase
  Future<DocumentSnapshot> getDataOfOneLiveFeedSignalBySIDFromFirebase(
      String sid) async {
    return await FirebaseFirestore.instance
        .collection('LiveFeed')
        .doc(sid)
        .get()
        .catchError((Object obj) {
      print('Error in Database');
    });
  }

  // update Data Of One LiveFeedSignal By SID From Firebase
  updateLiveFeedSignalInfoOnFirebase(
      String sid, Map<String, dynamic> localMap) async {
    await FirebaseFirestore.instance
        .collection('LiveFeed')
        .doc(sid)
        .update(localMap);
  }

  // delete Data Of One LiveFeedSignal By SID From Firebase
  deleteLiveFeedSignalFromFirebase(String sid) async {
    await FirebaseFirestore.instance
        .collection('LiveFeed')
        .doc(sid)
        .delete()
        .then(
          (value) => Fluttertoast.showToast(msg: 'Signal Deleted'),
        );
  }
}
