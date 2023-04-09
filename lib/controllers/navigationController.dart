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

import '../routes/guards.dart';
import '../routes/router.gr.dart';

// Exports
export '../routes/router.gr.dart';

///
/// ## `Description`
///
/// Higher order class to control the navigation functions of the application
///
abstract class NavigationController {
  static final AppRouter navigator = AppRouter(authGuard: AuthGuard());
}
