enum Routes {
  /// Splash Screen
  splash,

  /// Auth Screens
  auth,

  /// Onboarding Screens
  welcome,
  onboarding1,


}

extension RoutesExtension on Routes {
  String get path => name.withSlashPrefix;
  String get subPath => name;
}

extension RoutesHelper on String {
  String get lastRoutePath => substring(lastIndexOf('/') + 1);
  String get withSlashPrefix => startsWith('/') ? this : '/$this';
}
