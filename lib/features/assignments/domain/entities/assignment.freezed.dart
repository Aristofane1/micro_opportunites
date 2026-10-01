// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assignment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Assignment {

 String get id; String get missionId; String get title; AssignmentStatus get status; DateTime get startAt; int get durationMinutes; int get payAmount; String get city; String get district; String get address; String get landmark; double get latitude; double get longitude; String get briefing; String get posterName; String get payoutOperator; double get distanceKm; int get travelMinutes; DateTime? get checkInAt; int? get checkInDistanceMeters; DateTime? get checkOutAt; String? get note; List<String> get photos; DateTime? get autoValidateAt;
/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssignmentCopyWith<Assignment> get copyWith => _$AssignmentCopyWithImpl<Assignment>(this as Assignment, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Assignment&&(identical(other.id, id) || other.id == id)&&(identical(other.missionId, missionId) || other.missionId == missionId)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.city, city) || other.city == city)&&(identical(other.district, district) || other.district == district)&&(identical(other.address, address) || other.address == address)&&(identical(other.landmark, landmark) || other.landmark == landmark)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.briefing, briefing) || other.briefing == briefing)&&(identical(other.posterName, posterName) || other.posterName == posterName)&&(identical(other.payoutOperator, payoutOperator) || other.payoutOperator == payoutOperator)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.travelMinutes, travelMinutes) || other.travelMinutes == travelMinutes)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.checkInDistanceMeters, checkInDistanceMeters) || other.checkInDistanceMeters == checkInDistanceMeters)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other.photos, photos)&&(identical(other.autoValidateAt, autoValidateAt) || other.autoValidateAt == autoValidateAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,missionId,title,status,startAt,durationMinutes,payAmount,city,district,address,landmark,latitude,longitude,briefing,posterName,payoutOperator,distanceKm,travelMinutes,checkInAt,checkInDistanceMeters,checkOutAt,note,const DeepCollectionEquality().hash(photos),autoValidateAt]);

@override
String toString() {
  return 'Assignment(id: $id, missionId: $missionId, title: $title, status: $status, startAt: $startAt, durationMinutes: $durationMinutes, payAmount: $payAmount, city: $city, district: $district, address: $address, landmark: $landmark, latitude: $latitude, longitude: $longitude, briefing: $briefing, posterName: $posterName, payoutOperator: $payoutOperator, distanceKm: $distanceKm, travelMinutes: $travelMinutes, checkInAt: $checkInAt, checkInDistanceMeters: $checkInDistanceMeters, checkOutAt: $checkOutAt, note: $note, photos: $photos, autoValidateAt: $autoValidateAt)';
}


}

