// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apply_target.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ApplyTarget {

 String get missionId; String get title; DateTime get startAt; int get payAmount; String get posterName;
/// Create a copy of ApplyTarget
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplyTargetCopyWith<ApplyTarget> get copyWith => _$ApplyTargetCopyWithImpl<ApplyTarget>(this as ApplyTarget, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplyTarget&&(identical(other.missionId, missionId) || other.missionId == missionId)&&(identical(other.title, title) || other.title == title)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.posterName, posterName) || other.posterName == posterName));
}


@override
int get hashCode => Object.hash(runtimeType,missionId,title,startAt,payAmount,posterName);

@override
String toString() {
  return 'ApplyTarget(missionId: $missionId, title: $title, startAt: $startAt, payAmount: $payAmount, posterName: $posterName)';
}


}

/// @nodoc
abstract mixin class $ApplyTargetCopyWith<$Res>  {
  factory $ApplyTargetCopyWith(ApplyTarget value, $Res Function(ApplyTarget) _then) = _$ApplyTargetCopyWithImpl;
@useResult
$Res call({
 String missionId, String title, DateTime startAt, int payAmount, String posterName
});




}
/// @nodoc
class _$ApplyTargetCopyWithImpl<$Res>
    implements $ApplyTargetCopyWith<$Res> {
  _$ApplyTargetCopyWithImpl(this._self, this._then);

  final ApplyTarget _self;
  final $Res Function(ApplyTarget) _then;

/// Create a copy of ApplyTarget
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? missionId = null,Object? title = null,Object? startAt = null,Object? payAmount = null,Object? posterName = null,}) {
  return _then(_self.copyWith(
missionId: null == missionId ? _self.missionId : missionId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,payAmount: null == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int,posterName: null == posterName ? _self.posterName : posterName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ApplyTarget].
extension ApplyTargetPatterns on ApplyTarget {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplyTarget value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplyTarget() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplyTarget value)  $default,){
final _that = this;
switch (_that) {
case _ApplyTarget():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplyTarget value)?  $default,){
final _that = this;
switch (_that) {
case _ApplyTarget() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String missionId,  String title,  DateTime startAt,  int payAmount,  String posterName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplyTarget() when $default != null:
return $default(_that.missionId,_that.title,_that.startAt,_that.payAmount,_that.posterName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String missionId,  String title,  DateTime startAt,  int payAmount,  String posterName)  $default,) {final _that = this;
switch (_that) {
case _ApplyTarget():
return $default(_that.missionId,_that.title,_that.startAt,_that.payAmount,_that.posterName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String missionId,  String title,  DateTime startAt,  int payAmount,  String posterName)?  $default,) {final _that = this;
switch (_that) {
case _ApplyTarget() when $default != null:
return $default(_that.missionId,_that.title,_that.startAt,_that.payAmount,_that.posterName);case _:
  return null;

}
}

}

/// @nodoc


class _ApplyTarget implements ApplyTarget {
  const _ApplyTarget({required this.missionId, required this.title, required this.startAt, required this.payAmount, required this.posterName});
  

@override final  String missionId;
@override final  String title;
@override final  DateTime startAt;
@override final  int payAmount;
@override final  String posterName;

/// Create a copy of ApplyTarget
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplyTargetCopyWith<_ApplyTarget> get copyWith => __$ApplyTargetCopyWithImpl<_ApplyTarget>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplyTarget&&(identical(other.missionId, missionId) || other.missionId == missionId)&&(identical(other.title, title) || other.title == title)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.posterName, posterName) || other.posterName == posterName));
}


@override
int get hashCode => Object.hash(runtimeType,missionId,title,startAt,payAmount,posterName);

@override
String toString() {
  return 'ApplyTarget(missionId: $missionId, title: $title, startAt: $startAt, payAmount: $payAmount, posterName: $posterName)';
}


}

/// @nodoc
abstract mixin class _$ApplyTargetCopyWith<$Res> implements $ApplyTargetCopyWith<$Res> {
  factory _$ApplyTargetCopyWith(_ApplyTarget value, $Res Function(_ApplyTarget) _then) = __$ApplyTargetCopyWithImpl;
@override @useResult
$Res call({
 String missionId, String title, DateTime startAt, int payAmount, String posterName
});




}
/// @nodoc
class __$ApplyTargetCopyWithImpl<$Res>
    implements _$ApplyTargetCopyWith<$Res> {
  __$ApplyTargetCopyWithImpl(this._self, this._then);

  final _ApplyTarget _self;
  final $Res Function(_ApplyTarget) _then;

/// Create a copy of ApplyTarget
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? missionId = null,Object? title = null,Object? startAt = null,Object? payAmount = null,Object? posterName = null,}) {
  return _then(_ApplyTarget(
missionId: null == missionId ? _self.missionId : missionId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,payAmount: null == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int,posterName: null == posterName ? _self.posterName : posterName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
