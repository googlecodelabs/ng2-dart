// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:angular2/core.dart';

@Component(
    selector: 'pirate-badge',
    templateUrl: 'badge_component.html',
    styleUrls: const ['badge_component.css'])
class BadgeComponent {
  String badgeName = '';
  String buttonText = 'Aye! Gimme a name!';
  bool isButtonEnabled = true;

  void generateBadge() {
    badgeName = 'Anne Bonney';
  }

  void updateBadge(String inputName) {
    badgeName = inputName;
    if (inputName.trim().isEmpty) {
      buttonText = 'Aye! Gimme a name!';
      isButtonEnabled = true;
    } else {
      buttonText = 'Arrr! Write yer name!';
      isButtonEnabled = false;
    }
  }
}
