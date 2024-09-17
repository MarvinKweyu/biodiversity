class FormValidators {
  String? emailValidator(String value) {
    if (value.isEmpty) {
      return 'Email address is required.';
    }
    final emailRegEx = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    if (!emailRegEx.hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? passwordValidator(String value) {
    if (value.isEmpty) {
      return 'Password is required.';
    }
    return null;
  }

  String? phoneNumberValidator(String value) {
    if (value.isEmpty) {
      return 'Phone number is required.';
    }
    final phoneRegEx = RegExp(r'^[0-9]{10}$');
    if (!phoneRegEx.hasMatch(value)) {
      return 'Please enter a valid phone number.';
    }
    return null;
  }

  String? nameValidator(String value) {
    if (value.isEmpty) {
      return 'Name is required.';
    }

    if (value.trim().length < 3) {
      return 'Name must be more than three characters.';
    }

    if (value.contains(' ')) {
      return 'Name cannot contain spaces.';
    }

    return null;
  }

  String? genericValidator(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }

    if (value.trim().length < 3) {
      return '$fieldName must be more than three characters.';
    }
    return null;
  }

  String? numValidator(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required.';
    }

    if (double.tryParse(value) == null) {
      return '$fieldName should be a number.';
    }

    if (double.tryParse(value)! < 0) {
      return '$fieldName must be a non-negative number.';
    }
    return null;
  }

  String? passwordConfirmValidator(String value, String password) {
    if (value.isEmpty) {
      return 'Password confirm is required.';
    }
    if (value != password) {
      return 'Password confirm must be equal to password.';
    }
    return null;
  }
}
