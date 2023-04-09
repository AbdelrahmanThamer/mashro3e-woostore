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

import '../models/orderModel.dart';

class OrdersProvider with ChangeNotifier {
  // All orders
  final List<Order> _ordersList = [];
  List<Order> get ordersList => _ordersList;

  // total no. of orders
  int _totalOrders = 0;
  int get totalOrders => _totalOrders;

  final List<Order> _pendingOrdersList = [];
  List<Order> get pendingOrdersList => _pendingOrdersList;

  final List<Order> _deliveredOrdersList = [];
  List<Order> get deliveredOrdersList => _deliveredOrdersList;

  final List<Order> _cancelledOrdersList = [];
  List<Order> get cancelledOrdersList => _cancelledOrdersList;

  final List<Order> _shippedOrdersList = [];
  List<Order> get shippedOrdersList => _shippedOrdersList;

  Future<void> fetchData() async {
    await Future.delayed(const Duration(seconds: 1));
    // Create HTTP request here

    MOCK_DATA.toList().forEach(
      (obj) {
        final order = Order(
          orderId: obj['orderId'].toString(),
          status: obj['status'],
          transactionId: obj['transactionId'],
          price: obj['price'],
          name: obj['name'],
          imageUrl: obj['imageUrl'],
          date: obj['date'],
          quantity: obj['quantity'],
        );

        // add the data to the list
        _ordersList.add(order);

        // sort the order
        sortOrder(order);
      },
    );

    // set the total no. of orders fetched
    _totalOrders = _ordersList.length;

    notifyListeners();
  }

  void sortOrder(Order order) {
    switch (order.status.toLowerCase()) {
      case 'delivered':
        _deliveredOrdersList.add(order);
        break;

      case 'shipped':
        _shippedOrdersList.add(order);
        break;

      case 'cancelled':
        _cancelledOrdersList.add(order);
        break;

      case 'pending':
        _pendingOrdersList.add(order);
        break;
    }
  }
}

// Mock Data.
const url =
    'https://github.com/AniketMalik/image-hosting/blob/master/ecommerce_app/Photo%20Assets/app_icon_thumbnail.jpg?raw=true';
const MOCK_DATA = [
  {
    'orderId': 1,
    'transactionId': '3569656819744307',
    'name': 'turpis nec euismod',
    'imageUrl': url,
    'date': '12-11-2019',
    'status': 'Delivered',
    'price': '58',
    'quantity': '3'
  },
  {
    'orderId': 2,
    'transactionId': '337941092531507',
    'name': 'magna bibendum',
    'imageUrl': url,
    'date': '12-11-2019',
    'status': 'Delivered',
    'price': '77',
    'quantity': '0'
  },
  {
    'orderId': 3,
    'transactionId': '30588224276020',
    'name': 'turpis nec euismod',
    'imageUrl': url,
    'date': '12-11-2019',
    'status': 'Delivered',
    'price': '56',
    'quantity': '3'
  },
  {
    'orderId': 4,
    'transactionId': '4917556957472520',
    'name': 'iaculis justo in hac',
    'imageUrl': url,
    'date': '12-11-2019',
    'status': 'Cancelled',
    'price': '19',
    'quantity': '0'
  },
  {
    'orderId': 5,
    'transactionId': '3540188900863766',
    'name': 'consequat in consequat ut nulla',
    'imageUrl': url,
    'date': '12-11-2019',
    'status': 'Cancelled',
    'price': '01',
    'quantity': '0'
  },
  {
    'orderId': 6,
    'transactionId': '3545635635998684',
    'name': 'cubilia curae duis',
    'imageUrl': url,
    'date': '12-11-2019',
    'status': 'Cancelled',
    'price': '83',
    'quantity': '1'
  },
  {
    'orderId': 7,
    'transactionId': '3545319922299177',
    'name': 'diam nam tristique tortor eu',
    'imageUrl': url,
    'date': '12-11-2019',
    'status': 'Delivered',
    'price': '33',
    'quantity': '3'
  },
  {
    'orderId': 8,
    'transactionId': '3552923425722351',
    'name': 'vestibulum sed magna',
    'imageUrl': url,
    'date': '12-11-2019',
    'status': 'Pending',
    'price': '62',
    'quantity': '0'
  },
  {
    'orderId': 9,
    'transactionId': '3576835634777822',
    'name': 'fermentum donec ut',
    'imageUrl': url,
    'date': '12-11-2019',
    'status': 'Delivered',
    'price': '53',
    'quantity': '2'
  },
  {
    'orderId': 10,
    'transactionId': '6370982400023428',
    'name': 'mi pede malesuada in imperdiet',
    'imageUrl': url,
    'date': '12-11-2019',
    'status': 'Delivered',
    'price': '57',
    'quantity': '0'
  },
  {
    'orderId': 11,
    'transactionId': '3583436411876845',
    'name': 'posuere cubilia curae',
    'imageUrl': url,
    'date': '12-11-2019',
    'status': 'Shipped',
    'price': '83',
    'quantity': '1'
  },
  {
    'orderId': 12,
    'transactionId': '6771308451336188077',
    'name': 'vivamus in felis',
    'imageUrl': url,
    'date': '12-11-2019',
    'status': 'Delivered',
    'price': '26',
    'quantity': '2'
  },
  {
    'orderId': 13,
    'transactionId': '5108757512764148',
    'name': 'orci nullam molestie nibh',
    'imageUrl': url,
    'date': '12-11-2019',
    'status': 'Cancelled',
    'price': '37',
    'quantity': '1'
  },
  {
    'orderId': 14,
    'transactionId': '3556333009885549',
    'name': 'in est risus auctor',
    'imageUrl': url,
    'date': '12-11-2019',
    'status': 'Cancelled',
    'price': '59',
    'quantity': '2'
  },
  {
    'orderId': 15,
    'transactionId': '3589477982668264',
    'name': 'proin leo odio',
    'imageUrl': url,
    'date': '12-11-2019',
    'status': 'Delivered',
    'price': '50',
    'quantity': '3'
  }
];
