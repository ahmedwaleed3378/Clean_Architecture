import 'package:advanced_course/app/constants.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return AppConstants.empty;
    } else {
      return this!;
    }
  }
}

extension NonNullInt on int? {
  int orZero() {
    if (this == null) {
      return AppConstants.zero;
    } else {
      return this!;
    }
  }
}
