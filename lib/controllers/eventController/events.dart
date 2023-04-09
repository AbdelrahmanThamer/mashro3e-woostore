// Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
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

// @dart=2.9

import 'package:flutter/foundation.dart';

import '../../models/models.dart';

class UserAuthEvent {
  const UserAuthEvent();
}

/// User Authentication events
class UserLoggedInEvent extends UserAuthEvent {
  final User user;

  const UserLoggedInEvent({@required this.user});
}

/// On user logged out event
class UserLoggedOutEvent extends UserAuthEvent {}

/// When there is a fetch error with the categories
class CategoriesFetchErrorEvent {}

/// When there is a fetch error with the tags
class TagsFetchErrorEvent {}

/// When `categorisedProducts` screen modal is popped
class ChildrenCategoryModalPopEvent {
  ChildrenCategoryModalPopEvent({this.name});

  String name;
}
