class LoginRequest {
  String email;
  String password;
  LoginRequest({
    required this.email,
    required this.password,
  });
}


class ResetPasswordRequest {
  String email;
  ResetPasswordRequest({
    required this.email,
  });
}
