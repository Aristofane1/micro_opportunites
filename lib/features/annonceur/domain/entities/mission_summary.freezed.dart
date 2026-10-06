// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MissionSummary {

 String get id; String get title; MissionStatus get status; DateTime get startAt; String get city; int get payAmount; PayUnit get payUnit; int get slotsTotal; MissionCategory? get category; int get durationMinutes; int get slotsConfirmed; int get slotsOffered;// place proposée, pas encore acceptée
 int get applicantsCount; int get newApplicantsCount; int get blockedAmount;
/// Create a copy of MissionSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissionSummaryCopyWith<MissionSummary> get copyWith => _$MissionSummaryCopyWithImpl<MissionSummary>(this as MissionSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissionSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.city, city) || other.city == city)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.payUnit, payUnit) || other.payUnit == payUnit)&&(identical(other.slotsTotal, slotsTotal) || other.slotsTotal == slotsTotal)&&(identical(other.category, category) || other.category == category)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.slotsConfirmed, slotsConfirmed) || other.slotsConfirmed == slotsConfirmed)&&(identical(other.slotsOffered, slotsOffered) || other.slotsOffered == slotsOffered)&&(identical(other.applicantsCount, applicantsCount) || other.applicantsCount == applicantsCount)&&(identical(other.newApplicantsCount, newApplicantsCount) || other.newApplicantsCount == newApplicantsCount)&&(identical(other.blockedAmount, blockedAmount) || other.blockedAmount == blockedAmount));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,status,startAt,city,payAmount,payUnit,slotsTotal,category,durationMinutes,slotsConfirmed,slotsOffered,applicantsCount,newApplicantsCount,blockedAmount);

@override
String toString() {
  return 'MissionSummary(id: $id, title: $title, status: $status, startAt: $startAt, city: $city, payAmount: $payAmount, payUnit: $payUnit, slotsTotal: $slotsTotal, category: $category, durationMinutes: $durationMinutes, slotsConfirmed: $slotsConfirmed, slotsOffered: $slotsOffered, applicantsCount: $applicantsCount, newApplicantsCount: $newApplicantsCount, blockedAmount: $blockedAmount)';
}


}