/// @nodoc
abstract mixin class $AssignmentCopyWith<$Res>  {
  factory $AssignmentCopyWith(Assignment value, $Res Function(Assignment) _then) = _$AssignmentCopyWithImpl;
@useResult
$Res call({
 String id, String missionId, String title, AssignmentStatus status, DateTime startAt, int durationMinutes, int payAmount, String city, String district, String address, String landmark, double latitude, double longitude, String briefing, String posterName, String payoutOperator, double distanceKm, int travelMinutes, DateTime? checkInAt, int? checkInDistanceMeters, DateTime? checkOutAt, String? note, List<String> photos, DateTime? autoValidateAt
});




}
/// @nodoc
class _$AssignmentCopyWithImpl<$Res>
    implements $AssignmentCopyWith<$Res> {
  _$AssignmentCopyWithImpl(this._self, this._then);

  final Assignment _self;
  final $Res Function(Assignment) _then;

/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? missionId = null,Object? title = null,Object? status = null,Object? startAt = null,Object? durationMinutes = null,Object? payAmount = null,Object? city = null,Object? district = null,Object? address = null,Object? landmark = null,Object? latitude = null,Object? longitude = null,Object? briefing = null,Object? posterName = null,Object? payoutOperator = null,Object? distanceKm = null,Object? travelMinutes = null,Object? checkInAt = freezed,Object? checkInDistanceMeters = freezed,Object? checkOutAt = freezed,Object? note = freezed,Object? photos = null,Object? autoValidateAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,missionId: null == missionId ? _self.missionId : missionId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AssignmentStatus,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,payAmount: null == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,landmark: null == landmark ? _self.landmark : landmark // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,briefing: null == briefing ? _self.briefing : briefing // ignore: cast_nullable_to_non_nullable
as String,posterName: null == posterName ? _self.posterName : posterName // ignore: cast_nullable_to_non_nullable
as String,payoutOperator: null == payoutOperator ? _self.payoutOperator : payoutOperator // ignore: cast_nullable_to_non_nullable
as String,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,travelMinutes: null == travelMinutes ? _self.travelMinutes : travelMinutes // ignore: cast_nullable_to_non_nullable
as int,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkInDistanceMeters: freezed == checkInDistanceMeters ? _self.checkInDistanceMeters : checkInDistanceMeters // ignore: cast_nullable_to_non_nullable
as int?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as DateTime?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self.photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,autoValidateAt: freezed == autoValidateAt ? _self.autoValidateAt : autoValidateAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Assignment].
extension AssignmentPatterns on Assignment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Assignment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Assignment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Assignment value)  $default,){
final _that = this;
switch (_that) {
case _Assignment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Assignment value)?  $default,){
final _that = this;
switch (_that) {
case _Assignment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String missionId,  String title,  AssignmentStatus status,  DateTime startAt,  int durationMinutes,  int payAmount,  String city,  String district,  String address,  String landmark,  double latitude,  double longitude,  String briefing,  String posterName,  String payoutOperator,  double distanceKm,  int travelMinutes,  DateTime? checkInAt,  int? checkInDistanceMeters,  DateTime? checkOutAt,  String? note,  List<String> photos,  DateTime? autoValidateAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Assignment() when $default != null:
return $default(_that.id,_that.missionId,_that.title,_that.status,_that.startAt,_that.durationMinutes,_that.payAmount,_that.city,_that.district,_that.address,_that.landmark,_that.latitude,_that.longitude,_that.briefing,_that.posterName,_that.payoutOperator,_that.distanceKm,_that.travelMinutes,_that.checkInAt,_that.checkInDistanceMeters,_that.checkOutAt,_that.note,_that.photos,_that.autoValidateAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String missionId,  String title,  AssignmentStatus status,  DateTime startAt,  int durationMinutes,  int payAmount,  String city,  String district,  String address,  String landmark,  double latitude,  double longitude,  String briefing,  String posterName,  String payoutOperator,  double distanceKm,  int travelMinutes,  DateTime? checkInAt,  int? checkInDistanceMeters,  DateTime? checkOutAt,  String? note,  List<String> photos,  DateTime? autoValidateAt)  $default,) {final _that = this;
switch (_that) {
case _Assignment():
return $default(_that.id,_that.missionId,_that.title,_that.status,_that.startAt,_that.durationMinutes,_that.payAmount,_that.city,_that.district,_that.address,_that.landmark,_that.latitude,_that.longitude,_that.briefing,_that.posterName,_that.payoutOperator,_that.distanceKm,_that.travelMinutes,_that.checkInAt,_that.checkInDistanceMeters,_that.checkOutAt,_that.note,_that.photos,_that.autoValidateAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String missionId,  String title,  AssignmentStatus status,  DateTime startAt,  int durationMinutes,  int payAmount,  String city,  String district,  String address,  String landmark,  double latitude,  double longitude,  String briefing,  String posterName,  String payoutOperator,  double distanceKm,  int travelMinutes,  DateTime? checkInAt,  int? checkInDistanceMeters,  DateTime? checkOutAt,  String? note,  List<String> photos,  DateTime? autoValidateAt)?  $default,) {final _that = this;
switch (_that) {
case _Assignment() when $default != null:
return $default(_that.id,_that.missionId,_that.title,_that.status,_that.startAt,_that.durationMinutes,_that.payAmount,_that.city,_that.district,_that.address,_that.landmark,_that.latitude,_that.longitude,_that.briefing,_that.posterName,_that.payoutOperator,_that.distanceKm,_that.travelMinutes,_that.checkInAt,_that.checkInDistanceMeters,_that.checkOutAt,_that.note,_that.photos,_that.autoValidateAt);case _:
  return null;

}
}

}

/// @nodoc


class _Assignment extends Assignment {
  const _Assignment({required this.id, required this.missionId, required this.title, required this.status, required this.startAt, required this.durationMinutes, required this.payAmount, required this.city, required this.district, required this.address, required this.landmark, required this.latitude, required this.longitude, required this.briefing, required this.posterName, required this.payoutOperator, required this.distanceKm, required this.travelMinutes, this.checkInAt, this.checkInDistanceMeters, this.checkOutAt, this.note, final  List<String> photos = const <String>[], this.autoValidateAt}): _photos = photos,super._();
  

@override final  String id;
@override final  String missionId;
@override final  String title;
@override final  AssignmentStatus status;
@override final  DateTime startAt;
@override final  int durationMinutes;
@override final  int payAmount;
@override final  String city;
@override final  String district;
@override final  String address;
@override final  String landmark;
@override final  double latitude;
@override final  double longitude;
@override final  String briefing;
@override final  String posterName;
@override final  String payoutOperator;
@override final  double distanceKm;
@override final  int travelMinutes;
@override final  DateTime? checkInAt;
@override final  int? checkInDistanceMeters;
@override final  DateTime? checkOutAt;
@override final  String? note;
 final  List<String> _photos;
@override@JsonKey() List<String> get photos {
  if (_photos is EqualUnmodifiableListView) return _photos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photos);
}

@override final  DateTime? autoValidateAt;

/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssignmentCopyWith<_Assignment> get copyWith => __$AssignmentCopyWithImpl<_Assignment>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Assignment&&(identical(other.id, id) || other.id == id)&&(identical(other.missionId, missionId) || other.missionId == missionId)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.city, city) || other.city == city)&&(identical(other.district, district) || other.district == district)&&(identical(other.address, address) || other.address == address)&&(identical(other.landmark, landmark) || other.landmark == landmark)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.briefing, briefing) || other.briefing == briefing)&&(identical(other.posterName, posterName) || other.posterName == posterName)&&(identical(other.payoutOperator, payoutOperator) || other.payoutOperator == payoutOperator)&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.travelMinutes, travelMinutes) || other.travelMinutes == travelMinutes)&&(identical(other.checkInAt, checkInAt) || other.checkInAt == checkInAt)&&(identical(other.checkInDistanceMeters, checkInDistanceMeters) || other.checkInDistanceMeters == checkInDistanceMeters)&&(identical(other.checkOutAt, checkOutAt) || other.checkOutAt == checkOutAt)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other._photos, _photos)&&(identical(other.autoValidateAt, autoValidateAt) || other.autoValidateAt == autoValidateAt));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,missionId,title,status,startAt,durationMinutes,payAmount,city,district,address,landmark,latitude,longitude,briefing,posterName,payoutOperator,distanceKm,travelMinutes,checkInAt,checkInDistanceMeters,checkOutAt,note,const DeepCollectionEquality().hash(_photos),autoValidateAt]);

