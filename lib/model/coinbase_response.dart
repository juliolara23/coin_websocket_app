import 'package:json_annotation/json_annotation.dart';

part 'coinbase_response_imp.dart';

@JsonSerializable()
class CoinbaseResponse {
  final String price;
  @JsonKey(name: 'product_id')
  final String productId;

  CoinbaseResponse(this.price, this.productId);

  factory CoinbaseResponse.fromJson(Map<String, dynamic> json) =>
      _$CoinbaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CoinbaseResponseToJson(this);
}
