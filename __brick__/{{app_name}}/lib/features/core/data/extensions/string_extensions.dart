///extension
extension StringExtensions on String {
  /// Capitalizes the first letter of every word, except some exceptions such as
  /// articles, numeral-names, place-words etc.
  String get capitalizeWithBlockedValues {
    final blockedValues = ['op', 'de', 'het', 'een', "'s-", '‘s-'];

    String capitaliseFirst(String value, List<String> blockedValues) =>
        value.isNotEmpty && !value._isBlocked(blockedValues)
            ? value[0].toUpperCase() + (value.length > 1 ? value.substring(1).toLowerCase() : '')
            : value.toLowerCase();

    return split(' ')
        .map(
          (nonCapitalised) => nonCapitalised
              .split('-')
              .map((nonCapitalised) => capitaliseFirst(nonCapitalised, blockedValues))
              .join('-'),
        )
        .join(' ');
  }

  /// Returns the character-wise difference.
  String difference(String? other) {
    if (other != null) {
      if (length == other.length) {
        return '';
      } else if (length > other.length) {
        return replaceAll(other, '');
      } else {
        return other.replaceAll(this, '');
      }
    } else if (other == null) {
      return this;
    } else {
      return '';
    }
  }

  bool _isBlocked(List<String> blockedValues) => blockedValues.contains(toLowerCase());
}
