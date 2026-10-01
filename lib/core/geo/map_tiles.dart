import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_tiles.g.dart';

/// Fournisseur de tuiles. Le serveur public OpenStreetMap n'est toléré
/// qu'en développement : remplacer [urlTemplate] par le fournisseur de
/// production (MapTiler, Stadia…) avant la mise en ligne.
abstract final class MapTiles {
  static const urlTemplate = 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
  static const userAgentPackageName = 'app.micro.opportunities';
  static const attribution = '© contributeurs OpenStreetMap';
}

/// Faux dans les tests : pas de requêtes de tuiles.
@Riverpod(keepAlive: true)
bool mapTilesEnabled(Ref ref) => true;
