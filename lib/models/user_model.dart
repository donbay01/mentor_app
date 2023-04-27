import 'package:career_paddy/models/interest_model.dart';
import 'package:career_paddy/models/user_experience.dart';

class UserModel {
  final String first_name;
  final String last_name;
  final String role;
  final String email;
  final String uid;
  final String? photoURL;
  final double rating;
  final String? description;
  final String? phoneNumber;
  final String? gender, employment, resume, linkedin, company, field;
  final List<InterestModel>? interests;
  final bool isCompleted;
  final int courses, sessions, paddy_points, interviews;
  final String? bio;
  final bool has_completed_profile_before, reviewed;
  final List<UserExperience> experiences;
  final bool isCareerMentor, isMockInterviewer;
  final int notifications;

  Map<String, dynamic> toJson() => {
        'first_name': first_name,
        'last_name': last_name,
        'email': email,
        'role': role,
        'uid': uid,
        'rating': rating,
        'phoneNumber': phoneNumber,
        'gender': null,
        'employment': null,
        'resume': null,
        'description': null,
        'interests': null,
        'isCompleted': false,
        'courses': 0,
        'sessions': 0,
        'portfolio': null,
        'bio': bio,
        'has_completed_profile_before': false,
        'paddy_points': 0,
        'isCareerMentor': false,
        'isMockInterviewer': false,
        'photoURL': null,
        'reviewed': false,
        'notifications': 0,
        'interviews': 0,
      };

  UserModel.fromJson(String docId, Map<String, dynamic> json)
      : first_name = json['first_name'],
        last_name = json['last_name'],
        email = json['email'],
        role = json['role'],
        uid = docId,
        photoURL = json['photoURL'],
        rating = json['rating'] == 0 && json['sessions'] == 0
            ? 0.0
            : (json['rating'] / json['sessions']).toDouble(),
        description = json['description'],
        phoneNumber = json['phoneNumber'],
        employment = json['employment'],
        linkedin = json['linkedin'],
        field = json['field'],
        company = json['company'],
        gender = json['gender'],
        bio = json['bio'],
        isCompleted = json['isCompleted'] ?? false,
        paddy_points = json['paddy_points'],
        courses = json['courses'],
        interviews = json['interviews'],
        reviewed = json['reviewed'],
        experiences = json['experiences'] == null
            ? []
            : json['experiences']
                .map((e) => UserExperience.fromJson(e))
                .cast<UserExperience>()
                .toList(),
        sessions = json['sessions'],
        has_completed_profile_before =
            json['has_completed_profile_before'] ?? false,
        interests = json['interests'] != null
            ? json['interests']
                .map((e) => InterestModel.fromString(docId, e))
                .cast<InterestModel>()
                .toList()
            : [],
        resume = json['resume'],
        isCareerMentor = json['isCareerMentor'],
        isMockInterviewer = json['isMockInterviewer'],
        notifications = json['notifications'];

  UserModel({
    required this.first_name,
    required this.last_name,
    required this.role,
    required this.email,
    required this.uid,
    this.photoURL,
    required this.rating,
    this.description,
    this.phoneNumber,
    this.employment,
    this.gender,
    this.interests,
    this.resume,
    required this.isCompleted,
    required this.courses,
    required this.sessions,
    this.linkedin,
    this.company,
    this.field,
    this.bio,
    this.has_completed_profile_before = false,
    this.paddy_points = 0,
    required this.experiences,
    required this.isCareerMentor,
    required this.isMockInterviewer,
    required this.reviewed,
    this.notifications = 0,
    this.interviews = 0,
  });
}
