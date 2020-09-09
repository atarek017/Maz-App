class Environment {
  static final String baseUrl = 'http://192.168.1.3:10000/';
  static final String userLogin = baseUrl + 'maz/use192.168.43.1r/login';
  static final String userSignUp = baseUrl + 'maz/user/signup';
  static final String userUpdateInfo = baseUrl + 'maz/user/updateUserInfo';
  static final String getAllUsers = baseUrl + 'maz/user/getAllUsers';
  static final String getEatsUsers = baseUrl + 'maz/user/getEatsUsers';

  //products 
  static final String getAllProducts = baseUrl + 'maz/products/getAllProducts';
  static final String addProduct = baseUrl + 'maz/products/addProduct';
  static final String updateProductInfo = baseUrl + 'maz/products/updateProductInfo';

  // eats day
  static final String getProducts = baseUrl + 'maz/products/getProducts';
  static final String addDay = baseUrl + 'maz/eats/addDay';

  //money
  static final String getMoney = baseUrl + 'maz/money/getMoney';

  static final Map<String, String> requestHeader = {
    'Content-Type': 'application/json'
  };
}
