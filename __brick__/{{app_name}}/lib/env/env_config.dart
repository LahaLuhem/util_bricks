import '/features/core/data/enums/environment_type.dart';

// part 'env.g.dart';

/// Wrapper for providing the correct Environment-specific keys
class EnvConfig {
  /// Constructor
  EnvConfig({required EnvironmentType environmentType}) {
    switch (environmentType) {
      case EnvironmentType.dev:
        break;
      case EnvironmentType.live:
        break;
    }
  }
}

/// Envied path for the dev environment
// @Envied(path: 'lib/env/keystore/.env.dev')
// class _EnvDev implements EnvConfig {}
//
// /// Envied path for the production environment
// @Envied(path: 'lib/env/keystore/.env.prod')
// class _EnvProd implements EnvConfig {}
