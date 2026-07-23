class RegisterValidators {
  static String? name(String? value, String requiredMessage) {
    if (value == null || value.trim().isEmpty) {
      return requiredMessage;
    }
    return null;
  }

  static String? email(
      String? value,
      String requiredMessage,
      String invalidEmailMessage,
      ) {
    if (value == null || value.trim().isEmpty) {
      return requiredMessage;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return invalidEmailMessage;
    }
    return null;
  }

  static String? password(
      String? value,
      String requiredMessage,
      String shortPasswordMessage,
      ) {
    if (value == null || value.trim().isEmpty) {
      return requiredMessage;
    }
    if (value.length < 6) {
      return shortPasswordMessage;
    }
    return null;
  }

  static String? phone(
      String? value,
      String requiredMessage,
      String invalidPhoneMessage,
      ) {
    if (value == null || value.trim().isEmpty) {
      return requiredMessage;
    }
    if (value.length < 8) {
      return invalidPhoneMessage;
    }
    return null;
  }
}
