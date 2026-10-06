// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assignment_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AssignmentModel {

 String get id; String get missionId; String get title; String get status; String get startAt; int get durationMin; int get payAmount; String get city; String get district; String get address; String get landmark; double get lat; double get lng; String get briefing; String get posterName; String get payoutOperator; double get distanceKm; int get travelMinutes; String? get checkInAt; int? get checkInDistanceM; String? get checkOutAt; String? get note; List<String> get photos; String? get autoValidateAt; String? get contestReason; String? get cancelledBy;
/// Create a copy of AssignmentModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssignmentModelCopyWith<AssignmentModel> get copyWith => _$AssignmentModelCopyWithImpl<AssignmentModel>(this as AssignmentModel, _$identity);

  /// Serializes this AssignmentModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssignmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.missionId, missionId) || other.missionId == missionId)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMin, durationMin) || other.durationMin == durationMin)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.city, city) || other.city == city)&&(identical(other.district, district) || other.district == district)&&(identical(other.address, address) || other.address == address)&&(identical(other.landmark, landmark) || other.landmark == landmark)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.briefing, briefing) || other.briefing == briefing)&&(identical(other.posterName, posterName) || other.posterName == posterName)&&(identical(other.payoutOperator, payoutOperator) || other.payoutOperator == payoutOperator)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.travelMinutes, travelMinutes) || other.travelMinutes == travelMinutes)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.checkInDistanceM, checkInDistanceM) || other.checkInDistanceM == checkInDistanceM)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other.photos, photos)&&(identical(other.autoValidateAt, autoValidateAt) || other.autoValidateAt == autoValidateAt)&&(identical(other.contestReason, contestReason) || other.contestReason == contestReason)&&(identical(other.cancelledBy, cancelledBy) || other.cancelledBy == cancelledBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,missionId,title,status,startAt,durationMin,payAmount,city,district,address,landmark,lat,lng,briefing,posterName,payoutOperator,distanceKm,travelMinutes,checkInAt,checkInDistanceM,checkOutAt,note,const DeepCollectionEquality().hash(photos),autoValidateAt,contestReason,cancelledBy]);

@override
String toString() {
  return 'AssignmentModel(id: $id, missionId: $missionId, title: $title, status: $status, startAt: $startAt, durationMin: $durationMin, payAmount: $payAmount, city: $city, district: $district, address: $address, landmark: $landmark, lat: $lat, lng: $lng, briefing: $briefing, posterName: $posterName, payoutOperator: $payoutOperator, distanceKm: $distanceKm, travelMinutes: $travelMinutes, checkInAt: $checkInAt, checkInDistanceM: $checkInDistanceM, checkOutAt: $checkOutAt, note: $note, photos: $photos, autoValidateAt: $autoValidateAt, contestReason: $contestReason, cancelledBy: $cancelledBy)';
}


}

