// Copyright (c) 2022 Aniket Malik [aniketmalikwork@gmail.com]
// All Rights Reserved.
//
// NOTICE: All information contained herein is, and remains the
// property of Aniket Malik. The intellectual and technical concepts
// contained herein are proprietary to Aniket Malik and are protected
// by trade secret or copyright law.
//
// Dissemination of this information or reproduction of this material
// is strictly forbidden unless prior written permission is obtained from
// Aniket Malik.

abstract class AppStrings {
  // Generic strings
  static const String ok = 'OK';
  static const String cancel = 'Cancel';
  static const String and = 'and';
  static const String or = 'or';

  // Logout
  static const String logout = 'Logout';
  static const String logoutAreYouSure =
      'Are you sure that you want to logout?';
  static const String logoutFailed = 'Logout failed';

  // Login Page
  static const String login = 'Login';
  static const String loginTagLine = 'Login with email and password';
  static const String continueWithFacebook = 'Continue with Facebook';
  static const String continueWithGoogle = 'Continue with Google';
  static const String continueWithApple = 'Continue with Apple';
  static const String goAnonymous = 'Go anonymous';
  static const String loginQues = 'Don\'t have an account ?';

  // Sign up Page
  static const String signup = 'Sign Up';
  static const String signupButton = 'Sign up';
  static const String signUpTagLine =
      'Sign up to discover amazing things near you';
  static const String signupWithFacebook = 'Signup with Facebook';
  static const String signupWithGoogle = 'Signup with Google';
  static const String termsOfService = 'Terms of Service';
  static const String privacyPolicy = 'Privacy Policy';
  static const String tosPreText = 'By signing up you agree to our ';
  static const String signUpQues = 'Already have an account ?';

  // Email & Password page
  static const String register = 'Register';
  static const String forgotPassword = 'Forgot password';
  static const String forgotPasswordQuestion = 'Forgot password?';
  static const String createAnAccount = 'Create an account';
  static const String needAnAccount = 'Need an account? Register';
  static const String haveAnAccount = 'Have an account? Sign in';
  static const String signInFailed = 'Sign in failed';
  static const String registrationFailed = 'Registration failed';
  static const String passwordResetFailed = 'Password reset failed';
  static const String sendResetLink = 'Send Reset Link';
  static const String backToSignIn = 'Back to sign in';
  static const String resetLinkSentTitle = 'Reset link sent';
  static const String resetLinkSentMessage =
      'Check your email to reset your password';
  static const String emailLabel = 'Email';
  static const String emailHint = 'test@test.com';
  static const String password8CharactersLabel = 'Password (8+ characters)';
  static const String passwordLabel = 'Password';
  static const String confirmPasswordLabel = 'Confirm Password';
  static const String invalidEmailErrorText = 'Email is invalid';
  static const String invalidEmailEmpty = 'Email can\'t be empty';
  static const String invalidPasswordTooShort = 'Password is too short';
  static const String invalidPasswordNoMatch = 'Passwords do not match';
  static const String invalidPasswordEmpty = 'Password can\'t be empty';

  // Home page
  static const String homePage = 'Home Page';

  // Developer menu
  static const String developerMenu = 'Developer menu';
  static const String authenticationType = 'Authentication type';
  static const String firebase = 'Firebase';
  static const String mock = 'Mock';
  static const String favorites = 'Favorites';
  static const String cart = 'Cart';
  static const String search = 'Search';
  static const String seeAll = 'See all';
  static const String addToCart = 'Add to cart';
  static const String remove = 'Remove';
  static const String notAvailable = 'Not Available';
  static const String description = 'Description';
  static const String reviews = 'Reviews';
  static const String allReviews = 'All Reviews';
  static const String selectSize = 'Select Size';
  static const String quantity = 'Quantity';
  static const String color = 'Color';
  static const String itemAddedToCart = 'Item added to cart';
  static const String itemRemovedFromCart = 'Item removed from cart';
  static const String cartMessagePart1 = 'You have total';
  static const String cartMessagePart2 = 'items in the cart';
  static const String totalAmount = 'Total amount';
  static const String checkout = 'Checkout';
  static const String shippingAddress = 'Shipping Address';
  static const String shippingAddressSubheading =
      'Choose your desired address for delivery';
  static const String next = 'Next';
  static const String back = 'Back';
  static const String shippingOption = 'Shipping Option';
  static const String shippingOptionsSubheading = 'Choose your shipping option';
  static const String free = 'Free';
  static const String flatRate = 'Flat Rate';
  static const String localPickup = 'Local Pickup';
  static const String onDay = 'One Day';
  static const String review = 'Review';
  static const String reviewSubheading = 'Please review your order';
  static const String items = 'Items';
  static const String totalItems = 'Total Items:';
  static const String itemCost = 'Items Cost';
  static const String shipping = 'Shipping';
  static const String address = 'Address';
  static const String size = 'Size';
  static const String cartEmpty = 'Your cart is empty';
  static const String payment = 'Payment';
  static const String options = 'Options';
  static const String paymentOptionsSubheading =
      'Choose your payment option and proceed to pay.';
  static const String debitCreditCard = 'Credit/Debit Card';
  static const String paypal = 'PayPal';
  static const String razorPay = 'Razor Pay';
  static const String cod = 'Cash on delivery';
  static const String payNow = 'Pay Now';

