class WalletResponse<T> {
  ///{"code":500, "reason":"", "message":"failed to get ugag balance from node address:\"192.168.0.89\"  grpc_port:\"9090\"  rpc_port:\"1317\"", "metadata":{}}

  final T? data;
  final int? code;
  final String? reason, message;

  WalletResponse({this.data, this.code, this.reason, this.message});

  bool get isOk => code == 200 && data != null;

  factory WalletResponse.ok(T data) => WalletResponse(data: data);

  factory WalletResponse.error(Map<String, dynamic> json) => WalletResponse(
        code: json['code'],
        reason: json['reason'],
        message: json['message'],
      );

  factory WalletResponse.fromJson(Map<String, dynamic> json) {
    return WalletResponse(
      data: json['data'],
      code: json['code'],
      reason: json['reason'],
      message: json['message'],
    );
  }

  Map<String, dynamic> get toJson => isOk
      ? {
          'data': data,
        }
      : {
          'code': code,
          'reason': reason,
          'message': message,
        };
}
