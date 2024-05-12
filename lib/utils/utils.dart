import 'package:flutter/foundation.dart';

printIfDebug(String message) {
  if (kDebugMode) {
    print(message);
  }
}