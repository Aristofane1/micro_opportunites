import 'package:micro_opportunites/core/geo/location_service.dart';
import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/features/missions/data/datasources/missions_remote_data_source.dart';
import 'package:micro_opportunites/features/missions/data/repositories/missions_repository_impl.dart';
import 'package:micro_opportunites/features/missions/domain/repositories/missions_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'missions_providers.g.dart';

/// Attente maximale de la position pour Explorer : au-delà, la liste se
/// charge autour de la position du profil (le check-in garde le délai GPS).
const exploreLocationTimeout = Duration(seconds: 4);

@riverpod
MissionsRepository missionsRepository(Ref ref) => MissionsRepositoryImpl(
  MissionsRemoteDataSource(
    ref.watch(apiClientProvider),
    devicePosition: () async {
      try {
        return await tryCurrentPosition(
          ref.read(locationServiceProvider),
          timeout: exploreLocationTimeout,
        );
      } catch (_) {
        // Pas de service de localisation (non surchargé) : position du profil.
        return null;
      }
    },
  ),
);
