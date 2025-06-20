import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_api_flutter/wallet_api_flutter.dart';

void main() {
  test('adds one to input values', () async {
    final api = WalletApi.instance;
    api.baseUrl = 'http://192.168.0.72:8000';
    final res = await api.getWallet(
        address: 'gea1576v9jzsczleyhwj6cxun42l3n8crjg4dsgete');
    print('getWallet: ${res.data?.toJson()}');
    expect(res.data != null, true);
  });

  test('adds one to input values', () async {
    final api = WalletApi.instance;
    api.baseUrl = 'http://192.168.0.72:8000';
    final res = await api.getAverageBlockTime();
    print('getAverageBlockTime: ${res.data?.toJson()}');
    expect(res.data != null, true);
  });
}
