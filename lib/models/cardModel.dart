// // Copyright (c) 2020 Aniket Malik [aniketmalikwork@gmail.com]
// // All Rights Reserved.
// //
// // NOTICE: All information contained herein is, and remains the
// // property of Aniket Malik. The intellectual and technical concepts
// // contained herein are proprietary to Aniket Malik and are protected
// // by trade secret or copyright law.
// //
// // Dissemination of this information or reproduction of this material
// // is strictly forbidden unless prior written permission is obtained from
// // Aniket Malik.
//
// // @dart=2.9
//
// import 'package:flutter/foundation.dart';
//
// import '../enums/enums.dart';
//
// class CardModel {
//   final String number, exp, cardHolderName, bankName;
//   final CardType type;
//
//   const CardModel({
//     @required this.number,
//     @required this.exp,
//     @required this.cardHolderName,
//     @required this.bankName,
//     @required this.type,
//   });
//
//   CardModel.fromJson(Map<String, dynamic> json)
//       : number = json['number'] ?? '',
//         exp = getExpFromMap(json['exp']),
//         cardHolderName = json['cardOwner'] ?? '',
//         bankName = json['bankName'] ?? '',
//         type = getCardTypeFromString(json['type']);
//
//   const CardModel.empty({
//     this.number = '',
//     this.exp = '',
//     this.cardHolderName = '',
//     this.bankName = '',
//     this.type = CardType.VISA,
//   });
//
//   static CardType getCardTypeFromString(String value) {
//     switch (value) {
//       case 'visa':
//         return CardType.VISA;
//         break;
//
//       case 'master':
//         return CardType.MASTER;
//         break;
//
//       default:
//         return CardType.VISA;
//     }
//   }
//
//   static String getExpFromMap(Map<String, dynamic> json) {
//     return '${json["month"]}/${json["year"]}';
//   }
// }
