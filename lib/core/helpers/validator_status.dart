class ValidatorStatus {
  bool hasAtleast8Character;
  bool containsUpperCase;
  //bool containsLowerCase;
  bool containsANumber;
  bool containsSpecialCharacter;
  bool isValid;

  ValidatorStatus(
      {this.hasAtleast8Character = false,
      // this.containsLowerCase = false,
      this.containsUpperCase = false,
      this.containsANumber = false,
      this.containsSpecialCharacter = false,
      this.isValid = false});
}

class PasswordValidatorService {
  bool _passowordIsValid(ValidatorStatus status) {
    return status.hasAtleast8Character &&
        status.containsUpperCase &&
        // status.containsLowerCase &&
        status.containsANumber &&
        status.containsSpecialCharacter;
  }

  validate(String value) {
    if (value.isEmpty) {
      return ValidatorStatus();
    }

    RegExp numbers = RegExp(r'[0-9]');
    //RegExp lowerCaseLetter = RegExp(r'[a-z]');
    RegExp upperCaseLetter = RegExp(r'[A-Z]');
    RegExp specialCharacter = RegExp(r'[@~`!@#$%^&*()_?.-]');

    final status = ValidatorStatus();
    status.hasAtleast8Character = value.length >= 8;
    // status.containsLowerCase = lowerCaseLetter.hasMatch(value);
    status.containsUpperCase = upperCaseLetter.hasMatch(value);
    status.containsSpecialCharacter = specialCharacter.hasMatch(value);
    status.containsANumber = numbers.hasMatch(value);
    status.isValid = _passowordIsValid(status);

    return status;
  }

  passwordMatch(String value1, String value2) {
    return value1.trim() == value2.trim();
  }
}
