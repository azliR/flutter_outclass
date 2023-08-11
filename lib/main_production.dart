// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:injectable/injectable.dart';
import 'package:outclass/bootstrap.dart';
import 'package:outclass/views/app.dart';

void main() {
  bootstrap(App.new, Environment.prod);
}
