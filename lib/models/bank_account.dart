class BankAccount {
  final String acc_name;
  final String acc_no;
  final String? hash;

  BankAccount.fromJson(Map<String, dynamic> json)
      : acc_name = json['acc_name'],
        acc_no = json['acc_no'],
        hash = json['hash'];

  BankAccount({
    required this.acc_name,
    required this.acc_no,
    this.hash,
  });
}
