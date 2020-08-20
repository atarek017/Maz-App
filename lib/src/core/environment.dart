class Environment {
  static final String baseUrl = 'http://192.168.1.5:10000/';
  static final String userLogin = baseUrl + 'maz/user/login';
  static final String userSignUp = baseUrl + 'maz/user/signup';
  static final String userUpdateInfo = baseUrl + 'maz/user/updateUserInfo';
  static final String getAllUsers = baseUrl + 'maz/user/getAllUsers';
  static final String getEatsUsers = baseUrl + 'maz/user/getEatsUsers';

  static final String getAllProducts = baseUrl + 'maz/products/getAllProducts';
  static final String addDay = baseUrl + 'maz/eats/addDay';


  static final Map<String, String> requestHeader = {
    'Content-Type': 'application/json'
  };
}