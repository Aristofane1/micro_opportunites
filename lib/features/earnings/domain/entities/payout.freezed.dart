// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payout.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Payout {

 String get id; int get amount; int get grossAmount; String get missionTitle; String get posterName; DateTime get validatedAt; String get commissionLabel; String get accountLabel; String get reference;
/// Create a copy of Payout
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayoutCopyWith<Payout> get copyWith => _$PayoutCopyWithImpl<Payout>(this as Payout, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payout&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.grossAmount, grossAmount) || other.grossAmount == grossAmount)&&(identical(other.missionTitle, missionTitle) || other.missionTitle == missionTitle)&&(identical(other.posterName, posterName) || other.posterName == posterName)&&(identical(other.validatedAt, validatedAt) || other.validatedAt == validatedAt)&&(identical(other.commissionLabel, commissionLabel) || other.commissionLabel == commissionLabel)&&(identical(other.accountLabel, accountLabel) || other.accountLabel == accountLabel)&&(identical(other.reference, reference) || other.reference == reference));
}


@override
int get hashCode => Object.hash(runtimeType,id,amount,grossAmount,missionTitle,posterName,validatedAt,commissionLabel,accountLabel,reference);

@override
String toString() {
  return 'Payout(id: $id, amount: $amount, grossAmount: $grossAmount, missionTitle: $missionTitle, posterName: $posterName, validatedAt: $validatedAt, commissionLabel: $commissionLabel, accountLabel: $accountLabel, reference: $reference)';
}


}

/// @nodoc
abstract mixin class $PayoutCopyWith<$Res>  {
  factory $PayoutCopyWith(Payout value, $Res Function(Payout) _then) = _$PayoutCopyWithImpl;
@useResult
$Res call({
 String id, int amount, int grossAmount, String missionTitle, String posterName, DateTime validatedAt, String commissionLabel, String accountLabel, String reference
});




}
/// @nodoc
class _$PayoutCopyWithImpl<$Res>
    implements $PayoutCopyWith<$Res> {
  _$PayoutCopyWithImpl(this._self, this._then);

  final Payout _self;
  final $Res Function(Payout) _then;

/// Create a copy of Payout
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = null,Object? grossAmount = null,Object? missionTitle = null,Object? posterName = null,Object? validatedAt = null,Object? commissionLabel = null,Object? accountLabel = null,Object? reference = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,grossAmount: null == grossAmount ? _self.grossAmount : grossAmount // ignore: cast_nullable_to_non_nullable
as int,missionTitle: null == missionTitle ? _self.missionTitle : missionTitle // ignore: cast_nullable_to_non_nullable
as String,posterName: null == posterName ? _self.posterName : posterName // ignore: cast_nullable_to_non_nullable
as String,validatedAt: null == validatedAt ? _self.validatedAt : validatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,commissionLabel: null == commissionLabel ? _self.commissionLabel : commissionLabel // ignore: cast_nullable_to_non_nullable
as String,accountLabel: null == accountLabel ? _self.accountLabel : accountLabel // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Payout].
extension PayoutPatterns on Payout {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payout value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payout() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payout value)  $default,){
final _that = this;
switch (_that) {
case _Payout():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payout value)?  $default,){
final _that = this;
switch (_that) {
case _Payout() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int amount,  int grossAmount,  String missionTitle,  String posterName,  DateTime validatedAt,  String commissionLabel,  String accountLabel,  String reference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payout() when $default != null:
return $default(_that.id,_that.amount,_that.grossAmount,_that.missionTitle,_that.posterName,_that.validatedAt,_that.commissionLabel,_that.accountLabel,_that.reference);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int amount,  int grossAmount,  String missionTitle,  String posterName,  DateTime validatedAt,  String commissionLabel,  String accountLabel,  String reference)  $default,) {final _that = this;
switch (_that) {
case _Payout():
return $default(_that.id,_that.amount,_that.grossAmount,_that.missionTitle,_that.posterName,_that.validatedAt,_that.commissionLabel,_that.accountLabel,_that.reference);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int amount,  int grossAmount,  String missionTitle,  String posterName,  DateTime validatedAt,  String commissionLabel,  String accountLabel,  String reference)?  $default,) {final _that = this;
switch (_that) {
case _Payout() when $default != null:
return $default(_that.id,_that.amount,_that.grossAmount,_that.missionTitle,_that.posterName,_that.validatedAt,_that.commissionLabel,_that.accountLabel,_that.reference);case _:
  return null;

}
}

}

