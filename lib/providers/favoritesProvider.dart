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
import 'package:flutter/material.dart';

class FavoriteProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];
  List<Map<String, dynamic>> get favorites => _favorites;

  void add({Map<String, dynamic>  data}){
    _favorites.add(data);
    print('added data to fav. $_favorites ');
    notifyListeners();
  }

  void remove({Map<String, dynamic>  data}){
    _favorites.removeWhere((item)=> item['id'] == data['id']);
    print('removed data from fav. $_favorites ');
    notifyListeners();
  }
  
}
