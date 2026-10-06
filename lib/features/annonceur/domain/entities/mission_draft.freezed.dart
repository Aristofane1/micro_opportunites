// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MissionDraft {

// Étape 1 : Quoi ??
 String? get title; MissionCategory? get category; String? get description; List<String> get photoPaths;// Étape 2 : Où ??
 String? get city; String? get address; String? get landmark; String? get entrancePhotoPath; double? get latitude; double? get longitude;// Étape 3 : Quand et combien ??
 DateTime? get startAt; int get durationMinutes; int? get payAmount; PayUnit get payUnit; int get slotsTotal; DateTime? get applyDeadline;// Étape 4 : Payer
 PaymentMethod get paymentMethod;
/// Create a copy of MissionDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissionDraftCopyWith<MissionDraft> get copyWith => _$MissionDraftCopyWithImpl<MissionDraft>(this as MissionDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissionDraft&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.photoPaths, photoPaths)&&(identical(other.city, city) || other.city == city)&&(identical(other.address, address) || other.address == address)&&(identical(other.landmark, landmark) || other.landmark == landmark)&&(identical(other.entrancePhotoPath, entrancePhotoPath) || other.entrancePhotoPath == entrancePhotoPath)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.payUnit, payUnit) || other.payUnit == payUnit)&&(identical(other.slotsTotal, slotsTotal) || other.slotsTotal == slotsTotal)&&(identical(other.applyDeadline, applyDeadline) || other.applyDeadline == applyDeadline)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod));
}


@override
int get hashCode => Object.hash(runtimeType,title,category,description,const DeepCollectionEquality().hash(photoPaths),city,address,landmark,entrancePhotoPath,latitude,longitude,startAt,durationMinutes,payAmount,payUnit,slotsTotal,applyDeadline,paymentMethod);

@override
String toString() {
  return 'MissionDraft(title: $title, category: $category, description: $description, photoPaths: $photoPaths, city: $city, address: $address, landmark: $landmark, entrancePhotoPath: $entrancePhotoPath, latitude: $latitude, longitude: $longitude, startAt: $startAt, durationMinutes: $durationMinutes, payAmount: $payAmount, payUnit: $payUnit, slotsTotal: $slotsTotal, applyDeadline: $applyDeadline, paymentMethod: $paymentMethod)';
}


}

/// @nodoc
abstract mixin class $MissionDraftCopyWith<$Res>  {
  factory $MissionDraftCopyWith(MissionDraft value, $Res Function(MissionDraft) _then) = _$MissionDraftCopyWithImpl;
@useResult
$Res call({
 String? title, MissionCategory? category, String? description, List<String> photoPaths, String? city, String? address, String? landmark, String? entrancePhotoPath, double? latitude, double? longitude, DateTime? startAt, int durationMinutes, int? payAmount, PayUnit payUnit, int slotsTotal, DateTime? applyDeadline, PaymentMethod paymentMethod
});




}
/// @nodoc
class _$MissionDraftCopyWithImpl<$Res>
    implements $MissionDraftCopyWith<$Res> {
  _$MissionDraftCopyWithImpl(this._self, this._then);

  final MissionDraft _self;
  final $Res Function(MissionDraft) _then;

/// Create a copy of MissionDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = freezed,Object? category = freezed,Object? description = freezed,Object? photoPaths = null,Object? city = freezed,Object? address = freezed,Object? landmark = freezed,Object? entrancePhotoPath = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? startAt = freezed,Object? durationMinutes = null,Object? payAmount = freezed,Object? payUnit = null,Object? slotsTotal = null,Object? applyDeadline = freezed,Object? paymentMethod = null,}) {
  return _then(_self.copyWith(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as MissionCategory?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photoPaths: null == photoPaths ? _self.photoPaths : photoPaths // ignore: cast_nullable_to_non_nullable
as List<String>,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,landmark: freezed == landmark ? _self.landmark : landmark // ignore: cast_nullable_to_non_nullable
as String?,entrancePhotoPath: freezed == entrancePhotoPath ? _self.entrancePhotoPath : entrancePhotoPath // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,startAt: freezed == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime?,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,payAmount: freezed == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int?,payUnit: null == payUnit ? _self.payUnit : payUnit // ignore: cast_nullable_to_non_nullable
as PayUnit,slotsTotal: null == slotsTotal ? _self.slotsTotal : slotsTotal // ignore: cast_nullable_to_non_nullable
as int,applyDeadline: freezed == applyDeadline ? _self.applyDeadline : applyDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,
  ));
}

}


