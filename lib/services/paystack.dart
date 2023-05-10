import 'package:career_paddy/models/bank_account.dart';
import 'package:career_paddy/models/bank_model.dart';
import 'package:cloud_functions/cloud_functions.dart';

class PayStackService {
  static final functions = FirebaseFunctions.instance;

  static Future<String> verify(
    String acct_num,
    String bank_code,
    // String type,
    // String currency,
  ) async {
    var callable = functions.httpsCallable('verifyBankInformation');
    final resp = await callable.call(<String, dynamic>{
      'acct_num': acct_num,
      'bank_code': bank_code,
      // 'type': type,
      // 'currency': currency,
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
    BankModel bank,
  ) async {
    var callable = functions.httpsCallable('saveInformation');
    final resp = await callable.call(<String, dynamic>{
      'acc_name': acc_name,
      'acc_no': acc_no,
      'password': password,
      'bank': bank.toJson(),
    });

    return resp.data;
  }

  static Future<void> withdraw(String password, int amount) async {
    var callable = functions.httpsCallable('withdrawPoints');
    final resp = await callable.call(<String, dynamic>{
      'password': password,
      'amount': amount,
    });

    return resp.data;
  }
}
