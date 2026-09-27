/// Icônes SVG du design (trait 2 px, grille 24). Utiliser via `AppIcon`.
enum AppIcons {
  explore('explore'),
  applications('applications'),
  earnings('earnings'),
  messages('messages'),
  profile('profile'),
  missions('missions'),
  publish('publish'),
  securePayment('secure_payment'),
  shield('shield'),
  shieldPending('shield_pending'),
  location('location'),
  locationCheck('location_check'),
  notifications('notifications'),
  report('report'),
  delete('delete'),
  media('media'),
  back('back'),
  forward('forward'),
  close('close'),
  flash('flash'),
  idRejected('id_rejected'),
  map('map'),
  search('search'),
  filters('filters'),
  list('list'),
  share('share'),
  check('check'),
  phone('phone'),
  clock('clock'),
  more('more'),
  categoryDelivery('category_delivery'),
  categoryShopping('category_shopping'),
  categoryComputer('category_computer'),
  categoryDataEntry('category_data_entry'),
  categoryCleaning('category_cleaning'),
  categoryEvent('category_event'),
  categoryRepair('category_repair'),
  categoryOther('category_other'),
  locate('locate'),
  smartphone('smartphone'),
  send('send'),
  reminder('reminder'),
  offline('offline'),
  lock('lock');

  const AppIcons(this._fileName);

  final String _fileName;

  String get path => 'assets/icons/$_fileName.svg';
}