/// Adds pattern-matching-related methods to [MissionDraft].
extension MissionDraftPatterns on MissionDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MissionDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MissionDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MissionDraft value)  $default,){
final _that = this;
switch (_that) {
case _MissionDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MissionDraft value)?  $default,){
final _that = this;
switch (_that) {
case _MissionDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? title,  MissionCategory? category,  String? description,  List<String> photoPaths,  String? city,  String? address,  String? landmark,  String? entrancePhotoPath,  double? latitude,  double? longitude,  DateTime? startAt,  int durationMinutes,  int? payAmount,  PayUnit payUnit,  int slotsTotal,  DateTime? applyDeadline,  PaymentMethod paymentMethod)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MissionDraft() when $default != null:
return $default(_that.title,_that.category,_that.description,_that.photoPaths,_that.city,_that.address,_that.landmark,_that.entrancePhotoPath,_that.latitude,_that.longitude,_that.startAt,_that.durationMinutes,_that.payAmount,_that.payUnit,_that.slotsTotal,_that.applyDeadline,_that.paymentMethod);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? title,  MissionCategory? category,  String? description,  List<String> photoPaths,  String? city,  String? address,  String? landmark,  String? entrancePhotoPath,  double? latitude,  double? longitude,  DateTime? startAt,  int durationMinutes,  int? payAmount,  PayUnit payUnit,  int slotsTotal,  DateTime? applyDeadline,  PaymentMethod paymentMethod)  $default,) {final _that = this;
switch (_that) {
case _MissionDraft():
return $default(_that.title,_that.category,_that.description,_that.photoPaths,_that.city,_that.address,_that.landmark,_that.entrancePhotoPath,_that.latitude,_that.longitude,_that.startAt,_that.durationMinutes,_that.payAmount,_that.payUnit,_that.slotsTotal,_that.applyDeadline,_that.paymentMethod);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? title,  MissionCategory? category,  String? description,  List<String> photoPaths,  String? city,  String? address,  String? landmark,  String? entrancePhotoPath,  double? latitude,  double? longitude,  DateTime? startAt,  int durationMinutes,  int? payAmount,  PayUnit payUnit,  int slotsTotal,  DateTime? applyDeadline,  PaymentMethod paymentMethod)?  $default,) {final _that = this;
switch (_that) {
case _MissionDraft() when $default != null:
return $default(_that.title,_that.category,_that.description,_that.photoPaths,_that.city,_that.address,_that.landmark,_that.entrancePhotoPath,_that.latitude,_that.longitude,_that.startAt,_that.durationMinutes,_that.payAmount,_that.payUnit,_that.slotsTotal,_that.applyDeadline,_that.paymentMethod);case _:
  return null;

}
}

}

/// @nodoc


class _MissionDraft extends MissionDraft {
  const _MissionDraft({this.title, this.category, this.description, final  List<String> photoPaths = const [], this.city, this.address, this.landmark, this.entrancePhotoPath, this.latitude, this.longitude, this.startAt, this.durationMinutes = 240, this.payAmount, this.payUnit = PayUnit.flat, this.slotsTotal = 1, this.applyDeadline, this.paymentMethod = PaymentMethod.mtnMomo}): _photoPaths = photoPaths,super._();
  

// Étape 1 : Quoi ??
@override final  String? title;
@override final  MissionCategory? category;
@override final  String? description;
 final  List<String> _photoPaths;
@override@JsonKey() List<String> get photoPaths {
  if (_photoPaths is EqualUnmodifiableListView) return _photoPaths;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photoPaths);
}

// Étape 2 : Où ??
@override final  String? city;
@override final  String? address;
@override final  String? landmark;
@override final  String? entrancePhotoPath;
@override final  double? latitude;
@override final  double? longitude;
// Étape 3 : Quand et combien ??
@override final  DateTime? startAt;
@override@JsonKey() final  int durationMinutes;
@override final  int? payAmount;
@override@JsonKey() final  PayUnit payUnit;
@override@JsonKey() final  int slotsTotal;
@override final  DateTime? applyDeadline;
// Étape 4 : Payer
@override@JsonKey() final  PaymentMethod paymentMethod;

