class WalletAssetsModel {
  /// {
  //   "address": "string",
  //   "balances": [
  //     {
  //       "amount": "string",
  //       "baseAmount": "string",
  //       "denom": "string"
  //     }
  //   ],
  //   "staking": {
  //     "totalAgd": "string",
  //     "totalAge": "string",
  //     "totalAgr": "string",
  //     "totalAgs": "string"
  //   },
  //   "totalStakingAmount": "string"
  // }

  /// {"address":"gea1576v9jzsczleyhwj6cxun42l3n8crjg4dsgete", "balances":[{"amount":"0ugea", "baseAmount":"0", "denom":"ugea"}, {"amount":"0ugag", "baseAmount":"0", "denom":"ugag"}, {"amount":"0.00000000ans", "baseAmount":"0.00000000", "denom":"ans"}], "totalStakingAmount":"0ugea", "staking":{"totalAge":"0ugea", "totalAgs":"0ugea", "totalAgd":"0ugea", "totalAgr":"0ugea"}}

  final String address, totalStakingAmount;
  final List<Balance> balances;
  final Staking staking;

  WalletAssetsModel(
      {required this.address,
      required this.totalStakingAmount,
      required this.balances,
      required this.staking});

  factory WalletAssetsModel.fromJson(Map<String, dynamic> json) {
    return WalletAssetsModel(
      address: json['address'],
      totalStakingAmount: json['totalStakingAmount'],
      balances: json['balances'] == null
          ? []
          : (json['balances'] as List).map((e) => Balance.fromJson(e)).toList(),
      staking: Staking.fromJson(json['staking']),
    );
  }
}

class Balance {
  final String amount, baseAmount, denom;

  Balance(
      {required this.amount, required this.baseAmount, required this.denom});

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      amount: json['amount'],
      baseAmount: json['baseAmount'],
      denom: json['denom'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'baseAmount': baseAmount,
      'denom': denom,
    };
  }
}

class Staking {
  final String totalAge, totalAgs, totalAgd, totalAgr;

  Staking(
      {required this.totalAge,
      required this.totalAgs,
      required this.totalAgd,
      required this.totalAgr});

  factory Staking.fromJson(Map<String, dynamic> json) {
    return Staking(
        totalAge: json['totalAge'],
        totalAgs: json['totalAgs'],
        totalAgd: json['totalAgd'],
        totalAgr: json['totalAgr']);
  }

  Map<String, dynamic> toJson() {
    return {
      'totalAge': totalAge,
      'totalAgs': totalAgs,
      'totalAgd': totalAgd,
      'totalAgr': totalAgr
    };
  }
}
