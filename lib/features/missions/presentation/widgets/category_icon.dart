import 'package:micro_opportunites/core/assets/app_icons.dart';
import 'package:micro_opportunites/features/missions/domain/entities/mission_category.dart';

AppIcons missionCategoryIcon(MissionCategory category) => switch (category) {
  MissionCategory.event || MissionCategory.flyers => AppIcons.categoryEvent,
  MissionCategory.delivery => AppIcons.categoryDelivery,
  MissionCategory.shopping => AppIcons.categoryShopping,
  MissionCategory.computer => AppIcons.categoryComputer,
  MissionCategory.dataEntry => AppIcons.categoryDataEntry,
  MissionCategory.cleaning => AppIcons.categoryCleaning,
  MissionCategory.repair => AppIcons.categoryRepair,
  MissionCategory.other => AppIcons.categoryOther,
};
