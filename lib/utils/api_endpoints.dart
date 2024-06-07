class ApiEndPoints {
  static const String baseUrl = 'https://reqres.in';
  static AuthEndPoints authEndpoints = AuthEndPoints();
}

class AuthEndPoints {
  final String registerEmail = '/api/register';
  final String loginEmail = '/api/login';
  final String users = '';
}
