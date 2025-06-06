import 'package:flutter_test/flutter_test.dart';

import 'package:waller_api_flutter/waller_api_flutter.dart';

void main() {
  test('adds one to input values', () async{
    final api = WalletApi.instance;
    api.baseUrl = 'http://192.168.0.72:8000';
    final res = await api.getWallet(address: 'gea1576v9jzsczleyhwj6cxun42l3n8crjg4dsgete');
    print(res.toJson);
    expect(res.data!=null, true);
  });
}
