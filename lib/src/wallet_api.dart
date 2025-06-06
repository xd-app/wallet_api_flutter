import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wallet_api_flutter/src/model/block_info_model.dart';
import 'package:wallet_api_flutter/src/model/wallet_assets_model.dart';
import 'package:wallet_api_flutter/src/model/wallet_response.dart';

mixin _DioMixin {
  late Dio _dio;

  final _log = LogInterceptor(
      requestHeader: true, requestBody: true, responseBody: true);

  set baseUrl(String url) {
    _dio.options.baseUrl = url;
  }

  void enableLog(bool enable) {
    if (enable) {
      _dio.interceptors.add(_log);
    } else {
      _dio.interceptors.remove(_log);
    }
  }
}

class WalletApi with _DioMixin, _ApiMixin {
  static WalletApi? _instance;

  static WalletApi get instance => _instance ??= WalletApi._dio();

  WalletApi._();

  factory WalletApi._dio() {
    return _instance ??= WalletApi._()
      .._dio = Dio(BaseOptions(
        validateStatus: (status) {
          return status != null && status <= 500;
        },
      ));
  }

  factory WalletApi.dio({required Dio dio}) {
    return _instance ??= WalletApi._().._dio = dio;
  }

  factory WalletApi.options({required BaseOptions options}) {
    return _instance ??= WalletApi._().._dio = Dio(options);
  }
}

mixin _ApiMixin on _DioMixin {
  static const String _api = '/api';
  static const String _wallet = '/wallet';

  static const String walletAssets = '$_api$_wallet/home';

  ///平均出块时间和最新区块高度
  static const String apiAverageBlockTime =
      "$_api/rest/block/average-block-time";

  Future<WalletResponse<WalletAssetsModel?>> getWallet(
      {required String address}) async {
    return await _dio.getAccept(walletAssets,
        queryParameters: {'address': address},
        decode: (data) => WalletAssetsModel.fromJson(data));
  }

  Future<WalletResponse<BlockInfo?>> getAverageBlockTime() async {
    return await _dio.getAccept(apiAverageBlockTime,
        decode: (data) => BlockInfo.fromJson(data));
  }
}

extension _DioExt on Dio {
  Future<WalletResponse<T?>> getAccept<T>(
    String url, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    T Function(Map<String, dynamic> data)? decode,
  }) async {
    final res = await get(url,
        queryParameters: queryParameters, cancelToken: cancelToken);

    if (res.statusCode == HttpStatus.ok && res.data != null) {
      return WalletResponse.ok(decode?.call(res.data) ?? res.data);
    } else {
      return WalletResponse.error(res.data);
    }
  }

  Future<WalletResponse<T?>> postAccept<T>(
    String url,
    dynamic data,
    CancelToken? cancelToken,
    T Function(Map<String, dynamic> data)? decode,
  ) async {
    final res = await post(url, data: data, cancelToken: cancelToken);

    if (res.statusCode == HttpStatus.ok && res.data != null) {
      return WalletResponse.ok(decode?.call(jsonDecode(res.data)) ?? res.data);
    } else {
      return WalletResponse.error(jsonDecode(res.data));
    }
  }
}
