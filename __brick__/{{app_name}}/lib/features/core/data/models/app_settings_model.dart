class AppSettingsModel {
  final int userId;

  const AppSettingsModel({required this.userId});

  AppSettingsModel copyWith({int? userId}) => AppSettingsModel(
    userId: userId ?? this.userId,
  );

  @override
  String toString() =>
      'HiveAppSettingsObject{userId: $userId}';
}
