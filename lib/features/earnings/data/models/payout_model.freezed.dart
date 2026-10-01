// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payout_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PayoutModel {

 String get id; int get amount; int get grossAmount; String get missionTitle; String get posterName; String get validatedAt; String get commissionLabel; String get accountLabel; String get reference;
/// Create a copy of PayoutModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayoutModelCopyWith<PayoutModel> get copyWith => _$PayoutModelCopyWithImpl<PayoutModel>(this as PayoutModel, _$identity);

  /// Serializes this PayoutModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayoutModel&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.grossAmount, grossAmount) || other.grossAmount == grossAmount)&&(identical(other.missionTitle, missionTitle) || other.missionTitle == missionTitle)&&(identical(other.posterName, posterName) || other.posterName == posterName)&&(identical(other.validatedAt, validatedAt) || other.validatedAt == validatedAt)&&(identical(other.commissionLabel, commissionLabel) || other.commissionLabel == commissionLabel)&&(identical(other.accountLabel, accountLabel) || other.accountLabel == accountLabel)&&(identical(other.reference, reference) || other.reference == reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,grossAmount,missionTitle,posterName,validatedAt,commissionLabel,accountLabel,reference);

@override
String toString() {
  return 'PayoutModel(id: $id, amount: $amount, grossAmount: $grossAmount, missionTitle: $missionTitle, posterName: $posterName, validatedAt: $validatedAt, commissionLabel: $commissionLabel, accountLabel: $accountLabel, reference: $reference)';
}


}