/// @nodoc
abstract mixin class $AssignmentModelCopyWith<$Res>  {
  factory $AssignmentModelCopyWith(AssignmentModel value, $Res Function(AssignmentModel) _then) = _$AssignmentModelCopyWithImpl;
@useResult
$Res call({
 String id, String missionId, String title, String status, String startAt, int durationMin, int payAmount, String city, String district, String address, String landmark, double lat, double lng, String briefing, String posterName, String payoutOperator, double distanceKm, int travelMinutes, String? checkInAt, int? checkInDistanceM, String? checkOutAt, String? note, List<String> photos, String? autoValidateAt, String? contestReason, String? cancelledBy
});




}
/// @nodoc
class _$AssignmentModelCopyWithImpl<$Res>
    implements $AssignmentModelCopyWith<$Res> {
  _$AssignmentModelCopyWithImpl(this._self, this._then);

  final AssignmentModel _self;
  final $Res Function(AssignmentModel) _then;

/// Create a copy of AssignmentModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? missionId = null,Object? title = null,Object? status = null,Object? startAt = null,Object? durationMin = null,Object? payAmount = null,Object? city = null,Object? district = null,Object? address = null,Object? landmark = null,Object? lat = null,Object? lng = null,Object? briefing = null,Object? posterName = null,Object? payoutOperator = null,Object? distanceKm = null,Object? travelMinutes = null,Object? checkInAt = freezed,Object? checkInDistanceM = freezed,Object? checkOutAt = freezed,Object? note = freezed,Object? photos = null,Object? autoValidateAt = freezed,Object? contestReason = freezed,Object? cancelledBy = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,missionId: null == missionId ? _self.missionId : missionId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String,durationMin: null == durationMin ? _self.durationMin : durationMin // ignore: cast_nullable_to_non_nullable
as int,payAmount: null == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,landmark: null == landmark ? _self.landmark : landmark // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,briefing: null == briefing ? _self.briefing : briefing // ignore: cast_nullable_to_non_nullable
as String,posterName: null == posterName ? _self.posterName : posterName // ignore: cast_nullable_to_non_nullable
as String,payoutOperator: null == payoutOperator ? _self.payoutOperator : payoutOperator // ignore: cast_nullable_to_non_nullable
as String,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,travelMinutes: null == travelMinutes ? _self.travelMinutes : travelMinutes // ignore: cast_nullable_to_non_nullable
as int,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as String?,checkInDistanceM: freezed == checkInDistanceM ? _self.checkInDistanceM : checkInDistanceM // ignore: cast_nullable_to_non_nullable
as int?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,autoValidateAt: freezed == autoValidateAt ? _self.autoValidateAt : autoValidateAt // ignore: cast_nullable_to_non_nullable
as String?,contestReason: freezed == contestReason ? _self.contestReason : contestReason // ignore: cast_nullable_to_non_nullable
as String?,cancelledBy: freezed == cancelledBy ? _self.cancelledBy : cancelledBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AssignmentModel].
extension AssignmentModelPatterns on AssignmentModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssignmentModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssignmentModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssignmentModel value)  $default,){
final _that = this;
switch (_that) {
case _AssignmentModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssignmentModel value)?  $default,){
final _that = this;
switch (_that) {
case _AssignmentModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String missionId,  String title,  String status,  String startAt,  int durationMin,  int payAmount,  String city,  String district,  String address,  String landmark,  double lat,  double lng,  String briefing,  String posterName,  String payoutOperator,  double distanceKm,  int travelMinutes,  String? checkInAt,  int? checkInDistanceM,  String? checkOutAt,  String? note,  List<String> photos,  String? autoValidateAt,  String? contestReason,  String? cancelledBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssignmentModel() when $default != null:
return $default(_that.id,_that.missionId,_that.title,_that.status,_that.startAt,_that.durationMin,_that.payAmount,_that.city,_that.district,_that.address,_that.landmark,_that.lat,_that.lng,_that.briefing,_that.posterName,_that.payoutOperator,_that.distanceKm,_that.travelMinutes,_that.checkInAt,_that.checkInDistanceM,_that.checkOutAt,_that.note,_that.photos,_that.autoValidateAt,_that.contestReason,_that.cancelledBy);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String missionId,  String title,  String status,  String startAt,  int durationMin,  int payAmount,  String city,  String district,  String address,  String landmark,  double lat,  double lng,  String briefing,  String posterName,  String payoutOperator,  double distanceKm,  int travelMinutes,  String? checkInAt,  int? checkInDistanceM,  String? checkOutAt,  String? note,  List<String> photos,  String? autoValidateAt,  String? contestReason,  String? cancelledBy)  $default,) {final _that = this;
switch (_that) {
case _AssignmentModel():
return $default(_that.id,_that.missionId,_that.title,_that.status,_that.startAt,_that.durationMin,_that.payAmount,_that.city,_that.district,_that.address,_that.landmark,_that.lat,_that.lng,_that.briefing,_that.posterName,_that.payoutOperator,_that.distanceKm,_that.travelMinutes,_that.checkInAt,_that.checkInDistanceM,_that.checkOutAt,_that.note,_that.photos,_that.autoValidateAt,_that.contestReason,_that.cancelledBy);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String missionId,  String title,  String status,  String startAt,  int durationMin,  int payAmount,  String city,  String district,  String address,  String landmark,  double lat,  double lng,  String briefing,  String posterName,  String payoutOperator,  double distanceKm,  int travelMinutes,  String? checkInAt,  int? checkInDistanceM,  String? checkOutAt,  String? note,  List<String> photos,  String? autoValidateAt,  String? contestReason,  String? cancelledBy)?  $default,) {final _that = this;
switch (_that) {
case _AssignmentModel() when $default != null:
return $default(_that.id,_that.missionId,_that.title,_that.status,_that.startAt,_that.durationMin,_that.payAmount,_that.city,_that.district,_that.address,_that.landmark,_that.lat,_that.lng,_that.briefing,_that.posterName,_that.payoutOperator,_that.distanceKm,_that.travelMinutes,_that.checkInAt,_that.checkInDistanceM,_that.checkOutAt,_that.note,_that.photos,_that.autoValidateAt,_that.contestReason,_that.cancelledBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AssignmentModel extends AssignmentModel {
  const _AssignmentModel({required this.id, required this.missionId, required this.title, required this.status, required this.startAt, required this.durationMin, required this.payAmount, required this.city, required this.district, required this.address, required this.landmark, required this.lat, required this.lng, required this.briefing, required this.posterName, required this.payoutOperator, required this.distanceKm, required this.travelMinutes, this.checkInAt, this.checkInDistanceM, this.checkOutAt, this.note, final  List<String> photos = const <String>[], this.autoValidateAt, this.contestReason, this.cancelledBy}): _photos = photos,super._();
  factory _AssignmentModel.fromJson(Map<String, dynamic> json) => _$AssignmentModelFromJson(json);

@override final  String id;
@override final  String missionId;
@override final  String title;
@override final  String status;
@override final  String startAt;
@override final  int durationMin;
@override final  int payAmount;
@override final  String city;
@override final  String district;
@override final  String address;
@override final  String landmark;
@override final  double lat;
@override final  double lng;
@override final  String briefing;
@override final  String posterName;
@override final  String payoutOperator;
@override final  double distanceKm;
@override final  int travelMinutes;
@override final  String? checkInAt;
@override final  int? checkInDistanceM;
@override final  String? checkOutAt;
@override final  String? note;
 final  List<String> _photos;
@override@JsonKey() List<String> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

@override final  String? autoValidateAt;
@override final  String? contestReason;
@override final  String? cancelledBy;

/// Create a copy of AssignmentModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssignmentModelCopyWith<_AssignmentModel> get copyWith => __$AssignmentModelCopyWithImpl<_AssignmentModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AssignmentModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssignmentModel&&(identical(other.id, id) || other.id == id)&&(identical(other.missionId, missionId) || other.missionId == missionId)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMin, durationMin) || other.durationMin == durationMin)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.city, city) || other.city == city)&&(identical(other.district, district) || other.district == district)&&(identical(other.address, address) || other.address == address)&&(identical(other.landmark, landmark) || other.landmark == landmark)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.briefing, briefing) || other.briefing == briefing)&&(identical(other.posterName, posterName) || other.posterName == posterName)&&(identical(other.payoutOperator, payoutOperator) || other.payoutOperator == payoutOperator)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.travelMinutes, travelMinutes) || other.travelMinutes == travelMinutes)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.checkInDistanceM, checkInDistanceM) || other.checkInDistanceM == checkInDistanceM)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other._photos, _photos)&&(identical(other.autoValidateAt, autoValidateAt) || other.autoValidateAt == autoValidateAt)&&(identical(other.contestReason, contestReason) || other.contestReason == contestReason)&&(identical(other.cancelledBy, cancelledBy) || other.cancelledBy == cancelledBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,missionId,title,status,startAt,durationMin,payAmount,city,district,address,landmark,lat,lng,briefing,posterName,payoutOperator,distanceKm,travelMinutes,checkInAt,checkInDistanceM,checkOutAt,note,const DeepCollectionEquality().hash(_photos),autoValidateAt,contestReason,cancelledBy]);

@override
String toString() {
  return 'AssignmentModel(id: $id, missionId: $missionId, title: $title, status: $status, startAt: $startAt, durationMin: $durationMin, payAmount: $payAmount, city: $city, district: $district, address: $address, landmark: $landmark, lat: $lat, lng: $lng, briefing: $briefing, posterName: $posterName, payoutOperator: $payoutOperator, distanceKm: $distanceKm, travelMinutes: $travelMinutes, checkInAt: $checkInAt, checkInDistanceM: $checkInDistanceM, checkOutAt: $checkOutAt, note: $note, photos: $photos, autoValidateAt: $autoValidateAt, contestReason: $contestReason, cancelledBy: $cancelledBy)';
}


}

/// @nodoc
abstract mixin class _$AssignmentModelCopyWith<$Res> implements $AssignmentModelCopyWith<$Res> {
  factory _$AssignmentModelCopyWith(_AssignmentModel value, $Res Function(_AssignmentModel) _then) = __$AssignmentModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String missionId, String title, String status, String startAt, int durationMin, int payAmount, String city, String district, String address, String landmark, double lat, double lng, String briefing, String posterName, String payoutOperator, double distanceKm, int travelMinutes, String? checkInAt, int? checkInDistanceM, String? checkOutAt, String? note, List<String> photos, String? autoValidateAt, String? contestReason, String? cancelledBy
});




}
/// @nodoc
class __$AssignmentModelCopyWithImpl<$Res>
    implements _$AssignmentModelCopyWith<$Res> {
  __$AssignmentModelCopyWithImpl(this._self, this._then);

  final _AssignmentModel _self;
  final $Res Function(_AssignmentModel) _then;

/// Create a copy of AssignmentModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? missionId = null,Object? title = null,Object? status = null,Object? startAt = null,Object? durationMin = null,Object? payAmount = null,Object? city = null,Object? district = null,Object? address = null,Object? landmark = null,Object? lat = null,Object? lng = null,Object? briefing = null,Object? posterName = null,Object? payoutOperator = null,Object? distanceKm = null,Object? travelMinutes = null,Object? checkInAt = freezed,Object? checkInDistanceM = freezed,Object? checkOutAt = freezed,Object? note = freezed,Object? photos = null,Object? autoValidateAt = freezed,Object? contestReason = freezed,Object? cancelledBy = freezed,}) {
  return _then(_AssignmentModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,missionId: null == missionId ? _self.missionId : missionId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String,durationMin: null == durationMin ? _self.durationMin : durationMin // ignore: cast_nullable_to_non_nullable
as int,payAmount: null == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,landmark: null == landmark ? _self.landmark : landmark // ignore: cast_nullable_to_non_nullable
as String,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,briefing: null == briefing ? _self.briefing : briefing // ignore: cast_nullable_to_non_nullable
as String,posterName: null == posterName ? _self.posterName : posterName // ignore: cast_nullable_to_non_nullable
as String,payoutOperator: null == payoutOperator ? _self.payoutOperator : payoutOperator // ignore: cast_nullable_to_non_nullable
as String,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,travelMinutes: null == travelMinutes ? _self.travelMinutes : travelMinutes // ignore: cast_nullable_to_non_nullable
as int,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as String?,checkInDistanceM: freezed == checkInDistanceM ? _self.checkInDistanceM : checkInDistanceM // ignore: cast_nullable_to_non_nullable
as int?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as String?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,autoValidateAt: freezed == autoValidateAt ? _self.autoValidateAt : autoValidateAt // ignore: cast_nullable_to_non_nullable
as String?,contestReason: freezed == contestReason ? _self.contestReason : contestReason // ignore: cast_nullable_to_non_nullable
as String?,cancelledBy: freezed == cancelledBy ? _self.cancelledBy : cancelledBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