  static const String my = 'My';
  static const String myOrdersSubtitle = 'Check out all your orders\' status';

  static const String track = 'Track';
  static const String orders = 'Orders';
  static const String trackOrdersSubtitle = 'Track your orders here';

  static const String profile = 'Profile';
  static const String information = 'Information';
  static const String profileInformationSubtitle =
      'Update and modify your profile';

  static const String account = 'Account';
  static const String settings = 'Settings';
  static const String settingsSubtitle = 'Change the app settings';
  static const String accountSettingsSubtitle =
      'Update shipping, billing address and much more';

  static const String notifications = 'Notifications';
  static const String manageNotifications = 'Manage notifications';

  static const String all = 'All';
  static const String delivered = 'Delivered';
  static const String pending = 'Pending';
  static const String shipped = 'Shipped';
  static const String cancelled = 'Cancelled';
  static const String noDataAvailable = 'No data available';
  static const String date = 'Date';
  static const String transactionId = 'Txn Id';
  static const String order = 'Order';
  static const String id = 'Id';
  static const String details = 'Details';
  static const String placed = 'Placed';
  static const String outForDelivery = 'Out for delivery';
  static const String arriving = 'Arriving';
  static const String editProfile = 'Edit Profile';
  static const String update = 'Update';
  static const String updated = 'Updated';
  static const String name = 'Name';
  static const String save = 'Save';
  static const String submit = 'Submit';
  static const String cards = 'Cards';
  static const String change = 'Change';
  static const String contactUs = 'Contact Us';
  static const String your = 'Your';
  static const String primary = 'Primary';
  static const String primaryAddressMessage =
      'This is your primary address to which products will be delivered if no address is selected at the time of check out';
  static const String others = 'Others';
  static const String street = 'Street';
  static const String city = 'City';
  static const String state = 'State';
  static const String country = 'Country';
  static const String zipCode = 'Zip Code';
  static const String phone = 'Phone';
  static const String actions = 'Actions';
  static const String addNewAddress = 'Add new address';
  static const String deleteAddressQuestion =
      'Are you sure you want to delete this address ?';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String oldPassword = 'Old Password';
  static const String newPassword = 'New Password';
  static const String somethingWentWrong = 'Something went wrong';
  static const String contactUsMessage =
      'Contact us with any of your queries and we will get right onto it.';
  static const String callMe = 'Call Me';
  static const String mainCardCaption =
      'This is your main card that you use to check out';
  static const String addNewCard = 'Add New Card';
  static const String cardNumber = 'Card Number';
  static const String cardExpMonth = 'Expiry Month';
  static const String cardExpYear = 'Expiry Year';
  static const String cardHolderName = 'Card Holder Name';
  static const String cardType = 'Card Type';
  static const String cardBankName = 'Bank Name';
  static const String creditCardExpMonthError =
      'The month number must be between 1 - 12';
  static const String creditCardExpYearError =
      'The year is invalid. It must be more than or equal to the present year.';
  static const String creditCardExpBigYearError =
      'The year is invalid. It is too futuristic!';
  static const String cardNumberPlaceholder = '4711471147114711';
  static const String cardBankNamePlaceholder = 'Axis Bank';
  static const String cardExpMonthPlaceholder = '02';
  static const String cardExpYearPlaceholder = '2025';
  static const String cardHolderNamePlaceholder = 'Aniket Malik';
  static const String categories = 'Categories';
  static const String chooseProductCategory = 'Choose Product Category';
  static const String products = 'Products';
  static const String apply = 'Apply';
  static const String priceRange = 'Price Range';
  static const String go = 'Go';
  static const String nothingToSearch = 'Nothing to search';
  static const String oops = 'Oops!';
  static const String reload = 'Reload';
  static const String filter = 'Filter';
  static const String popular = 'Popular';
  static const String featured = 'Featured';
  static const String recommended = 'Recommended';
  static const String related = 'Related';
  static const String weekPromotionsLabel = 'Week Promotions';
  static const String flashSaleLabel = 'Flash Sale';
  static const String seller = 'Seller';
  static const String paymentSuccessful = 'Payment Successful !!';
  static const String paymentSuccessfulMessage =
      'Thank you for shopping with us \n Have a great day';
  static const String paymentProcessing =
      'Processing the payment. Please wait.';
  static const String number = 'Number';
  static const String continueShopping = 'Continue Shopping';
  static const String paymentFailed = 'Payment Failed !!';
  static const String paymentFailedMessage =
      'Something went wrong while processing the payment \n Please try again';
  static const String tryAgain = 'Try Again';
  static const String theme = 'Theme';
  static const String dark = 'Dark';
  static const String mode = 'Mode';
  static const String availability = 'Availability';
  static const String requestFailed =
      'Could not complete the request. Please try again!';
  static const String sale = 'Sale';
  static const String saleEnd = 'End';
  static const String saleEnded = 'Sale Ended';
  static const String inStock = 'In Stock';
  static const String outOfStock = 'Out of stock';
  static const String outOfStockMessage =
      'The item variation is currently out of stock, please try other variations';
  static const String onSale = 'On Sale';
  static const String originalPrice = 'Original price';
  static const String price = 'Price';
  static const String addReview = 'Add a review';
  static const String writeAReview = 'Write a review';
  static const String clearFilters = 'Clear filters';
  static const String tags = 'Tags';
  static const String singleQuantityMessage =
      'You can only buy single item in an order';
  static const String productNotFound = 'Product not found';
  static const String firstName = 'First name';
  static const String lastName = 'Last name';
  static const String username = 'Username';
  static const String failedSignUp = 'Could not create an account';
  static const String processing = 'Processing';
  static const String checkoutProcessingMessage =
      'Cannot leave while processing';
  static const String completed = 'Completed';
  static const String failed = 'Failed';
  static const String total = 'Total';
  static const String shippingTotal = 'Shipping total';
  static const orderId = 'Order Id';
  static const String show = 'Show';
  static const String undefined = 'Undefined';
  static const String postCode = 'Post Code';
  static const String billing = 'Billing';
  static const String view = 'View';
  static const String tracking = 'Tracking';
  static const String provider = 'Provider';
  static const String link = 'Link';
  static const String please = 'Please';
  static const String again = 'Again';
  static const String apartment = 'Apartment';
  static const String stateHelperMessage =
      'Please write the correct full name or ISO code for the state';
  static const String unit = 'Unit';
  static const String etc = 'etc';
  static const String passwordUpdateMessage = 'Your password has been updated';
  static const String website = 'Website';
  static const String couldNotLaunch = 'Could not launch';
  static const String call = 'Call';
  static const String endOfList = 'End of list';
  static const String noMoreDataAvailable = 'No more data available';

