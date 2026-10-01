import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:micro_opportunites/features/onboarding/presentation/pages/splash_screen.dart';
import 'package:micro_opportunites/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:micro_opportunites/features/auth/presentation/pages/phone_input_page.dart';
import 'package:micro_opportunites/features/auth/presentation/pages/otp_page.dart';
import 'package:micro_opportunites/features/auth/presentation/pages/profile_form_page.dart';
import 'package:micro_opportunites/features/auth/presentation/pages/id_document_page.dart';
import 'package:micro_opportunites/features/auth/presentation/pages/verification_pending_page.dart';
import 'package:micro_opportunites/features/auth/presentation/pages/id_camera_page.dart';
import 'package:micro_opportunites/features/preferences/presentation/pages/usage_choice_page.dart';
import 'package:micro_opportunites/features/preferences/presentation/pages/permissions_page.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: '/auth/phone',
        builder: (context, state) => const PhoneInputPage(),
      ),
      GoRoute(path: '/auth/otp', builder: (context, state) => const OtpPage()),
      GoRoute(
        path: '/auth/profile',
        builder: (context, state) => const ProfileFormPage(),
      ),
      GoRoute(
        path: '/auth/id-document',
        builder: (context, state) => const IdDocumentPage(),
      ),
      GoRoute(
        path: '/auth/camera-front',
        builder: (context, state) => const IdCameraPage(isFront: true),
      ),
      GoRoute(
        path: '/auth/camera-back',
        builder: (context, state) => const IdCameraPage(isFront: false),
      ),
      GoRoute(
        path: '/auth/verification-pending',
        builder: (context, state) => const VerificationPendingPage(),
      ),
      GoRoute(
        path: '/preferences/usage',
        builder: (context, state) => const UsageChoicePage(),
      ),
      GoRoute(
        path: '/preferences/permissions',
        builder: (context, state) => const PermissionsPage(),
      ),
    ],
  );
});
