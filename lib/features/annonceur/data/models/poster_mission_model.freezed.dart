// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poster_mission_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PosterMissionModel {

 String get id; String get title; String get category; String get city; String get startAt; int get durationMin; int get payAmount; String get payUnit; int get slotsTotal; int get slotsConfirmed; int get slotsOffered; int get applicantsCount; int get newApplicantsCount; int get blockedAmount; String get status;
/// Create a copy of PosterMissionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PosterMissionModelCopyWith<PosterMissionModel> get copyWith => _$PosterMissionModelCopyWithImpl<PosterMissionModel>(this as PosterMissionModel, _$identity);

  /// Serializes this PosterMissionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PosterMissionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.city, city) || other.city == city)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMin, durationMin) || other.durationMin == durationMin)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.payUnit, payUnit) || other.payUnit == payUnit)&&(identical(other.slotsTotal, slotsTotal) || other.slotsTotal == slotsTotal)&&(identical(other.slotsConfirmed, slotsConfirmed) || other.slotsConfirmed == slotsConfirmed)&&(identical(other.slotsOffered, slotsOffered) || other.slotsOffered == slotsOffered)&&(identical(other.applicantsCount, applicantsCount) || other.applicantsCount == applicantsCount)&&(identical(other.newApplicantsCount, newApplicantsCount) || other.newApplicantsCount == newApplicantsCount)&&(identical(other.blockedAmount, blockedAmount) || other.blockedAmount == blockedAmount)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,category,city,startAt,durationMin,payAmount,payUnit,slotsTotal,slotsConfirmed,slotsOffered,applicantsCount,newApplicantsCount,blockedAmount,status);

@override
String toString() {
  return 'PosterMissionModel(id: $id, title: $title, category: $category, city: $city, startAt: $startAt, durationMin: $durationMin, payAmount: $payAmount, payUnit: $payUnit, slotsTotal: $slotsTotal, slotsConfirmed: $slotsConfirmed, slotsOffered: $slotsOffered, applicantsCount: $applicantsCount, newApplicantsCount: $newApplicantsCount, blockedAmount: $blockedAmount, status: $status)';
}


}

