class LoginModel {
  final int status;
  final String message;
  final String accessToken;

  LoginModel({
    required this.status,
    required this.message,
    required this.accessToken,

  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'],
      message: json['message'],
      accessToken:json['data']['access_token'] ,

    );
  }
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
    };
  }
}
