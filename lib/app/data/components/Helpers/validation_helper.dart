class Validations {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return 'Please enter email';
    final RegExp nameExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    if (!nameExp.hasMatch(value.trim())) return 'Please enter valid email';
    return null;
  }

  static String? validatePassword(String? value) {
    RegExp regex = RegExp(r'.{6,}$');
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Please enter a valid password containing 6 characters';
      } else {
        return null;
      }
    }
  }

  static String? validateConformPassword(String? value) {
    if (value!.isEmpty) {
      return 'Please enter password';
    }
    return null;
  }

  static String? validateMobilenumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter number';
    } else if (value.trim().length < 10) {
      return 'Please enter valid number';
    }
    return null;
  }

  static String? validateZipCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter ZipCode';
    } else if (value.trim().length < 6) {
      return 'Please enter valid zipCode';
    }
    return null;
  }

  static String? validateFname(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter valid name';
    }
    return null;
  }

  static String? validateLAddressLine1(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter address line 1';
    }
    return null;
  }

  static String? validateLAddressLine2(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter address line 2';
    }
    return null;
  }

  static String? validateLCity(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter city name';
    }
    return null;
  }

  static String? validateLState(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter state name';
    }
    return null;
  }

  static String? validatePostalCode(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter postal code number';
    }
    return null;
  }

  static String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter full address';
    }
    return null;
  }

  static String? validateLFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter contact person name';
    }
    return null;
  }

  static String? validateRestroName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter restaurant name';
    }
    return null;
  }

  static String? validateLLastName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter last name';
    }
    return null;
  }

  static String? validateApproxPrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter approx price';
    }
    return null;
  }

  static String? validateSubjectOfSupport(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter subject';
    }
    return null;
  }

  static String? validateQueryOfSupport(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter query';
    }
    return null;
  }

  static String? validateCanNotBeEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return 'this field is required.';
    }
    return null;
  }  static String? isRequired(String? value) {
    if (value == null || value.isEmpty) {
      return '* Required.';
    }
    return null;
  }
}
