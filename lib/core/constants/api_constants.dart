class ApiConstants {
  static const String baseUrl =
      'https://api.easyshop.com/v1'; // Replace with your actual API base URL

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // Product endpoints
  static const String products = '/products';
  static const String productDetails = '/products/'; // Append product ID
  static const String searchProducts = '/products/search';
  static const String categories = '/categories';
  static const String categoryProducts = '/categories/'; // Append category ID

  // Cart endpoints
  static const String cart = '/cart';
  static const String addToCart = '/cart/add';
  static const String removeFromCart = '/cart/remove';
  static const String updateCart = '/cart/update';

  // Order endpoints
  static const String orders = '/orders';
  static const String orderDetails = '/orders/'; // Append order ID
  static const String createOrder = '/orders/create';

  // User endpoints
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile/update';
  static const String userAddresses = '/user/addresses';
  static const String addAddress = '/user/addresses/add';
  static const String updateAddress = '/user/addresses/update';
  static const String deleteAddress = '/user/addresses/delete';
}
