import 'package:micro_opportunites/app/role/active_role.dart';
import 'package:micro_opportunites/app/role/active_role_provider.dart';
import 'package:micro_opportunites/app/router/app_routes.dart';
import 'package:micro_opportunites/core/error/result.dart';
import 'package:micro_opportunites/core/routing/entry_paths.dart';
import 'package:micro_opportunites/features/auth/domain/entities/auth_entities.dart';
import 'package:micro_opportunites/features/auth/domain/repositories/auth_repository.dart';

/// Règle de reprise de l'entrée, commune au splash (A01) et à la connexion
/// (A05) :
/// - prénom vide → A07 (profil) ;
/// - exécutant, ou rôle pas encore choisi, sans pièce d'identité → A08 ;
/// - pas de rôle → A13 ;
/// - sinon l'accueil du rôle.
String resumePath({
  required String firstName,
  required String? role,
  required KycStatus kyc,
}) {
  if (firstName.trim().isEmpty) return EntryPaths.profile;
  final active = ActiveRole.values.asNameMap()[role];
  if (active != ActiveRole.poster && kyc == KycStatus.none) {
    return EntryPaths.idDocument;
  }
  if (active == null) return EntryPaths.usage;
  return AppRoutes.homeFor(active);
}

/// Applique [resumePath] à un compte connecté : lit le statut de la pièce
/// d'identité quand la règle en dépend, restaure le rôle enregistré et
/// renvoie l'écran où reprendre. Un échec de lecture est renvoyé tel quel.
Future<Result<String>> resumeEntry({
  required AuthRepository auth,
  required ActiveRoleNotifier activeRole,
  required String firstName,
  required String? role,
}) async {
  final active = ActiveRole.values.asNameMap()[role];
  // Sans effet sur la règle quand le statut n'est pas lu.
  var kyc = KycStatus.verified;
  if (firstName.trim().isNotEmpty && active != ActiveRole.poster) {
    switch (await auth.fetchKycState()) {
      case Err(:final failure):
        return Err(failure);
      case Success(:final value):
        kyc = value.status;
    }
  }
  if (active != null) activeRole.switchTo(active);
  return Success(resumePath(firstName: firstName, role: role, kyc: kyc));
}
