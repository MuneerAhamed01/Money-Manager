enum ValidationType { email, password, name }

String? validateInput(ValidationType type, String input) {
  switch (type) {
    case ValidationType.email:
      return _validateEmail(input);
    case ValidationType.password:
      return _validatePassword(input);
    case ValidationType.name:
      return _validateName(input);
    default:
      return null;
  }
}

String? _validateEmail(String email) {
  if (email.isEmpty) {
    return 'Email cannot be empty';
  }
  // Basic email regex pattern
  String emailPattern = r'^[^@]+@[^@]+\.[^@]+';
  if (!RegExp(emailPattern).hasMatch(email)) {
    return 'Enter a valid email';
  }
  return null;
}

String? _validatePassword(String password) {
  if (password.isEmpty) {
    return 'Password cannot be empty';
  }
  if (password.length < 6) {
    return 'Password must be at least 6 characters long';
  }
  return null;
}

String? _validateName(String name) {
  if (name.isEmpty) {
    return 'Name cannot be empty';
  }
  if (name.length < 2) {
    return 'Name must be at least 2 characters long';
  }
  return null;
}
