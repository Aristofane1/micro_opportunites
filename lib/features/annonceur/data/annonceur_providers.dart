import 'package:micro_opportunites/core/network/api_client_provider.dart';
import 'package:micro_opportunites/features/annonceur/data/datasources/annonceur_remote_data_source.dart';
import 'package:micro_opportunites/features/annonceur/data/repositories/annonceur_repository_impl.dart';
import 'package:micro_opportunites/features/annonceur/domain/repositories/annonceur_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'annonceur_providers.g.dart';

@riverpod
AnnonceurRepository annonceurRepository(Ref ref) => AnnonceurRepositoryImpl(
  AnnonceurRemoteDataSource(ref.watch(apiClientProvider)),
);