/// @nodoc


class _Payout implements Payout {
  const _Payout({required this.id, required this.amount, required this.grossAmount, required this.missionTitle, required this.posterName, required this.validatedAt, required this.commissionLabel, required this.accountLabel, required this.reference});
  

@override final  String id;
@override final  int amount;
@override final  int grossAmount;
@override final  String missionTitle;
@override final  String posterName;
@override final  DateTime validatedAt;
@override final  String commissionLabel;
@override final  String accountLabel;
@override final  String reference;

/// Create a copy of Payout
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayoutCopyWith<_Payout> get copyWith => __$PayoutCopyWithImpl<_Payout>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payout&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.grossAmount, grossAmount) || other.grossAmount == grossAmount)&&(identical(other.missionTitle, missionTitle) || other.missionTitle == missionTitle)&&(identical(other.posterName, posterName) || other.posterName == posterName)&&(identical(other.validatedAt, validatedAt) || other.validatedAt == validatedAt)&&(identical(other.commissionLabel, commissionLabel) || other.commissionLabel == commissionLabel)&&(identical(other.accountLabel, accountLabel) || other.accountLabel == accountLabel)&&(identical(other.reference, reference) || other.reference == reference));
}


@override
int get hashCode => Object.hash(runtimeType,id,amount,grossAmount,missionTitle,posterName,validatedAt,commissionLabel,accountLabel,reference);

@override
String toString() {
  return 'Payout(id: $id, amount: $amount, grossAmount: $grossAmount, missionTitle: $missionTitle, posterName: $posterName, validatedAt: $validatedAt, commissionLabel: $commissionLabel, accountLabel: $accountLabel, reference: $reference)';
}


}

/// @nodoc
abstract mixin class _$PayoutCopyWith<$Res> implements $PayoutCopyWith<$Res> {
  factory _$PayoutCopyWith(_Payout value, $Res Function(_Payout) _then) = __$PayoutCopyWithImpl;
@override @useResult
$Res call({
 String id, int amount, int grossAmount, String missionTitle, String posterName, DateTime validatedAt, String commissionLabel, String accountLabel, String reference
});




}
/// @nodoc
class __$PayoutCopyWithImpl<$Res>
    implements _$PayoutCopyWith<$Res> {
  __$PayoutCopyWithImpl(this._self, this._then);

  final _Payout _self;
  final $Res Function(_Payout) _then;

/// Create a copy of Payout
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? grossAmount = null,Object? missionTitle = null,Object? posterName = null,Object? validatedAt = null,Object? commissionLabel = null,Object? accountLabel = null,Object? reference = null,}) {
  return _then(_Payout(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,grossAmount: null == grossAmount ? _self.grossAmount : grossAmount // ignore: cast_nullable_to_non_nullable
as int,missionTitle: null == missionTitle ? _self.missionTitle : missionTitle // ignore: cast_nullable_to_non_nullable
as String,posterName: null == posterName ? _self.posterName : posterName // ignore: cast_nullable_to_non_nullable
as String,validatedAt: null == validatedAt ? _self.validatedAt : validatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,commissionLabel: null == commissionLabel ? _self.commissionLabel : commissionLabel // ignore: cast_nullable_to_non_nullable
as String,accountLabel: null == accountLabel ? _self.accountLabel : accountLabel // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
