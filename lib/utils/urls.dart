class Urls {
  static String baseUrl = "https://dev.netscapelabs.com/funfy/public/api/";

  static String introUrl = baseUrl + "getWalkthrough";
  static String siginUrl = baseUrl + "customer/login";
  static String forgotpasswordUrl = baseUrl + "reset-password";
  static String signUpUrl = baseUrl + "customer/register";
  static String termsandconditionsUrl = baseUrl + "config/terms_and_conditions";
  static String privacypolicyUrl = baseUrl + "config/privacy_policy";
  static String fiestasPostUrl = baseUrl + "customer/fiesta/list";
  static String preFiestasPostsUrl = baseUrl + "customer/preFiesta/list";
  static String faceBookSigninUrl = baseUrl + "customer/register/fb";
  static String updateProfileUrl = baseUrl + "customer/update";
  static String googleSiginUrl = baseUrl + "customer/register/google";
  static String preFiestachildlistUrl =
      baseUrl + "customer/preFiesta/child/list";
  static String preFiestasBookingListUrl = baseUrl + "customer/order/list";

  static String makeOrderUrl = baseUrl + "customer/order/store";

  static String fiestasBookingUrl = baseUrl + "customer/booking/store";
  static String fiestasBookingListUrl = baseUrl + "customer/booking/list";
  static String preFiestasBookingUrl = baseUrl + "customer/cart/store";
  static String fiestasAddfavoriteUrl =
      baseUrl + "customer/favourite/fiesta/add";
  static String fiestasfavoriteListUrl =
      baseUrl + "customer/favourite/fiesta/list";
  static String preFiestasAddfavoriteUrl =
      baseUrl + "customer/favourite/prefiesta/add";
  static String preFiestasfavoriteListUrl =
      baseUrl + "customer/favourite/prefiesta/list";

  static String preFiestasOrderItemDetail = baseUrl + "customer/order/detail";
  static String preFiestasGetCartUrl = baseUrl + "customer/cart";

  static String fiestasGetByidUrl = baseUrl + "customer/fiesta/detail";

  static String addPaymentCardUrl = baseUrl + "customer/cards/store";

  static String getCardListUrl = baseUrl + "customer/cards/list";

  static String deleteCardUrl = baseUrl + "customer/cards/delete";

  static String fiestasBookingOrderDetail =
      baseUrl + "customer/booking/itemByID";

  static String aboutUsUrl = baseUrl + "config/about_us";
  static String helpUrl = baseUrl + "config/help_and_contact_us";
  static String notificationonOffUrl = baseUrl + "notification/status";
  static String notificationUrl = baseUrl + "notification/list";
}
