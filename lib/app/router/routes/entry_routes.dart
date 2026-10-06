import 'package:go_router/go_router.dart';
import 'package:micro_opportunites/app/router/routes/entry_role_pages.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:micro_opportunites/features/auth/presentation/pages/id_camera_page.dart';
import 'package:micro_opportunites/features/auth/presentation/pages/id_document_page.dart';
import 'package:micro_opportunites/features/auth/presentation/pages/profile_form_page.dart';
import 'package:micro_opportunites/features/auth/presentation/pages/verification_pending_page.dart';
import 'package:micro_opportunites/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:micro_opportunites/features/onboarding/presentation/pages/splash_screen.dart';

/// Parcours d'entrée (module A), rejoué à chaque lancement.
final entryRoutes = <RouteBase>[
  GoRoute(path: EntryPaths.splash, builder: (_, _) => const SplashScreen()),
  GoRoute(
    path: EntryPaths.onboarding,
    builder: (_, _) => const OnboardingPage(),
  ),
  GoRoute(path: EntryPaths.email, builder: (_, _) => const EntryEmail()),
  GoRoute(path: EntryPaths.profile, builder: (_, _) => const ProfileFormPage()),
  GoRoute(
    path: EntryPaths.idDocument,
    builder: (_, _) => const IdDocumentPage(),
  ),
  GoRoute(
    path: EntryPaths.cameraFront,
    builder: (_, _) => const IdCameraPage(isFront: true),
  ),
  GoRoute(
    path: EntryPaths.cameraBack,
    builder: (_, _) => const IdCameraPage(isFront: false),
  ),
  GoRoute(
    path: EntryPaths.verificationPending,
    builder: (_, _) => const VerificationPendingPage(),
  ),
  GoRoute(path: EntryPaths.usage, builder: (_, _) => const EntryUsageChoice()),
  GoRoute(
    path: EntryPaths.permissions,
    builder: (_, _) => const EntryPermissions(),
  ),
];
