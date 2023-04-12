import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final auth = FirebaseAuth.instance;
  static final db = FirebaseFirestore.instance;

  Future<UserCredential> createAccount({
    required String email,
    required String password,
    required String displayName,
  }) async {
    var userCred = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    var user = userCred.user!;
    await user.updateDisplayName(displayName);
    await user.sendEmailVerification();
    return userCred;
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    var userCred = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCred;
  }

  // Future<UserCredential> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;

  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );

  //   return await auth.signInWithCredential(credential);
  // }

  Future<void> createProfile({
    required String first_name,
    required String last_name,
    required String email,
    required String role,
    required String uid,
    required String phone,
  }) {
    var data = UserModel(
      first_name: first_name,
      last_name: last_name,
      role: role,
      email: email,
      uid: uid,
      rating: 0.0,
      phoneNumber: phone,
      isCompleted: false,
      sessions: 0,
      courses: 0,
    );
    return db.collection('users').doc(uid).set(data.toJson());
  }

  User? getFirebaseUser() => auth.currentUser;

  Future<void> logout() => auth.signOut();

  Future<void> resetPassword(String email) =>
      auth.sendPasswordResetEmail(email: email);

  Future<void> updateProfile({
    required String? gender,
    required String? employment,
    required String? resume,
    required List<String>? interests,
  }) {
    var user = getFirebaseUser()!;
    var isCompleted = false;

    if (gender != null &&
        employment != null &&
        resume != null &&
        interests != null) {
      isCompleted = true;
    }

    return db.collection('users').doc(user.uid).update({
      'gender': gender,
      'employment': employment,
      'resume': resume,
      'interests': interests,
      'photoURL': user.photoURL,
      'profileCompleted': isCompleted,
    });
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> listen(String uid) =>
      db.collection('users').doc(uid).snapshots();

  Stream<QuerySnapshot<Map<String, dynamic>>> getInterests() =>
      db.collection('interests').orderBy('name').snapshots();

  Stream<User?> listenToAuth() => auth.userChanges();

  getMentors() {
    var user = getFirebaseUser()!;

    return db
        .collection('users')
        .orderBy('uid')
        .where('uid', isNotEqualTo: user.uid)
        .where('role', isEqualTo: MENTOR);
  }

  getNotifications() {
    var user = getFirebaseUser()!;
    return db
        .collection('users')
        .doc(user.uid)
        .collection('notifications')
        .orderBy('timestamp');
  }
}
