// ignore_for_file: prefer-match-file-name

extension AsCallback<T extends Object> on T {
  T Function() get asCallback => () => this;
}