/// @nodoc
abstract mixin class $PosterMissionModelCopyWith<$Res>  {
  factory $PosterMissionModelCopyWith(PosterMissionModel value, $Res Function(PosterMissionModel) _then) = _$PosterMissionModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String category, String city, String startAt, int durationMin, int payAmount, String payUnit, int slotsTotal, int slotsConfirmed, int slotsOffered, int applicantsCount, int newApplicantsCount, int blockedAmount, String status
});




}
/// @nodoc
class _$PosterMissionModelCopyWithImpl<$Res>
    implements $PosterMissionModelCopyWith<$Res> {
  _$PosterMissionModelCopyWithImpl(this._self, this._then);

  final PosterMissionModel _self;
  final $Res Function(PosterMissionModel) _then;

/// Create a copy of PosterMissionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? category = null,Object? city = null,Object? startAt = null,Object? durationMin = null,Object? payAmount = null,Object? payUnit = null,Object? slotsTotal = null,Object? slotsConfirmed = null,Object? slotsOffered = null,Object? applicantsCount = null,Object? newApplicantsCount = null,Object? blockedAmount = null,Object? status = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String,durationMin: null == durationMin ? _self.durationMin : durationMin // ignore: cast_nullable_to_non_nullable
as int,payAmount: null == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int,payUnit: null == payUnit ? _self.payUnit : payUnit // ignore: cast_nullable_to_non_nullable
as String,slotsTotal: null == slotsTotal ? _self.slotsTotal : slotsTotal // ignore: cast_nullable_to_non_nullable
as int,slotsConfirmed: null == slotsConfirmed ? _self.slotsConfirmed : slotsConfirmed // ignore: cast_nullable_to_non_nullable
as int,slotsOffered: null == slotsOffered ? _self.slotsOffered : slotsOffered // ignore: cast_nullable_to_non_nullable
as int,applicantsCount: null == applicantsCount ? _self.applicantsCount : applicantsCount // ignore: cast_nullable_to_non_nullable
as int,newApplicantsCount: null == newApplicantsCount ? _self.newApplicantsCount : newApplicantsCount // ignore: cast_nullable_to_non_nullable
as int,blockedAmount: null == blockedAmount ? _self.blockedAmount : blockedAmount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PosterMissionModel].
extension PosterMissionModelPatterns on PosterMissionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PosterMissionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PosterMissionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PosterMissionModel value)  $default,){
final _that = this;
switch (_that) {
case _PosterMissionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PosterMissionModel value)?  $default,){
final _that = this;
switch (_that) {
case _PosterMissionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String category,  String city,  String startAt,  int durationMin,  int payAmount,  String payUnit,  int slotsTotal,  int slotsConfirmed,  int slotsOffered,  int applicantsCount,  int newApplicantsCount,  int blockedAmount,  String status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PosterMissionModel() when $default != null:
return $default(_that.id,_that.title,_that.category,_that.city,_that.startAt,_that.durationMin,_that.payAmount,_that.payUnit,_that.slotsTotal,_that.slotsConfirmed,_that.slotsOffered,_that.applicantsCount,_that.newApplicantsCount,_that.blockedAmount,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String category,  String city,  String startAt,  int durationMin,  int payAmount,  String payUnit,  int slotsTotal,  int slotsConfirmed,  int slotsOffered,  int applicantsCount,  int newApplicantsCount,  int blockedAmount,  String status)  $default,) {final _that = this;
switch (_that) {
case _PosterMissionModel():
return $default(_that.id,_that.title,_that.category,_that.city,_that.startAt,_that.durationMin,_that.payAmount,_that.payUnit,_that.slotsTotal,_that.slotsConfirmed,_that.slotsOffered,_that.applicantsCount,_that.newApplicantsCount,_that.blockedAmount,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String category,  String city,  String startAt,  int durationMin,  int payAmount,  String payUnit,  int slotsTotal,  int slotsConfirmed,  int slotsOffered,  int applicantsCount,  int newApplicantsCount,  int blockedAmount,  String status)?  $default,) {final _that = this;
switch (_that) {
case _PosterMissionModel() when $default != null:
return $default(_that.id,_that.title,_that.category,_that.city,_that.startAt,_that.durationMin,_that.payAmount,_that.payUnit,_that.slotsTotal,_that.slotsConfirmed,_that.slotsOffered,_that.applicantsCount,_that.newApplicantsCount,_that.blockedAmount,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PosterMissionModel extends PosterMissionModel {
  const _PosterMissionModel({required this.id, required this.title, required this.category, required this.city, required this.startAt, required this.durationMin, required this.payAmount, required this.payUnit, required this.slotsTotal, required this.slotsConfirmed, required this.slotsOffered, required this.applicantsCount, required this.newApplicantsCount, required this.blockedAmount, required this.status}): super._();
  factory _PosterMissionModel.fromJson(Map<String, dynamic> json) => _$PosterMissionModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String category;
@override final  String city;
@override final  String startAt;
@override final  int durationMin;
@override final  int payAmount;
@override final  String payUnit;
@override final  int slotsTotal;
@override final  int slotsConfirmed;
@override final  int slotsOffered;
@override final  int applicantsCount;
@override final  int newApplicantsCount;
@override final  int blockedAmount;
@override final  String status;

/// Create a copy of PosterMissionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PosterMissionModelCopyWith<_PosterMissionModel> get copyWith => __$PosterMissionModelCopyWithImpl<_PosterMissionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PosterMissionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PosterMissionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.city, city) || other.city == city)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMin, durationMin) || other.durationMin == durationMin)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.payUnit, payUnit) || other.payUnit == payUnit)&&(identical(other.slotsTotal, slotsTotal) || other.slotsTotal == slotsTotal)&&(identical(other.slotsConfirmed, slotsConfirmed) || other.slotsConfirmed == slotsConfirmed)&&(identical(other.slotsOffered, slotsOffered) || other.slotsOffered == slotsOffered)&&(identical(other.applicantsCount, applicantsCount) || other.applicantsCount == applicantsCount)&&(identical(other.newApplicantsCount, newApplicantsCount) || other.newApplicantsCount == newApplicantsCount)&&(identical(other.blockedAmount, blockedAmount) || other.blockedAmount == blockedAmount)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,category,city,startAt,durationMin,payAmount,payUnit,slotsTotal,slotsConfirmed,slotsOffered,applicantsCount,newApplicantsCount,blockedAmount,status);

@override
String toString() {
  return 'PosterMissionModel(id: $id, title: $title, category: $category, city: $city, startAt: $startAt, durationMin: $durationMin, payAmount: $payAmount, payUnit: $payUnit, slotsTotal: $slotsTotal, slotsConfirmed: $slotsConfirmed, slotsOffered: $slotsOffered, applicantsCount: $applicantsCount, newApplicantsCount: $newApplicantsCount, blockedAmount: $blockedAmount, status: $status)';
}


}

/// @nodoc
abstract mixin class _$PosterMissionModelCopyWith<$Res> implements $PosterMissionModelCopyWith<$Res> {
  factory _$PosterMissionModelCopyWith(_PosterMissionModel value, $Res Function(_PosterMissionModel) _then) = __$PosterMissionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String category, String city, String startAt, int durationMin, int payAmount, String payUnit, int slotsTotal, int slotsConfirmed, int slotsOffered, int applicantsCount, int newApplicantsCount, int blockedAmount, String status
});




}
/// @nodoc
class __$PosterMissionModelCopyWithImpl<$Res>
    implements _$PosterMissionModelCopyWith<$Res> {
  __$PosterMissionModelCopyWithImpl(this._self, this._then);

  final _PosterMissionModel _self;
  final $Res Function(_PosterMissionModel) _then;

/// Create a copy of PosterMissionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? category = null,Object? city = null,Object? startAt = null,Object? durationMin = null,Object? payAmount = null,Object? payUnit = null,Object? slotsTotal = null,Object? slotsConfirmed = null,Object? slotsOffered = null,Object? applicantsCount = null,Object? newApplicantsCount = null,Object? blockedAmount = null,Object? status = null,}) {
  return _then(_PosterMissionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String,durationMin: null == durationMin ? _self.durationMin : durationMin // ignore: cast_nullable_to_non_nullable
as int,payAmount: null == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int,payUnit: null == payUnit ? _self.payUnit : payUnit // ignore: cast_nullable_to_non_nullable
as String,slotsTotal: null == slotsTotal ? _self.slotsTotal : slotsTotal // ignore: cast_nullable_to_non_nullable
as int,slotsConfirmed: null == slotsConfirmed ? _self.slotsConfirmed : slotsConfirmed // ignore: cast_nullable_to_non_nullable
as int,slotsOffered: null == slotsOffered ? _self.slotsOffered : slotsOffered // ignore: cast_nullable_to_non_nullable
as int,applicantsCount: null == applicantsCount ? _self.applicantsCount : applicantsCount // ignore: cast_nullable_to_non_nullable
as int,newApplicantsCount: null == newApplicantsCount ? _self.newApplicantsCount : newApplicantsCount // ignore: cast_nullable_to_non_nullable
as int,blockedAmount: null == blockedAmount ? _self.blockedAmount : blockedAmount // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