  static const String noFavoriteItems = 'No items in your favorites list!';

  static const String aboutUs = 'About Us';

  static const String version = 'Version';

  static const String moreInfo = 'More Info';

  static const String image = ' Image';

  static const String youMayAlsoLike = 'You may also like';

  static const String frequentlyBoughtTogether = 'Frequently bought together';

  static const String exitMessage = 'Are you sure you want to exit ?';

  static const String endsIn = 'Ends in';

  static const String loginAgain = 'Please logout and login again';

  static const String searchSomething = 'Search something';

  static const String noVariationFound = 'Variation Not Available';
  static const String noVariationFoundMessage =
      'Could not find any variation with these attributes combination at this moment';

  static const String success = 'Success';

  static const String nothingToUpdate = 'Nothing to update';

  static const String available = 'Available';

  static const String add = 'Add';

  static const String passwordResetFailedNotice =
      'In case of an invalid token error while updating your information after a password reset, just logout and login again.';

  static const String requestProcessingMessage =
      'Your request is being processed';
  static const String error = 'Error';
  static const String by = 'By';
  static const String user = 'User';
  static const String authTokenUnavailable = 'Could not get auth token';

  static const String socialLoginFailedMessage = 'Could not get the user data';
  static const String appleLoginEmailErrorMessage =
      'No valid email provided. Cannot create account without a valid email address';
  static const String errorEmptyInput = 'This field cannot be empty';
  static const String points = 'Points';

  static const String found = 'Found';

  static const String events = 'Events';

  static const String pointsMessage1 = 'Earn up to';
  static const String pointsMessage2 = 'points on the purchase of this product';

  static const String reward = 'Reward';
  static const String buyNow = 'Buy Now';
}