@override
String toString() {
  return 'Assignment(id: $id, missionId: $missionId, title: $title, status: $status, startAt: $startAt, durationMinutes: $durationMinutes, payAmount: $payAmount, city: $city, district: $district, address: $address, landmark: $landmark, latitude: $latitude, longitude: $longitude, briefing: $briefing, posterName: $posterName, payoutOperator: $payoutOperator, distanceKm: $distanceKm, travelMinutes: $travelMinutes, checkInAt: $checkInAt, checkInDistanceMeters: $checkInDistanceMeters, checkOutAt: $checkOutAt, note: $note, photos: $photos, autoValidateAt: $autoValidateAt)';
}


}

/// @nodoc
abstract mixin class _$AssignmentCopyWith<$Res> implements $AssignmentCopyWith<$Res> {
  factory _$AssignmentCopyWith(_Assignment value, $Res Function(_Assignment) _then) = __$AssignmentCopyWithImpl;
@override @useResult
$Res call({
 String id, String missionId, String title, AssignmentStatus status, DateTime startAt, int durationMinutes, int payAmount, String city, String district, String address, String landmark, double latitude, double longitude, String briefing, String posterName, String payoutOperator, double distanceKm, int travelMinutes, DateTime? checkInAt, int? checkInDistanceMeters, DateTime? checkOutAt, String? note, List<String> photos, DateTime? autoValidateAt
});




}
/// @nodoc
class __$AssignmentCopyWithImpl<$Res>
    implements _$AssignmentCopyWith<$Res> {
  __$AssignmentCopyWithImpl(this._self, this._then);

  final _Assignment _self;
  final $Res Function(_Assignment) _then;

/// Create a copy of Assignment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? missionId = null,Object? title = null,Object? status = null,Object? startAt = null,Object? durationMinutes = null,Object? payAmount = null,Object? city = null,Object? district = null,Object? address = null,Object? landmark = null,Object? latitude = null,Object? longitude = null,Object? briefing = null,Object? posterName = null,Object? payoutOperator = null,Object? distanceKm = null,Object? travelMinutes = null,Object? checkInAt = freezed,Object? checkInDistanceMeters = freezed,Object? checkOutAt = freezed,Object? note = freezed,Object? photos = null,Object? autoValidateAt = freezed,}) {
  return _then(_Assignment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,missionId: null == missionId ? _self.missionId : missionId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AssignmentStatus,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,payAmount: null == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,district: null == district ? _self.district : district // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,landmark: null == landmark ? _self.landmark : landmark // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,briefing: null == briefing ? _self.briefing : briefing // ignore: cast_nullable_to_non_nullable
as String,posterName: null == posterName ? _self.posterName : posterName // ignore: cast_nullable_to_non_nullable
as String,payoutOperator: null == payoutOperator ? _self.payoutOperator : payoutOperator // ignore: cast_nullable_to_non_nullable
as String,distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,travelMinutes: null == travelMinutes ? _self.travelMinutes : travelMinutes // ignore: cast_nullable_to_non_nullable
as int,checkInAt: freezed == checkInAt ? _self.checkInAt : checkInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkInDistanceMeters: freezed == checkInDistanceMeters ? _self.checkInDistanceMeters : checkInDistanceMeters // ignore: cast_nullable_to_non_nullable
as int?,checkOutAt: freezed == checkOutAt ? _self.checkOutAt : checkOutAt // ignore: cast_nullable_to_non_nullable
as DateTime?,note: freezed == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String?,photos: null == photos ? _self._photos : photos // ignore: cast_nullable_to_non_nullable
as List<String>,autoValidateAt: freezed == autoValidateAt ? _self.autoValidateAt : autoValidateAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
