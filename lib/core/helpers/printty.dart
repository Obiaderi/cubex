import 'dart:developer';

import 'package:flutter/foundation.dart';

void printty(dynamic val, {String? logLevel}) {
  if (kDebugMode) {
    log("==== ${logLevel ?? "Logger"} ==== ${val.toString()} ");
  }
}
