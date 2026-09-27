/// Chemins des images SVG embarquées.
abstract final class AppImages {
  static const logoMark = 'assets/images/logo/logo_mark.svg';
  static const logoMarkSmall = 'assets/images/logo/logo_mark_small.svg';
  static const logoPin = 'assets/images/logo/logo_pin.svg';
  static const logoMono = 'assets/images/logo/logo_mono.svg';
  static const emptyPin = 'assets/images/logo/empty_pin.svg';

  static const onboardingFind =
      'assets/images/illustrations/onboarding_find.svg';
  static const onboardingSecure =
      'assets/images/illustrations/onboarding_secure.svg';
  static const onboardingTrust =
      'assets/images/illustrations/onboarding_trust.svg';

  static const illustrations = [
    onboardingFind,
    onboardingSecure,
    onboardingTrust,
  ];

  static const all = [
    logoMark,
    logoMarkSmall,
    logoPin,
    logoMono,
    emptyPin,
    ...illustrations,
  ];
}
