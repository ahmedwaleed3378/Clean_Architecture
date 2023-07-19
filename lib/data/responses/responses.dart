import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "message")
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  @JsonKey(name: "id")
  String? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "numberOfNotifications")
  int? numberOfNotifications;
  CustomerResponse(
    this.id,
    this.name,
    this.numberOfNotifications,
  );
  //fromJson
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  //toJson
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class ContactsResponse {
  @JsonKey(name: "link")
  String? link;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "email")
  String? email;
  ContactsResponse(
    this.link,
    this.phone,
    this.email,
  );
  //fromJson
  factory ContactsResponse.fromJson(Map<String, dynamic> json) =>
      _$ContactsResponseFromJson(json);

  //toJson
  Map<String, dynamic> toJson() => _$ContactsResponseToJson(this);
}

@JsonSerializable()
class AuthenticationRespone extends BaseResponse {
  @JsonKey(name: "customer")
  CustomerResponse? customer;
  @JsonKey(name: "contacts")
  ContactsResponse? contacts;
  AuthenticationRespone(
    this.customer,
    this.contacts,
  );

  //fromJson
  factory AuthenticationRespone.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponeFromJson(json);

  //toJson
  Map<String, dynamic> toJson() => _$AuthenticationResponeToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: "support")
  String? support;
  ForgotPasswordResponse(this.support);
  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);
}