/// Create a copy of MissionDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissionDraftCopyWith<_MissionDraft> get copyWith => __$MissionDraftCopyWithImpl<_MissionDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissionDraft&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._photoPaths, _photoPaths)&&(identical(other.city, city) || other.city == city)&&(identical(other.address, address) || other.address == address)&&(identical(other.landmark, landmark) || other.landmark == landmark)&&(identical(other.entrancePhotoPath, entrancePhotoPath) || other.entrancePhotoPath == entrancePhotoPath)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.payUnit, payUnit) || other.payUnit == payUnit)&&(identical(other.slotsTotal, slotsTotal) || other.slotsTotal == slotsTotal)&&(identical(other.applyDeadline, applyDeadline) || other.applyDeadline == applyDeadline)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod));
}


@override
int get hashCode => Object.hash(runtimeType,title,category,description,const DeepCollectionEquality().hash(_photoPaths),city,address,landmark,entrancePhotoPath,latitude,longitude,startAt,durationMinutes,payAmount,payUnit,slotsTotal,applyDeadline,paymentMethod);

@override
String toString() {
  return 'MissionDraft(title: $title, category: $category, description: $description, photoPaths: $photoPaths, city: $city, address: $address, landmark: $landmark, entrancePhotoPath: $entrancePhotoPath, latitude: $latitude, longitude: $longitude, startAt: $startAt, durationMinutes: $durationMinutes, payAmount: $payAmount, payUnit: $payUnit, slotsTotal: $slotsTotal, applyDeadline: $applyDeadline, paymentMethod: $paymentMethod)';
}


}

/// @nodoc
abstract mixin class _$MissionDraftCopyWith<$Res> implements $MissionDraftCopyWith<$Res> {
  factory _$MissionDraftCopyWith(_MissionDraft value, $Res Function(_MissionDraft) _then) = __$MissionDraftCopyWithImpl;
@override @useResult
$Res call({
 String? title, MissionCategory? category, String? description, List<String> photoPaths, String? city, String? address, String? landmark, String? entrancePhotoPath, double? latitude, double? longitude, DateTime? startAt, int durationMinutes, int? payAmount, PayUnit payUnit, int slotsTotal, DateTime? applyDeadline, PaymentMethod paymentMethod
});




}
/// @nodoc
class __$MissionDraftCopyWithImpl<$Res>
    implements _$MissionDraftCopyWith<$Res> {
  __$MissionDraftCopyWithImpl(this._self, this._then);

  final _MissionDraft _self;
  final $Res Function(_MissionDraft) _then;

/// Create a copy of MissionDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = freezed,Object? category = freezed,Object? description = freezed,Object? photoPaths = null,Object? city = freezed,Object? address = freezed,Object? landmark = freezed,Object? entrancePhotoPath = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? startAt = freezed,Object? durationMinutes = null,Object? payAmount = freezed,Object? payUnit = null,Object? slotsTotal = null,Object? applyDeadline = freezed,Object? paymentMethod = null,}) {
  return _then(_MissionDraft(
title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as MissionCategory?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photoPaths: null == photoPaths ? _self._photoPaths : photoPaths // ignore: cast_nullable_to_non_nullable
as List<String>,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,landmark: freezed == landmark ? _self.landmark : landmark // ignore: cast_nullable_to_non_nullable
as String?,entrancePhotoPath: freezed == entrancePhotoPath ? _self.entrancePhotoPath : entrancePhotoPath // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,startAt: freezed == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime?,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,payAmount: freezed == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int?,payUnit: null == payUnit ? _self.payUnit : payUnit // ignore: cast_nullable_to_non_nullable
as PayUnit,slotsTotal: null == slotsTotal ? _self.slotsTotal : slotsTotal // ignore: cast_nullable_to_non_nullable
as int,applyDeadline: freezed == applyDeadline ? _self.applyDeadline : applyDeadline // ignore: cast_nullable_to_non_nullable
as DateTime?,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,
  ));
}


}

// dart format on
