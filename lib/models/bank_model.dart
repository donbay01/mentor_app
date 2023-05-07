class BankModel {
  final int id;
  final String? updatedAt;
  final String name;
  final String country;
  final bool active;
  final bool pay_with_bank;
  final String? nuban;
  final String code;
  final String? longcode;
  final String? slug;
  final bool is_deleted;
  final String? gateway;
  final String currency;
  final String? createdAt;

  BankModel.fromJson(dynamic json)
      : id = json['id'],
        updatedAt = json['updatedAt'],
        name = json['name'],
        country = json['country'],
        active = json['active'],
        pay_with_bank = json['pay_with_bank'],
        nuban = json['nuban'],
        code = json['code'],
        longcode = json['longcode'],
        slug = json['slug'],
        is_deleted = json['is_deleted'],
        gateway = json['gateway'],
        currency = json['currency'],
        createdAt = json['createdAt'];

  BankModel({
    required this.id,
    required this.updatedAt,
    required this.name,
    required this.country,
    required this.active,
    required this.pay_with_bank,
    required this.nuban,
    required this.code,
    required this.longcode,
    required this.slug,
    required this.is_deleted,
    required this.gateway,
    required this.currency,
    required this.createdAt,
  });
}
