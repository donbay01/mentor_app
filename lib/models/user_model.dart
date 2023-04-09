import 'package:career_paddy/models/interest_model.dart';

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
  final String? gender, employment, resume;
  final List<InterestModel>? interests;

  Map<String, dynamic> toJson() => {
        'first_name': first_name,
        'last_name': last_name,
        'email': email,
        'role': role,
        'uid': uid,
        'rating': rating,
        'phoneNumber': phoneNumber
      };

  UserModel.fromJson(String docId, Map<String, dynamic> json)
      : first_name = json['first_name'],
        last_name = json['last_name'],
        email = json['email'],
        role = json['role'],
        uid = docId,
        photoURL = json['photoURL'],
        rating = json['rating'].toDouble(),
        description = json['description'],
        phoneNumber = json['phoneNumber'],
        employment = json['employment'],
        gender = json['gender'],
        interests = json['interests'] != null
            ? json['interests']
                .map((e) => InterestModel.fromString(docId, e))
                .cast<InterestModel>()
                .toList()
            : [],
        resume = json['resume'];

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
  });
}
