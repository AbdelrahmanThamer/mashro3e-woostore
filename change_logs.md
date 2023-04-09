# Change Logs

## [ v3.4.0 ] - 20th October 2022 - Aniket Malik
- Added support for Photo Reviews for WooCommerce Plugin
- [REQUIRED] WooStore Pro Api Plugin Version 4.4.0

## [ v3.3.0 ] - 18th October 2022 - Aniket Malik
- Added support for Digits - Phone OTP login / signup plugin
- [REQUIRED] WooStore Pro Api Plugin Version 4.3.0
- Added phone verification for signup and update profile

## [ v3.2.0 ] - 11th October 2022 - Aniket Malik
- Added WooCommerce Product Addons Support
- Removed Cocart plugin dependency in favor of WooStoreProCart
- [REQUIRED] WooStore Pro Api Plugin Version 4.2.0
- [RECOMMENDED] App Builder Version 1.4.0 to use
  - Product Addons

## [ v3.1.5 ] - 31st August 2022 - Aniket Malik
- Remove push notification device token on user logout
- Removed unnecessary dependency

## [ v3.1.4 ] - 30th August 2022 - Aniket Malik
- Show splash screen until the animation is complete
- Enhanced product details screen initial product fetch navigation

## [ v3.1.3 ] - 30th August 2022 - Aniket Malik
- Fixed data classes conversion to map

## [ v3.1.2 ] - 29th August 2022 - Aniket Malik
- Fixed product screen description not visible issue
- Updated product screen's tags and categories horizontal list's default size

## [ v3.1.1 ] - 29th August 2022 - Aniket Malik
- Updated logic for forced login before add item to cart

## [ v3.1.0 ] - 28th August 2022 - Aniket Malik
- Added auto login functionality for webpage layout

## [ v3.0.2 ] - 25th August 2022 - Aniket Malik
- Fixed search tag filters
- Fixed social login hide/show with app builder
- added splash screen loading while fetching app template

## [ v3.0.1 ] - 24th August 2022 - Aniket Malik
- Fixed webview checkout null error
- Expanded Search Section for click in dynamic layout

## [ v3.0.0 ] - 22nd August 2022 - Aniket Malik
- Upgraded to use Flutter 3.0
- Integrated App Builder for no-code app update
- Migrated to null safety partially

## [ v2.2.4 ] - 25th June 2022 - Aniket Malik
- Enhanced Checkout fields keyboard integration

## [ v2.2.3 ] - 22nd March 2022 - Aniket Malik
- Fixed default signup urls cleanup.

## [ v2.2.2 ] - 8th March 2022 - Aniket Malik
- Fixed OTP UI keyboard issue

## [ v2.2.1 ] - 26th Feb 2022 - Aniket Malik
- Fixed OTP test code causing issue with verification code

## [ v2.2.0 ] - 3rd December 2021 - Aniket Malik
- Added Phone OTP Login
- Added change attributes based on selection
- Updated change password to require old and new password to perform the change
  as it adds more security for the account holder
- Updated session handler to force the user to log in after the session has 
  been ended. 
- [REQUIRED] WooStore Pro Api Version 3.2.0 or higher
- [REQUIRED] WooCommere Flutter Package 3.2.0 or higher

## [ v2.1.0 ] - 13th November 2021 - Aniket Malik
- Get shipping methods by calculating the cart items and products shipping 
  classes.

## [ v2.0.1 ] - 1st November 2021 - Aniket Malik
- Enhanced categories fetching
- Empty coupon verification improved

## [ v2.0.0 ] - 25th October 2021 - Aniket Malik
- Added Native Checkout Feature
- Added `homePageAppBarShowCartIcon` and `homePageAppBarShowNotificationIcon` 
to show or hide icons in home page app bar in config.dart
- Added New Home Sections to show external_link and single product. 

