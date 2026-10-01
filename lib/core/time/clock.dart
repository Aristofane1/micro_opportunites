import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'clock.g.dart';

/// Horloge injectable (figée dans les tests).
@Riverpod(keepAlive: true)
DateTime Function() clock(Ref ref) => DateTime.now;
