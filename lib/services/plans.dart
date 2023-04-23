import 'package:career_paddy/models/plan_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';

class PlanService {
  static final db = FirebaseFirestore.instance;
  static final functions = FirebaseFunctions.instance;

  static getPlans() => db.collection('plans').orderBy('sessions');

  static getLink(PlanModel plan) async {
    HttpsCallable callable = functions.httpsCallable('genPayLink');
    final resp = await callable.call(<String, dynamic>{
      'amount': plan.amount,
    });

    return resp.data['data']['authorization_url'];
  }
}
