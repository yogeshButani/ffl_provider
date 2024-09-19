class ApiServices {
  static final ApiServices _apiMethods = ApiServices._internal();

  factory ApiServices() {
    return _apiMethods;
  }

  ApiServices._internal();


  ///Dev Url
  static const baseUrl = 'https://dev.fitforalegend.com/api/';
  static const imageUrl = 'https://dev.fitforalegend.com/public/uploads/';
  static const imageUrlWithoutUpload = 'https://dev.fitforalegend.com/public/';
  static const imageForProfile = 'https://dev.fitforalegend.com/public/';

  static const imageForBrands = '${imageUrl}brands/';
  static const imageForCategories = '${imageUrl}categories/';
  static const imageForProducts = '${imageUrl}products/galleryImages/large/';
  static const imageForProductsFeatureImages = '${imageUrl}products/featuredImages/';
  static const imageForProductsGalleryImages = '${imageUrl}products/galleryImages/';
  static const imageForBanners = imageUrlWithoutUpload;

  /// ==========================  Client token ====================

  static const apiAccessToken = 'eb8b0f58c895019fcbc3bb17480ced3a2d1e12a346d6ed0f0d0267a24587a203';

  ///========================= All Apis Endpoints ========================

  static const login = '${baseUrl}login';
  static const registration = '${baseUrl}signup';
  static const registerOtp = '${baseUrl}check_generate_otp';
  static const verifyOtpEmail = '${baseUrl}email_verify';
  static const verifyOtpMobile = '${baseUrl}Mobile_otp_verify';
  static const logout = '${baseUrl}logout';
  static const forgotPasswordSendEmailOtp = '${baseUrl}forgot_password_otp';
  static const forgotPasswordVerifyOtp = '${baseUrl}email_verify';
  static const forgotPasswordChangePassword = '${baseUrl}forgot_password';
  static const categoryApi = '${baseUrl}category';
  static const subCategoryApi = '${baseUrl}subcategory';
  static const aboutUs = '${baseUrl}aboutus';
  static const termsAndCondition = '${baseUrl}term_condition';
  static const returnExchange = '${baseUrl}return_exchange';
  static const shippingDelivery = '${baseUrl}shipping_delivery';
  static const coupons = '${baseUrl}coupons';
  static const childCategory = '${baseUrl}childcategory';
  static const brandsFilterList = '${baseUrl}brands';
  static const getProfile = '${baseUrl}profile';
  static const updateProfile = '${baseUrl}profileupdate';
  static const productList = '${baseUrl}product';
  static const productDetails = '${baseUrl}product_details';
  static const productsByFilterApi = '${baseUrl}product_by_filter';
  static const homeApi = '${baseUrl}home';
  static const addToCart = '${baseUrl}add-to-cart';
  static const cartList = '${baseUrl}cart-list';
  static const productQuantity = '${baseUrl}product-quantity';
  static const promoCode = '${baseUrl}promo-code';
  static const removeFromCart = '${baseUrl}remove-from-cart';
  static const addToWishlist = '${baseUrl}add-to-wishlist';
  static const myWishList = '${baseUrl}wishlist';
  static const placeOrder = '${baseUrl}place-order';
  static const myOrders = '${baseUrl}my-orders';
  static const states = '${baseUrl}states';
  static const rating = '${baseUrl}rating';
  static const search = '${baseUrl}search';
  static const sizes = '${baseUrl}sizes';
  static const colors = '${baseUrl}colors';
  static const myOrderDetails = '${baseUrl}order-details';
  static const rafflePurchase = '${baseUrl}raffle-purchase';
  static const raffleList = '${baseUrl}raffle';
  static const raffleTicket = '${baseUrl}raffle-ticket';
  static const myRafflesPurchase = '${baseUrl}my-raffle';
  static const myRafflesWinLoss = '${baseUrl}won-loss';
  static const deleteUserAccount = '${baseUrl}delete-user-account';
}