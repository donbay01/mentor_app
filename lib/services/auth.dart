import 'package:career_paddy/constants/role.dart';
import 'package:career_paddy/models/user_experience.dart';
import 'package:career_paddy/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static final auth = FirebaseAuth.instance;
  static final db = FirebaseFirestore.instance;
  static final functions = FirebaseFunctions.instance;

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
      experiences: [],
      isCareerMentor: false,
      isMockInterviewer: false,
      reviewed: false,
    );
    return db.collection('users').doc(uid).set(data.toJson());
  }

  User? getFirebaseUser() => auth.currentUser;

  Future<void> logout() => auth.signOut();

  Future<void> resetPassword(String email) =>
      auth.sendPasswordResetEmail(email: email);

  Future<void> updateProfile({
    required UserModel user,
    required String? gender,
    required String? employment,
    required String? resume,
    required List<String>? interests,
    required String? field,
    required String? company,
    required String? linkedin,
    required String? bio,
    required List<UserExperience> experiences,
  }) {
    var isCompleted = user.has_completed_profile_before;

    if (gender != null &&
        employment != null &&
        resume != null &&
        interests != null &&
        !user.has_completed_profile_before) {
      isCompleted = true;
      complete_profile();
    }

    return db.collection('users').doc(user.uid).update({
      'gender': gender,
      'employment': employment,
      'resume': resume,
      'interests': interests,
      'photoURL': user.photoURL,
      'profileCompleted': isCompleted,
      'linkedin': linkedin,
      'company': company,
      'field': field,
      'bio': bio,
      'has_completed_profile_before': isCompleted,
      'experiences': experiences.map((e) => e.toJson()).toList(),
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
        .where('role', isEqualTo: MENTOR)
        .where('isCareerMentor', isEqualTo: true);
  }

  getInterviewers() {
    var user = getFirebaseUser()!;

    return db
        .collection('users')
        .orderBy('uid')
        .where('uid', isNotEqualTo: user.uid)
        .where('role', isEqualTo: MENTOR)
        .where('isMockInterviewer', isEqualTo: true);
  }

  getNotifications() {
    var user = getFirebaseUser()!;
    return db
        .collection('users')
        .doc(user.uid)
        .collection('notifications')
        .orderBy('timestamp', descending: true);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> search(String query) {
    return db
        .collection('users')
        .where('index.${query.toLowerCase()}', isEqualTo: true)
        .limit(25)
        .get();
  }

  Future<void> updateField(Map<String, dynamic> data) {
    var user = getFirebaseUser()!;

    return db.collection('users').doc(user.uid).update(data);
  }

  Future<dynamic> complete_profile() async {
    var callable = functions.httpsCallable('completedProfile');
    final results = await callable();
    return results.data;
  }

  Future<dynamic> indexInterests() async {
    var callable = functions.httpsCallable('updateUser');
    final results = await callable();
    return results.data;
  }

  static Stream<User?> listenToAuthState() => auth.authStateChanges();
}
