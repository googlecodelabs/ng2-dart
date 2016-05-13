// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math' show Random;

import 'package:angular2/core.dart';

@Injectable()
class NameService {
  static final Random _indexGen = new Random();

  final List _names = [
    'Anne', 'Mary', 'Jack', 'Morgan', 'Roger',
    'Bill', 'Ragnar', 'Ed', 'John', 'Jane'
  ];
  final List _appellations = [
    'Jackal', 'King', 'Red', 'Stalwart', 'Axe',
    'Young', 'Brave', 'Eager', 'Wily', 'Zesty'
  ];

  String _randomFirstName() =>
      _names[_indexGen.nextInt(_names.length)];

  String _randomAppellation() =>
      _appellations[_indexGen.nextInt(_appellations.length)];

  String getPirateName(String firstName) {
    if (firstName == null || firstName.trim().isEmpty) {
      firstName = _randomFirstName();
    }

    return '$firstName the ${_randomAppellation()}';
  }
}
