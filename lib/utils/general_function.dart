double convertToDouble(dynamic value) {
  if (value is String) {
    return double.parse(value);
  } else if (value is int) {
    return 0.00 + value;
  } else if (value == null) {
    return 0.0;
  } else {
    return value;
  }
}