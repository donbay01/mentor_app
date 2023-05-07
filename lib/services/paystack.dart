import 'dart:convert';

import 'package:career_paddy/models/bank_model.dart';
import 'package:cloud_functions/cloud_functions.dart';

class PayStackService {
  static final functions = FirebaseFunctions.instance;

  static Future<String> verify(String acct_num, String bank_code) async {
    var callable = functions.httpsCallable('verifyBankInformation');
    final resp = await callable.call(<String, dynamic>{
      'acct_num': acct_num,
      'bank_code': bank_code,
    });

    return resp.data['data']['account_name'] as String;
  }

  static Future<List<BankModel>> getBanks() async {
    var callable = functions.httpsCallable('getAllBanks');
    final resp = await callable.call(<String, dynamic>{});

    return resp.data['data']
        .map((dynamic a) => BankModel.fromJson(a))
        .toList()
        .cast<BankModel>();
  }

  static Future<dynamic> save(
    String acc_name,
    String acc_no,
    String password,
  ) async {
    var callable = functions.httpsCallable('saveInformation');
    final resp = await callable.call(<String, dynamic>{
      'acc_name': acc_name,
      'acc_no': acc_no,
      'password': password,
    });

    return resp.data;
  }
}
