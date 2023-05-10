import 'package:career_paddy/models/bank_model.dart';

class BankAccount {
  final String acc_name;
  final String acc_no;
  final String? hash;
  final String password;
  final BankModel bank;

  Map<String, dynamic> toJson() => {
        'acc_name': acc_name,
        'acc_no': acc_no,
        'password': password,
        'hash': null,
        'bank': bank,
      };

  BankAccount.fromJson(Map<String, dynamic> json)
      : acc_name = json['acc_name'],
        acc_no = json['acc_no'],
        hash = json['hash'],
        password = json['password'],
        bank = BankModel.fromJson(json['bank']);

  BankAccount({
    required this.acc_name,
    required this.acc_no,
    required this.password,
    required this.bank,
    this.hash,
  });
}
