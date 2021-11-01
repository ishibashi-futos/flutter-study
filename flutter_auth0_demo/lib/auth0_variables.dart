class Auth0 {
  static const String DOMAIN = '{YOUR_AUTH0_TENANT}.auth0.com';
  static const String CLIENT_ID = '{YOUR_AUTH0_CLIENT_ID}';
  static const String REDIRECT_URI = 'com.auth0.{YOUR_AUTH0_TENANT}://login-callback';
  static const String ISSUER = 'https://$DOMAIN';
}