/// @nodoc
abstract mixin class $PayoutModelCopyWith<$Res>  {
  factory $PayoutModelCopyWith(PayoutModel value, $Res Function(PayoutModel) _then) = _$PayoutModelCopyWithImpl;
@useResult
$Res call({
 String id, int amount, int grossAmount, String missionTitle, String posterName, String validatedAt, String commissionLabel, String accountLabel, String reference
});




}
/// @nodoc
class _$PayoutModelCopyWithImpl<$Res>
    implements $PayoutModelCopyWith<$Res> {
  _$PayoutModelCopyWithImpl(this._self, this._then);

  final PayoutModel _self;
  final $Res Function(PayoutModel) _then;

/// Create a copy of PayoutModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? amount = null,Object? grossAmount = null,Object? missionTitle = null,Object? posterName = null,Object? validatedAt = null,Object? commissionLabel = null,Object? accountLabel = null,Object? reference = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,grossAmount: null == grossAmount ? _self.grossAmount : grossAmount // ignore: cast_nullable_to_non_nullable
as int,missionTitle: null == missionTitle ? _self.missionTitle : missionTitle // ignore: cast_nullable_to_non_nullable
as String,posterName: null == posterName ? _self.posterName : posterName // ignore: cast_nullable_to_non_nullable
as String,validatedAt: null == validatedAt ? _self.validatedAt : validatedAt // ignore: cast_nullable_to_non_nullable
as String,commissionLabel: null == commissionLabel ? _self.commissionLabel : commissionLabel // ignore: cast_nullable_to_non_nullable
as String,accountLabel: null == accountLabel ? _self.accountLabel : accountLabel // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PayoutModel].
extension PayoutModelPatterns on PayoutModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PayoutModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PayoutModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PayoutModel value)  $default,){
final _that = this;
switch (_that) {
case _PayoutModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PayoutModel value)?  $default,){
final _that = this;
switch (_that) {
case _PayoutModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int amount,  int grossAmount,  String missionTitle,  String posterName,  String validatedAt,  String commissionLabel,  String accountLabel,  String reference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PayoutModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int amount,  int grossAmount,  String missionTitle,  String posterName,  String validatedAt,  String commissionLabel,  String accountLabel,  String reference)  $default,) {final _that = this;
switch (_that) {
case _PayoutModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int amount,  int grossAmount,  String missionTitle,  String posterName,  String validatedAt,  String commissionLabel,  String accountLabel,  String reference)?  $default,) {final _that = this;
switch (_that) {
case _PayoutModel() when $default != null:
return $default(_that.id,_that.amount,_that.grossAmount,_that.missionTitle,_that.posterName,_that.validatedAt,_that.commissionLabel,_that.accountLabel,_that.reference);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PayoutModel extends PayoutModel {
  const _PayoutModel({required this.id, required this.amount, required this.grossAmount, required this.missionTitle, required this.posterName, required this.validatedAt, required this.commissionLabel, required this.accountLabel, required this.reference}): super._();
  factory _PayoutModel.fromJson(Map<String, dynamic> json) => _$PayoutModelFromJson(json);

@override final  String id;
@override final  int amount;
@override final  int grossAmount;
@override final  String missionTitle;
@override final  String posterName;
@override final  String validatedAt;
@override final  String commissionLabel;
@override final  String accountLabel;
@override final  String reference;

/// Create a copy of PayoutModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayoutModelCopyWith<_PayoutModel> get copyWith => __$PayoutModelCopyWithImpl<_PayoutModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PayoutModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayoutModel&&(identical(other.id, id) || other.id == id)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.grossAmount, grossAmount) || other.grossAmount == grossAmount)&&(identical(other.missionTitle, missionTitle) || other.missionTitle == missionTitle)&&(identical(other.posterName, posterName) || other.posterName == posterName)&&(identical(other.validatedAt, validatedAt) || other.validatedAt == validatedAt)&&(identical(other.commissionLabel, commissionLabel) || other.commissionLabel == commissionLabel)&&(identical(other.accountLabel, accountLabel) || other.accountLabel == accountLabel)&&(identical(other.reference, reference) || other.reference == reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,amount,grossAmount,missionTitle,posterName,validatedAt,commissionLabel,accountLabel,reference);

@override
String toString() {
  return 'PayoutModel(id: $id, amount: $amount, grossAmount: $grossAmount, missionTitle: $missionTitle, posterName: $posterName, validatedAt: $validatedAt, commissionLabel: $commissionLabel, accountLabel: $accountLabel, reference: $reference)';
}


}

/// @nodoc
abstract mixin class _$PayoutModelCopyWith<$Res> implements $PayoutModelCopyWith<$Res> {
  factory _$PayoutModelCopyWith(_PayoutModel value, $Res Function(_PayoutModel) _then) = __$PayoutModelCopyWithImpl;
@override @useResult
$Res call({
 String id, int amount, int grossAmount, String missionTitle, String posterName, String validatedAt, String commissionLabel, String accountLabel, String reference
});




}
/// @nodoc
class __$PayoutModelCopyWithImpl<$Res>
    implements _$PayoutModelCopyWith<$Res> {
  __$PayoutModelCopyWithImpl(this._self, this._then);

  final _PayoutModel _self;
  final $Res Function(_PayoutModel) _then;

/// Create a copy of PayoutModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? amount = null,Object? grossAmount = null,Object? missionTitle = null,Object? posterName = null,Object? validatedAt = null,Object? commissionLabel = null,Object? accountLabel = null,Object? reference = null,}) {
  return _then(_PayoutModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,grossAmount: null == grossAmount ? _self.grossAmount : grossAmount // ignore: cast_nullable_to_non_nullable
as int,missionTitle: null == missionTitle ? _self.missionTitle : missionTitle // ignore: cast_nullable_to_non_nullable
as String,posterName: null == posterName ? _self.posterName : posterName // ignore: cast_nullable_to_non_nullable
as String,validatedAt: null == validatedAt ? _self.validatedAt : validatedAt // ignore: cast_nullable_to_non_nullable
as String,commissionLabel: null == commissionLabel ? _self.commissionLabel : commissionLabel // ignore: cast_nullable_to_non_nullable
as String,accountLabel: null == accountLabel ? _self.accountLabel : accountLabel // ignore: cast_nullable_to_non_nullable
as String,reference: null == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