## [ v1.14.2 ] - 29th September 2021 - Aniket Malik
* Fixed (#49) Related products not being pushed as it was the same route

## [ v1.14.1 ] - 19th September 2021 - Aniket Malik
- Updated application and dependencies to support Flutter 2.5

## [ v1.14.0 ] - 10th September 2021 - Aniket Malik
- Added `productScreenShowVendorTile`, `productScreenVendorLayout` and 
`productScreenVendorOriginalLayoutAspectRatio` flags to enable / modify the 
  vendor functionality in the application.
  Supported Vendors: Dokan, WCFM, WCMp
- Requires WooCommerce Package version 1.6.0
- Requires WooStore Pro Api wordpress plugin version 2.2.0

## [ v1.13.3 ] - 3rd September 2021 - Aniket Malik
- Updated Facebook Login to use custom tabs as per facebook's updated 
  requirements.

## [ v1.13.2 ] - 28th August 2021 - Aniket Malik
- Enhanced internal functionality of product management

## [ v1.13.1 ] - 12th August 2021 - Aniket Malik
- Fixed My orders Variable products not showing add review button

## [ v1.13.0 ] - 12th August 2021 - Aniket Malik
- Added `Add a Review` button on completed order's product items so that only
 the verified buyers can write a review only after the order has been
  successful.
  - Use `myOrdersShowAddReviewButtonForCompletedOrders` flag in config.dart
   to enable / disable. ENABLED by default. 
- Made product in order item clickable, will not open the given product in
 the product details page.
- Updated UI options for Product Details Bottom Button bar to arrange the
 layout of the 'add to cart' and 'buy now' button. Choose from 3 different
  layouts
- Updated option to disallow users to add review for products if they have
 not purchased it.
  - Use `productScreenAllowReviewsWithoutPurchase` to update the setting
  . Enabling it will remove the Add a Review button from the all review
   screen. DISABLED by default.
- Made Tags section clickable in product details screen.
- Added Categories section in product details screen with clickable items to
 see products linked to that category.

## [ v1.12.0 ] - 24th July 2021 - Aniket Malik
- Added Feature Firebase Dynamic Links
- Improved Product share with Firebase Dynamic Links or normal url ( config
 choice available )
- Added `Share App` option to share the app with Firebase Dynamic Links
- Added Config settings for firebase dynamic links in `config.dart` as
 `FirebaseDynamicLinksConfig` class

## [ v1.11.0 ] - 22nd July 2021 - Aniket Malik
- Added sorting and more filter options for search, categorised products,
 category products and tag products.
- Added Filter attributes with support for image and color types ( supported
 with Variation Swatches for WooCommerce Plugin ).
- Added Add To Cart Button on each item card.
- Added Support for Product Color and Image type attributes in product
 details page ( supported with Variation Swatches for WooCommerce Plugin ).
- Improved product item card review stars indicator.
- Improved attributes in product detail page to show selected option with
 attribute name

## [ v1.10.1 ] - 15th July 2021 - Aniket Malik
- Updated WooCommerce Flutter sdk package to escape html characters
- UI Enhancements
  - Now categories' names will not shrink to show the full text, instead the
   extra content will be clipped and replaced by an ellipsis ( "..." ).
  - Fixed category name in `list-child-categories-visible` layout of
   categories' screen which overflowed the container bounds.
  - List scroll behaviour changed when loading more data after reaching the
   end ( Now there is no reverse scrolling ).

## [ v1.10.0 ] - 9th July 2021 - Aniket Malik
- Added Share Products to anyone from application's product screen.
- Fix contact using email opened email app with contact us url

## [ v1.9.4 ] - 6th July 2021 - Aniket Malik
- Update WooStore Pro Api wordpress plugin to `v2.0.0` which includes
 performance enhancements, reduction in dependency on CoCart plugins.

## [ v1.9.3 ] - 2nd July 2021 - Aniket Malik
- Enhanced search functionality

## [ v1.9.2 ] - 25th June 2021 - Aniket Malik
* Minor changes:
  - Change `logout` text to `login` if no user available.
  - Reviews update locally on product page when adding a new review.

## [ v1.9.1 ] - 8th June 2021 - Aniket Malik
- Fixed Home page not fetching more than 10 sections on page end

## [ v1.9.0 ] - 6th June 2021 - Aniket Malik
- Added Categories Section for Home Screen. Now show selected categories in
 the home screen between other sections in various layouts
- Added Tags Section for Home Screen. Now show selected tags in the
 home screen between other sections in various layouts
- Updated Advanced Promotion Section to show label based on the settings from
 the wordpress sections dashboard. Default behaviour is hidden
- Updated WooCommerce package for flutter

## [ v1.8.0 ] - 4th June 2021 - Aniket Malik
- Added Notifications Screen to show saved notifications
- Improved saving, adding and deleting notifications
- Added Notification Tile in Profile Screen to go to notification screen

## [ v1.7.1 ] - 28th May 2021 - Aniket Malik
- Fixed `lib/shared/widgets/itemAttributes.dart` import conflicts.
- Fixed Cart Item quantity decrease from 1 leads to cart general state error
- Updated Variation Data conversion in CoCartProductItem
- Updated Enhanced discount calculation 

## [ v1.7.0 ] - 27th May 2021 - Aniket Malik
This update brings a lot of different layout options to choose from. Every new
 option added can be modified from `config.dart` file.

### Product Screen
- Added New `draggable-sheet` layout for Product Screen.
- Added New `expandable` layout for Product Screen with image parallax effect.
- Added Support for `Affiliate\External Products`.

 Change this setting using `productScreenLayout` flag in `config.dart` file.  

### Home Screen
 - Added a new `Advanced Promotion Section` for home page to show promotional
   images with more control. 

### Categories Screen and list
  - Added New Categories Screen Layouts. Change settings from `config.dart
` using the `categoriesScreenLayout` flag.

  - Updated `categoriesScreenCrossAxisCount` to
 `categoriesScreenGridLayoutCrossAxisCount`. This setting will only work if
  `categoriesScreenLayout` is set to `grid`.

  - Added New Layouts for Categories list in home screen. Change the layout
 settings using `categoriesHomeScreenLayout` flag in `config.dart` file. 

  - Added `categoriesHomeScreenGridLayoutCrossAxisCount` to change the grid
 column count. This setting will only work if `categoriesHomeScreenLayout` is set
  to `grid`.

### Others  
  - Added `productItemCardOnSaleBanner` and `productItemCardOnSaleBannerDark
` in `AppColors.dart` file to change the sale banner colors on product item card.


## [ v1.6.0 ] - 23rd May 2021 - Aniket Malik
- Added Support for `Dynamic Attributes` for variable products. ( Previously
 only color and size were supported )
- Updated UI to show `Dynamic Attributes` on product screen, cart item, my
 orders item tiles.
- Updated UI for attributes selection in product screen.

## [ v1.5.6 ] - 18th May 2021 - Aniket Malik
- Added `tools` directory which has scripts to generate required keys easily
 by running some scripts.
- Added signing information for Android Application with a default upload
 keystore
- Added A new web based extremely comprehensive documentation to setup the
 application and the website, change the application logo, colors, etc.
- Updated Theme configurations names to change the application colors more
 easily.

## [ v1.5.5 ] - 12th May 2021 - Aniket Malik
* Updated - Home sections' internal data formatting methods. Previous version
 sometimes had conflicts with Product Categories' ID and Product Tags.

## [ v1.5.4 ] - 11th May 2021 - Aniket Malik
* Fixed - Sign up issue leading to Wordpress Rest No Route found issue.
* Fixed - Cart loading issue when cart item product price was badly formatted.
* Updated - Internal code enhancements to Woocommerce Flutter Package 

## [ v1.5.3 ] - 2nd May 2021 - Aniket Malik
* Fixed - Cart item error when "sold individually" flag was not set to true
 or false in woocommerce products.

## [ v1.5.2 ] - 30th April 2021 - Aniket Malik
* Improved - Apple Sign in capabilities and workflow.

## [ v1.5.1 ] - 27th April 2021 - Aniket Malik
* Added - Support for Virtual Products for downloads
* Added - showCustomerDownloadsListTile flag to hide or show downloads list
 tile in the account settings screen
* Updated - Account settings name to Account

## [ v1.5.0 ] - 23rd April 2021 - Aniket Malik
* Added - Multilingual feature, now the application can support
 multiple languages in the application.
* Added - Categories in the bottom tab bar for fast and easy access
* Added - Show a horizontal list of child categories in the bottom of the
 CategorisedProductsScreen Appbar for fast selection of child categories
* Added - "categoriesScreenCrossAxisCount" flag in Config.dart to manage number
 of columns of categories in the Category Screen
* Added - "showCategoriesHorizontalListBelowCategorisedProductsAppBar" to
 hide or show the horizontal list of child categories in the bottom of the
  CategorisedProductsScreen Appbar 

## [ v1.4.0 ] - 20th April 2021 - Aniket Malik
* Added - Show login page to guest customer to access the following screens
 -- My Orders, Profile Information, My Points, Shipping / Billing Address
 , Change Password and other screens where only authenticated customers are
  allowed.

## [ v1.3.2 ] - 13th April 2021 - Aniket Malik
* Updated - WooStore Pro Api Wordpress Plugin to be independent of Simple JWT
 login plugin and JWT Authentication for Wp-API plugin. Now this
  functionality is integrated in the native plugin.

## [ v1.3.1 ] - 12th April 2021 - Aniket Malik
* Fixed - Categories section not showing with multiple level of nested child
 categories.
* Updated - Child categories of child categories will be displayed as top
 level categories as only 1 level deep nesting of child categories is
  supported currently.

## [ v1.3.0 ] - 10th April 2021 - Aniket Malik
* Added - Now you have options to hide categories and tags list in
 home, search filter modal and all products filter modal
* Added - Show reward points in the product screen
* Added - Fetch reward points for both simple and variable products and
 variations
* Added - Buy now option with add to cart in product screen bottom to jump to
  cart directly.
* Updated - WooCommerce Flutter package Api for application
* Updated - WooStore Pro Api wordpress plugin for application
* Updated - Like button on top of product screen.
* Updated - On Sale banner animation.

## [ v1.2.1 ] - 8th April 2021 - Aniket Malik
* Fixed - Add reviews to the products. (Bug #5)

## [ v1.2.0 ] - 8th April 2021 - Aniket Malik
* Added - Support for WooCommerce Points and Rewards plugin, now the logged in
 customers can see their points balance and events from the application
  directly. 
* Added - Config Flag to hide/show the 'My Points' list tile in the 'Account
 Settings page'
* Updated - WooCommerce Api Flutter Package for the application to support
 woocommerce rewards and points plugin 

## [ v1.1.0 ] - 6th April 2021 - Aniket Malik
* Added - HTML description to Native widgets, Now you can use HTML tags in
 description to show details of your product. You can also use images which
  will be rendered Natively in the application. Add web links, email links
  , telephone links to your descriptions and they will be opened in the
   default suitable app in the mobile phone.  
* Updated - flutter woocommerce api for application

## [ v1.0.0 ] - 5th April 2021 - Aniket Malik
1. Updated - the name of the application (due to name conflict) 
2. Fixed - Guest User checkout issue (Bug #4)
3. Updated - WordPress Plugin, Now updated to - WooStore Pro Api.
4. Added - "Continue without login" button on Login Screen for Guest Customers
 Other optimisations.
