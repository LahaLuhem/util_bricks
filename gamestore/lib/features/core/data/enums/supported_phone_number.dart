/// Phone numbers supported by the app
enum SupportedPhoneNumber {
  /// Dutch
  nl,

  /// Belgium
  be;

  /// phone-number number code
  String get countryPhoneCode {
    switch (this) {
      case SupportedPhoneNumber.nl:
        return '+31';
      case SupportedPhoneNumber.be:
        return '+32';
    }
  }

  /// phone-number country-name code
  String get countryCode {
    switch (this) {
      case SupportedPhoneNumber.nl:
        return 'NL';
      case SupportedPhoneNumber.be:
        return 'BE';
    }
  }
}
