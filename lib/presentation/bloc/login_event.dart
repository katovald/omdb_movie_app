abstract class LoginEvent {}

class LoginRequest extends LoginEvent{
  final String username;
  final String password;

  LoginRequest({required this.username, required this.password});
}