// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:math' show Random;

import 'package:angular2/core.dart';

const _namesPath =
    'https://www.dartlang.org/codelabs/darrrt/files/piratenames.json';

@Injectable()
class NameService {
  final Random _indexGen = new Random();

  final _names = <String>[];
  final _appellations = <String>[];

  String _randomFirstName() => _names[_indexGen.nextInt(_names.length)];

  String _randomAppellation() =>
      _appellations[_indexGen.nextInt(_appellations.length)];

  Future readyThePirates() async {
    if (_names.isNotEmpty && _appellations.isNotEmpty) return;

    var jsonString = await HttpRequest.getString(_namesPath);
    var pirateNames = JSON.decode(jsonString);
    _names.addAll(pirateNames['names']);
    _appellations.addAll(pirateNames['appellations']);
  }

  String getPirateName(String firstName) {
    if (firstName == null || firstName.trim().isEmpty) {
      firstName = _randomFirstName();
    }

    return '$firstName the ${_randomAppellation()}';
  }
}