/// @nodoc
abstract mixin class $MissionSummaryCopyWith<$Res>  {
  factory $MissionSummaryCopyWith(MissionSummary value, $Res Function(MissionSummary) _then) = _$MissionSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String title, MissionStatus status, DateTime startAt, String city, int payAmount, PayUnit payUnit, int slotsTotal, MissionCategory? category, int durationMinutes, int slotsConfirmed, int slotsOffered, int applicantsCount, int newApplicantsCount, int blockedAmount
});




}
/// @nodoc
class _$MissionSummaryCopyWithImpl<$Res>
    implements $MissionSummaryCopyWith<$Res> {
  _$MissionSummaryCopyWithImpl(this._self, this._then);

  final MissionSummary _self;
  final $Res Function(MissionSummary) _then;

/// Create a copy of MissionSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? status = null,Object? startAt = null,Object? city = null,Object? payAmount = null,Object? payUnit = null,Object? slotsTotal = null,Object? category = freezed,Object? durationMinutes = null,Object? slotsConfirmed = null,Object? slotsOffered = null,Object? applicantsCount = null,Object? newApplicantsCount = null,Object? blockedAmount = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MissionStatus,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,payAmount: null == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int,payUnit: null == payUnit ? _self.payUnit : payUnit // ignore: cast_nullable_to_non_nullable
as PayUnit,slotsTotal: null == slotsTotal ? _self.slotsTotal : slotsTotal // ignore: cast_nullable_to_non_nullable
as int,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as MissionCategory?,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,slotsConfirmed: null == slotsConfirmed ? _self.slotsConfirmed : slotsConfirmed // ignore: cast_nullable_to_non_nullable
as int,slotsOffered: null == slotsOffered ? _self.slotsOffered : slotsOffered // ignore: cast_nullable_to_non_nullable
as int,applicantsCount: null == applicantsCount ? _self.applicantsCount : applicantsCount // ignore: cast_nullable_to_non_nullable
as int,newApplicantsCount: null == newApplicantsCount ? _self.newApplicantsCount : newApplicantsCount // ignore: cast_nullable_to_non_nullable
as int,blockedAmount: null == blockedAmount ? _self.blockedAmount : blockedAmount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MissionSummary].
extension MissionSummaryPatterns on MissionSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MissionSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MissionSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MissionSummary value)  $default,){
final _that = this;
switch (_that) {
case _MissionSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MissionSummary value)?  $default,){
final _that = this;
switch (_that) {
case _MissionSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  MissionStatus status,  DateTime startAt,  String city,  int payAmount,  PayUnit payUnit,  int slotsTotal,  MissionCategory? category,  int durationMinutes,  int slotsConfirmed,  int slotsOffered,  int applicantsCount,  int newApplicantsCount,  int blockedAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MissionSummary() when $default != null:
return $default(_that.id,_that.title,_that.status,_that.startAt,_that.city,_that.payAmount,_that.payUnit,_that.slotsTotal,_that.category,_that.durationMinutes,_that.slotsConfirmed,_that.slotsOffered,_that.applicantsCount,_that.newApplicantsCount,_that.blockedAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  MissionStatus status,  DateTime startAt,  String city,  int payAmount,  PayUnit payUnit,  int slotsTotal,  MissionCategory? category,  int durationMinutes,  int slotsConfirmed,  int slotsOffered,  int applicantsCount,  int newApplicantsCount,  int blockedAmount)  $default,) {final _that = this;
switch (_that) {
case _MissionSummary():
return $default(_that.id,_that.title,_that.status,_that.startAt,_that.city,_that.payAmount,_that.payUnit,_that.slotsTotal,_that.category,_that.durationMinutes,_that.slotsConfirmed,_that.slotsOffered,_that.applicantsCount,_that.newApplicantsCount,_that.blockedAmount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  MissionStatus status,  DateTime startAt,  String city,  int payAmount,  PayUnit payUnit,  int slotsTotal,  MissionCategory? category,  int durationMinutes,  int slotsConfirmed,  int slotsOffered,  int applicantsCount,  int newApplicantsCount,  int blockedAmount)?  $default,) {final _that = this;
switch (_that) {
case _MissionSummary() when $default != null:
return $default(_that.id,_that.title,_that.status,_that.startAt,_that.city,_that.payAmount,_that.payUnit,_that.slotsTotal,_that.category,_that.durationMinutes,_that.slotsConfirmed,_that.slotsOffered,_that.applicantsCount,_that.newApplicantsCount,_that.blockedAmount);case _:
  return null;

}
}

}

/// @nodoc


class _MissionSummary extends MissionSummary {
  const _MissionSummary({required this.id, required this.title, required this.status, required this.startAt, required this.city, required this.payAmount, required this.payUnit, required this.slotsTotal, this.category, this.durationMinutes = 240, this.slotsConfirmed = 0, this.slotsOffered = 0, this.applicantsCount = 0, this.newApplicantsCount = 0, this.blockedAmount = 0}): super._();
  

@override final  String id;
@override final  String title;
@override final  MissionStatus status;
@override final  DateTime startAt;
@override final  String city;
@override final  int payAmount;
@override final  PayUnit payUnit;
@override final  int slotsTotal;
@override final  MissionCategory? category;
@override@JsonKey() final  int durationMinutes;
@override@JsonKey() final  int slotsConfirmed;
@override@JsonKey() final  int slotsOffered;
// place proposée, pas encore acceptée
@override@JsonKey() final  int applicantsCount;
@override@JsonKey() final  int newApplicantsCount;
@override@JsonKey() final  int blockedAmount;

/// Create a copy of MissionSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissionSummaryCopyWith<_MissionSummary> get copyWith => __$MissionSummaryCopyWithImpl<_MissionSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissionSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.city, city) || other.city == city)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.payUnit, payUnit) || other.payUnit == payUnit)&&(identical(other.slotsTotal, slotsTotal) || other.slotsTotal == slotsTotal)&&(identical(other.category, category) || other.category == category)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.slotsConfirmed, slotsConfirmed) || other.slotsConfirmed == slotsConfirmed)&&(identical(other.slotsOffered, slotsOffered) || other.slotsOffered == slotsOffered)&&(identical(other.applicantsCount, applicantsCount) || other.applicantsCount == applicantsCount)&&(identical(other.newApplicantsCount, newApplicantsCount) || other.newApplicantsCount == newApplicantsCount)&&(identical(other.blockedAmount, blockedAmount) || other.blockedAmount == blockedAmount));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,status,startAt,city,payAmount,payUnit,slotsTotal,category,durationMinutes,slotsConfirmed,slotsOffered,applicantsCount,newApplicantsCount,blockedAmount);

@override
String toString() {
  return 'MissionSummary(id: $id, title: $title, status: $status, startAt: $startAt, city: $city, payAmount: $payAmount, payUnit: $payUnit, slotsTotal: $slotsTotal, category: $category, durationMinutes: $durationMinutes, slotsConfirmed: $slotsConfirmed, slotsOffered: $slotsOffered, applicantsCount: $applicantsCount, newApplicantsCount: $newApplicantsCount, blockedAmount: $blockedAmount)';
}


}

/// @nodoc
abstract mixin class _$MissionSummaryCopyWith<$Res> implements $MissionSummaryCopyWith<$Res> {
  factory _$MissionSummaryCopyWith(_MissionSummary value, $Res Function(_MissionSummary) _then) = __$MissionSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, MissionStatus status, DateTime startAt, String city, int payAmount, PayUnit payUnit, int slotsTotal, MissionCategory? category, int durationMinutes, int slotsConfirmed, int slotsOffered, int applicantsCount, int newApplicantsCount, int blockedAmount
});




}
/// @nodoc
class __$MissionSummaryCopyWithImpl<$Res>
    implements _$MissionSummaryCopyWith<$Res> {
  __$MissionSummaryCopyWithImpl(this._self, this._then);

  final _MissionSummary _self;
  final $Res Function(_MissionSummary) _then;

/// Create a copy of MissionSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? status = null,Object? startAt = null,Object? city = null,Object? payAmount = null,Object? payUnit = null,Object? slotsTotal = null,Object? category = freezed,Object? durationMinutes = null,Object? slotsConfirmed = null,Object? slotsOffered = null,Object? applicantsCount = null,Object? newApplicantsCount = null,Object? blockedAmount = null,}) {
  return _then(_MissionSummary(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as MissionStatus,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,payAmount: null == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int,payUnit: null == payUnit ? _self.payUnit : payUnit // ignore: cast_nullable_to_non_nullable
as PayUnit,slotsTotal: null == slotsTotal ? _self.slotsTotal : slotsTotal // ignore: cast_nullable_to_non_nullable
as int,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as MissionCategory?,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,slotsConfirmed: null == slotsConfirmed ? _self.slotsConfirmed : slotsConfirmed // ignore: cast_nullable_to_non_nullable
as int,slotsOffered: null == slotsOffered ? _self.slotsOffered : slotsOffered // ignore: cast_nullable_to_non_nullable
as int,applicantsCount: null == applicantsCount ? _self.applicantsCount : applicantsCount // ignore: cast_nullable_to_non_nullable
as int,newApplicantsCount: null == newApplicantsCount ? _self.newApplicantsCount : newApplicantsCount // ignore: cast_nullable_to_non_nullable
as int,blockedAmount: null == blockedAmount ? _self.blockedAmount : blockedAmount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
