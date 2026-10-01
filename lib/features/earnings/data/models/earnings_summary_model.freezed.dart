// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earnings_summary_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EarningsSummaryModel {

 AmountCountModel get upcoming; PaidTotalModel get paid; PayoutAccountModel get payoutAccount; List<EarningLineModel> get lines;
/// Create a copy of EarningsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarningsSummaryModelCopyWith<EarningsSummaryModel> get copyWith => _$EarningsSummaryModelCopyWithImpl<EarningsSummaryModel>(this as EarningsSummaryModel, _$identity);

  /// Serializes this EarningsSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarningsSummaryModel&&(identical(other.upcoming, upcoming) || other.upcoming == upcoming)&&(identical(other.paid, paid) || other.paid == paid)&&(identical(other.payoutAccount, payoutAccount) || other.payoutAccount == payoutAccount)&&const DeepCollectionEquality().equals(other.lines, lines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,upcoming,paid,payoutAccount,const DeepCollectionEquality().hash(lines));

@override
String toString() {
  return 'EarningsSummaryModel(upcoming: $upcoming, paid: $paid, payoutAccount: $payoutAccount, lines: $lines)';
}


}

/// @nodoc
abstract mixin class $EarningsSummaryModelCopyWith<$Res>  {
  factory $EarningsSummaryModelCopyWith(EarningsSummaryModel value, $Res Function(EarningsSummaryModel) _then) = _$EarningsSummaryModelCopyWithImpl;
@useResult
$Res call({
 AmountCountModel upcoming, PaidTotalModel paid, PayoutAccountModel payoutAccount, List<EarningLineModel> lines
});


$AmountCountModelCopyWith<$Res> get upcoming;$PaidTotalModelCopyWith<$Res> get paid;$PayoutAccountModelCopyWith<$Res> get payoutAccount;

}
/// @nodoc
class _$EarningsSummaryModelCopyWithImpl<$Res>
    implements $EarningsSummaryModelCopyWith<$Res> {
  _$EarningsSummaryModelCopyWithImpl(this._self, this._then);

  final EarningsSummaryModel _self;
  final $Res Function(EarningsSummaryModel) _then;

/// Create a copy of EarningsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? upcoming = null,Object? paid = null,Object? payoutAccount = null,Object? lines = null,}) {
  return _then(_self.copyWith(
upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as AmountCountModel,paid: null == paid ? _self.paid : paid // ignore: cast_nullable_to_non_nullable
as PaidTotalModel,payoutAccount: null == payoutAccount ? _self.payoutAccount : payoutAccount // ignore: cast_nullable_to_non_nullable
as PayoutAccountModel,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<EarningLineModel>,
  ));
}
/// Create a copy of EarningsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmountCountModelCopyWith<$Res> get upcoming {
  
  return $AmountCountModelCopyWith<$Res>(_self.upcoming, (value) {
    return _then(_self.copyWith(upcoming: value));
  });
}/// Create a copy of EarningsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaidTotalModelCopyWith<$Res> get paid {
  
  return $PaidTotalModelCopyWith<$Res>(_self.paid, (value) {
    return _then(_self.copyWith(paid: value));
  });
}/// Create a copy of EarningsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayoutAccountModelCopyWith<$Res> get payoutAccount {
  
  return $PayoutAccountModelCopyWith<$Res>(_self.payoutAccount, (value) {
    return _then(_self.copyWith(payoutAccount: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarningsSummaryModel].
extension EarningsSummaryModelPatterns on EarningsSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarningsSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarningsSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarningsSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _EarningsSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarningsSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _EarningsSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AmountCountModel upcoming,  PaidTotalModel paid,  PayoutAccountModel payoutAccount,  List<EarningLineModel> lines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarningsSummaryModel() when $default != null:
return $default(_that.upcoming,_that.paid,_that.payoutAccount,_that.lines);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AmountCountModel upcoming,  PaidTotalModel paid,  PayoutAccountModel payoutAccount,  List<EarningLineModel> lines)  $default,) {final _that = this;
switch (_that) {
case _EarningsSummaryModel():
return $default(_that.upcoming,_that.paid,_that.payoutAccount,_that.lines);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AmountCountModel upcoming,  PaidTotalModel paid,  PayoutAccountModel payoutAccount,  List<EarningLineModel> lines)?  $default,) {final _that = this;
switch (_that) {
case _EarningsSummaryModel() when $default != null:
return $default(_that.upcoming,_that.paid,_that.payoutAccount,_that.lines);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarningsSummaryModel extends EarningsSummaryModel {
  const _EarningsSummaryModel({required this.upcoming, required this.paid, required this.payoutAccount, required final  List<EarningLineModel> lines}): _lines = lines,super._();
  factory _EarningsSummaryModel.fromJson(Map<String, dynamic> json) => _$EarningsSummaryModelFromJson(json);

@override final  AmountCountModel upcoming;
@override final  PaidTotalModel paid;
@override final  PayoutAccountModel payoutAccount;
 final  List<EarningLineModel> _lines;
@override List<EarningLineModel> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}


/// Create a copy of EarningsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarningsSummaryModelCopyWith<_EarningsSummaryModel> get copyWith => __$EarningsSummaryModelCopyWithImpl<_EarningsSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarningsSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarningsSummaryModel&&(identical(other.upcoming, upcoming) || other.upcoming == upcoming)&&(identical(other.paid, paid) || other.paid == paid)&&(identical(other.payoutAccount, payoutAccount) || other.payoutAccount == payoutAccount)&&const DeepCollectionEquality().equals(other._lines, _lines));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,upcoming,paid,payoutAccount,const DeepCollectionEquality().hash(_lines));

@override
String toString() {
  return 'EarningsSummaryModel(upcoming: $upcoming, paid: $paid, payoutAccount: $payoutAccount, lines: $lines)';
}


}

/// @nodoc
abstract mixin class _$EarningsSummaryModelCopyWith<$Res> implements $EarningsSummaryModelCopyWith<$Res> {
  factory _$EarningsSummaryModelCopyWith(_EarningsSummaryModel value, $Res Function(_EarningsSummaryModel) _then) = __$EarningsSummaryModelCopyWithImpl;
@override @useResult
$Res call({
 AmountCountModel upcoming, PaidTotalModel paid, PayoutAccountModel payoutAccount, List<EarningLineModel> lines
});


@override $AmountCountModelCopyWith<$Res> get upcoming;@override $PaidTotalModelCopyWith<$Res> get paid;@override $PayoutAccountModelCopyWith<$Res> get payoutAccount;

}
/// @nodoc
class __$EarningsSummaryModelCopyWithImpl<$Res>
    implements _$EarningsSummaryModelCopyWith<$Res> {
  __$EarningsSummaryModelCopyWithImpl(this._self, this._then);

  final _EarningsSummaryModel _self;
  final $Res Function(_EarningsSummaryModel) _then;

/// Create a copy of EarningsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? upcoming = null,Object? paid = null,Object? payoutAccount = null,Object? lines = null,}) {
  return _then(_EarningsSummaryModel(
upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as AmountCountModel,paid: null == paid ? _self.paid : paid // ignore: cast_nullable_to_non_nullable
as PaidTotalModel,payoutAccount: null == payoutAccount ? _self.payoutAccount : payoutAccount // ignore: cast_nullable_to_non_nullable
as PayoutAccountModel,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<EarningLineModel>,
  ));
}

/// Create a copy of EarningsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AmountCountModelCopyWith<$Res> get upcoming {
  
  return $AmountCountModelCopyWith<$Res>(_self.upcoming, (value) {
    return _then(_self.copyWith(upcoming: value));
  });
}/// Create a copy of EarningsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaidTotalModelCopyWith<$Res> get paid {
  
  return $PaidTotalModelCopyWith<$Res>(_self.paid, (value) {
    return _then(_self.copyWith(paid: value));
  });
}/// Create a copy of EarningsSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayoutAccountModelCopyWith<$Res> get payoutAccount {
  
  return $PayoutAccountModelCopyWith<$Res>(_self.payoutAccount, (value) {
    return _then(_self.copyWith(payoutAccount: value));
  });
}
}


/// @nodoc
mixin _$AmountCountModel {

 int get amount; int get count;
/// Create a copy of AmountCountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AmountCountModelCopyWith<AmountCountModel> get copyWith => _$AmountCountModelCopyWithImpl<AmountCountModel>(this as AmountCountModel, _$identity);

  /// Serializes this AmountCountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AmountCountModel&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,count);

@override
String toString() {
  return 'AmountCountModel(amount: $amount, count: $count)';
}


}

/// @nodoc
abstract mixin class $AmountCountModelCopyWith<$Res>  {
  factory $AmountCountModelCopyWith(AmountCountModel value, $Res Function(AmountCountModel) _then) = _$AmountCountModelCopyWithImpl;
@useResult
$Res call({
 int amount, int count
});




}
/// @nodoc
class _$AmountCountModelCopyWithImpl<$Res>
    implements $AmountCountModelCopyWith<$Res> {
  _$AmountCountModelCopyWithImpl(this._self, this._then);

  final AmountCountModel _self;
  final $Res Function(AmountCountModel) _then;

/// Create a copy of AmountCountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? count = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AmountCountModel].
extension AmountCountModelPatterns on AmountCountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AmountCountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AmountCountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AmountCountModel value)  $default,){
final _that = this;
switch (_that) {
case _AmountCountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AmountCountModel value)?  $default,){
final _that = this;
switch (_that) {
case _AmountCountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int amount,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AmountCountModel() when $default != null:
return $default(_that.amount,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int amount,  int count)  $default,) {final _that = this;
switch (_that) {
case _AmountCountModel():
return $default(_that.amount,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int amount,  int count)?  $default,) {final _that = this;
switch (_that) {
case _AmountCountModel() when $default != null:
return $default(_that.amount,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AmountCountModel implements AmountCountModel {
  const _AmountCountModel({required this.amount, required this.count});
  factory _AmountCountModel.fromJson(Map<String, dynamic> json) => _$AmountCountModelFromJson(json);

@override final  int amount;
@override final  int count;

/// Create a copy of AmountCountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AmountCountModelCopyWith<_AmountCountModel> get copyWith => __$AmountCountModelCopyWithImpl<_AmountCountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AmountCountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AmountCountModel&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,count);

@override
String toString() {
  return 'AmountCountModel(amount: $amount, count: $count)';
}


}

/// @nodoc
abstract mixin class _$AmountCountModelCopyWith<$Res> implements $AmountCountModelCopyWith<$Res> {
  factory _$AmountCountModelCopyWith(_AmountCountModel value, $Res Function(_AmountCountModel) _then) = __$AmountCountModelCopyWithImpl;
@override @useResult
$Res call({
 int amount, int count
});




}
/// @nodoc
class __$AmountCountModelCopyWithImpl<$Res>
    implements _$AmountCountModelCopyWith<$Res> {
  __$AmountCountModelCopyWithImpl(this._self, this._then);

  final _AmountCountModel _self;
  final $Res Function(_AmountCountModel) _then;

/// Create a copy of AmountCountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? count = null,}) {
  return _then(_AmountCountModel(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PaidTotalModel {

 int get amount; int get count; String get periodLabel;
/// Create a copy of PaidTotalModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaidTotalModelCopyWith<PaidTotalModel> get copyWith => _$PaidTotalModelCopyWithImpl<PaidTotalModel>(this as PaidTotalModel, _$identity);

  /// Serializes this PaidTotalModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaidTotalModel&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.count, count) || other.count == count)&&(identical(other.periodLabel, periodLabel) || other.periodLabel == periodLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,count,periodLabel);

@override
String toString() {
  return 'PaidTotalModel(amount: $amount, count: $count, periodLabel: $periodLabel)';
}


}

/// @nodoc
abstract mixin class $PaidTotalModelCopyWith<$Res>  {
  factory $PaidTotalModelCopyWith(PaidTotalModel value, $Res Function(PaidTotalModel) _then) = _$PaidTotalModelCopyWithImpl;
@useResult
$Res call({
 int amount, int count, String periodLabel
});




}
/// @nodoc
class _$PaidTotalModelCopyWithImpl<$Res>
    implements $PaidTotalModelCopyWith<$Res> {
  _$PaidTotalModelCopyWithImpl(this._self, this._then);

  final PaidTotalModel _self;
  final $Res Function(PaidTotalModel) _then;

/// Create a copy of PaidTotalModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? count = null,Object? periodLabel = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,periodLabel: null == periodLabel ? _self.periodLabel : periodLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PaidTotalModel].
extension PaidTotalModelPatterns on PaidTotalModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaidTotalModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaidTotalModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaidTotalModel value)  $default,){
final _that = this;
switch (_that) {
case _PaidTotalModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaidTotalModel value)?  $default,){
final _that = this;
switch (_that) {
case _PaidTotalModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int amount,  int count,  String periodLabel)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaidTotalModel() when $default != null:
return $default(_that.amount,_that.count,_that.periodLabel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int amount,  int count,  String periodLabel)  $default,) {final _that = this;
switch (_that) {
case _PaidTotalModel():
return $default(_that.amount,_that.count,_that.periodLabel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int amount,  int count,  String periodLabel)?  $default,) {final _that = this;
switch (_that) {
case _PaidTotalModel() when $default != null:
return $default(_that.amount,_that.count,_that.periodLabel);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaidTotalModel implements PaidTotalModel {
  const _PaidTotalModel({required this.amount, required this.count, required this.periodLabel});
  factory _PaidTotalModel.fromJson(Map<String, dynamic> json) => _$PaidTotalModelFromJson(json);

@override final  int amount;
@override final  int count;
@override final  String periodLabel;

/// Create a copy of PaidTotalModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaidTotalModelCopyWith<_PaidTotalModel> get copyWith => __$PaidTotalModelCopyWithImpl<_PaidTotalModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaidTotalModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaidTotalModel&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.count, count) || other.count == count)&&(identical(other.periodLabel, periodLabel) || other.periodLabel == periodLabel));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,count,periodLabel);

@override
String toString() {
  return 'PaidTotalModel(amount: $amount, count: $count, periodLabel: $periodLabel)';
}


}

/// @nodoc
abstract mixin class _$PaidTotalModelCopyWith<$Res> implements $PaidTotalModelCopyWith<$Res> {
  factory _$PaidTotalModelCopyWith(_PaidTotalModel value, $Res Function(_PaidTotalModel) _then) = __$PaidTotalModelCopyWithImpl;
@override @useResult
$Res call({
 int amount, int count, String periodLabel
});




}
/// @nodoc
class __$PaidTotalModelCopyWithImpl<$Res>
    implements _$PaidTotalModelCopyWith<$Res> {
  __$PaidTotalModelCopyWithImpl(this._self, this._then);

  final _PaidTotalModel _self;
  final $Res Function(_PaidTotalModel) _then;

/// Create a copy of PaidTotalModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? count = null,Object? periodLabel = null,}) {
  return _then(_PaidTotalModel(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,periodLabel: null == periodLabel ? _self.periodLabel : periodLabel // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PayoutAccountModel {

 String get operator; String get maskedNumber; String get holderName;
/// Create a copy of PayoutAccountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayoutAccountModelCopyWith<PayoutAccountModel> get copyWith => _$PayoutAccountModelCopyWithImpl<PayoutAccountModel>(this as PayoutAccountModel, _$identity);

  /// Serializes this PayoutAccountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayoutAccountModel&&(identical(other.operator, operator) || other.operator == operator)&&(identical(other.maskedNumber, maskedNumber) || other.maskedNumber == maskedNumber)&&(identical(other.holderName, holderName) || other.holderName == holderName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,operator,maskedNumber,holderName);

@override
String toString() {
  return 'PayoutAccountModel(operator: $operator, maskedNumber: $maskedNumber, holderName: $holderName)';
}


}

/// @nodoc
abstract mixin class $PayoutAccountModelCopyWith<$Res>  {
  factory $PayoutAccountModelCopyWith(PayoutAccountModel value, $Res Function(PayoutAccountModel) _then) = _$PayoutAccountModelCopyWithImpl;
@useResult
$Res call({
 String operator, String maskedNumber, String holderName
});




}
/// @nodoc
class _$PayoutAccountModelCopyWithImpl<$Res>
    implements $PayoutAccountModelCopyWith<$Res> {
  _$PayoutAccountModelCopyWithImpl(this._self, this._then);

  final PayoutAccountModel _self;
  final $Res Function(PayoutAccountModel) _then;

/// Create a copy of PayoutAccountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? operator = null,Object? maskedNumber = null,Object? holderName = null,}) {
  return _then(_self.copyWith(
operator: null == operator ? _self.operator : operator // ignore: cast_nullable_to_non_nullable
as String,maskedNumber: null == maskedNumber ? _self.maskedNumber : maskedNumber // ignore: cast_nullable_to_non_nullable
as String,holderName: null == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PayoutAccountModel].
extension PayoutAccountModelPatterns on PayoutAccountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PayoutAccountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PayoutAccountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PayoutAccountModel value)  $default,){
final _that = this;
switch (_that) {
case _PayoutAccountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PayoutAccountModel value)?  $default,){
final _that = this;
switch (_that) {
case _PayoutAccountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String operator,  String maskedNumber,  String holderName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PayoutAccountModel() when $default != null:
return $default(_that.operator,_that.maskedNumber,_that.holderName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String operator,  String maskedNumber,  String holderName)  $default,) {final _that = this;
switch (_that) {
case _PayoutAccountModel():
return $default(_that.operator,_that.maskedNumber,_that.holderName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String operator,  String maskedNumber,  String holderName)?  $default,) {final _that = this;
switch (_that) {
case _PayoutAccountModel() when $default != null:
return $default(_that.operator,_that.maskedNumber,_that.holderName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PayoutAccountModel implements PayoutAccountModel {
  const _PayoutAccountModel({required this.operator, required this.maskedNumber, required this.holderName});
  factory _PayoutAccountModel.fromJson(Map<String, dynamic> json) => _$PayoutAccountModelFromJson(json);

@override final  String operator;
@override final  String maskedNumber;
@override final  String holderName;

/// Create a copy of PayoutAccountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayoutAccountModelCopyWith<_PayoutAccountModel> get copyWith => __$PayoutAccountModelCopyWithImpl<_PayoutAccountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PayoutAccountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayoutAccountModel&&(identical(other.operator, operator) || other.operator == operator)&&(identical(other.maskedNumber, maskedNumber) || other.maskedNumber == maskedNumber)&&(identical(other.holderName, holderName) || other.holderName == holderName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,operator,maskedNumber,holderName);

@override
String toString() {
  return 'PayoutAccountModel(operator: $operator, maskedNumber: $maskedNumber, holderName: $holderName)';
}


}

/// @nodoc
abstract mixin class _$PayoutAccountModelCopyWith<$Res> implements $PayoutAccountModelCopyWith<$Res> {
  factory _$PayoutAccountModelCopyWith(_PayoutAccountModel value, $Res Function(_PayoutAccountModel) _then) = __$PayoutAccountModelCopyWithImpl;
@override @useResult
$Res call({
 String operator, String maskedNumber, String holderName
});




}
/// @nodoc
class __$PayoutAccountModelCopyWithImpl<$Res>
    implements _$PayoutAccountModelCopyWith<$Res> {
  __$PayoutAccountModelCopyWithImpl(this._self, this._then);

  final _PayoutAccountModel _self;
  final $Res Function(_PayoutAccountModel) _then;

/// Create a copy of PayoutAccountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? operator = null,Object? maskedNumber = null,Object? holderName = null,}) {
  return _then(_PayoutAccountModel(
operator: null == operator ? _self.operator : operator // ignore: cast_nullable_to_non_nullable
as String,maskedNumber: null == maskedNumber ? _self.maskedNumber : maskedNumber // ignore: cast_nullable_to_non_nullable
as String,holderName: null == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$EarningLineModel {

 String get id; String get title; String get status; String get date; int get amount; String? get payoutId;
/// Create a copy of EarningLineModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarningLineModelCopyWith<EarningLineModel> get copyWith => _$EarningLineModelCopyWithImpl<EarningLineModel>(this as EarningLineModel, _$identity);

  /// Serializes this EarningLineModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarningLineModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.payoutId, payoutId) || other.payoutId == payoutId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,status,date,amount,payoutId);

@override
String toString() {
  return 'EarningLineModel(id: $id, title: $title, status: $status, date: $date, amount: $amount, payoutId: $payoutId)';
}


}

/// @nodoc
abstract mixin class $EarningLineModelCopyWith<$Res>  {
  factory $EarningLineModelCopyWith(EarningLineModel value, $Res Function(EarningLineModel) _then) = _$EarningLineModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String status, String date, int amount, String? payoutId
});




}
/// @nodoc
class _$EarningLineModelCopyWithImpl<$Res>
    implements $EarningLineModelCopyWith<$Res> {
  _$EarningLineModelCopyWithImpl(this._self, this._then);

  final EarningLineModel _self;
  final $Res Function(EarningLineModel) _then;

/// Create a copy of EarningLineModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? status = null,Object? date = null,Object? amount = null,Object? payoutId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,payoutId: freezed == payoutId ? _self.payoutId : payoutId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarningLineModel].
extension EarningLineModelPatterns on EarningLineModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarningLineModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarningLineModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarningLineModel value)  $default,){
final _that = this;
switch (_that) {
case _EarningLineModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarningLineModel value)?  $default,){
final _that = this;
switch (_that) {
case _EarningLineModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String status,  String date,  int amount,  String? payoutId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarningLineModel() when $default != null:
return $default(_that.id,_that.title,_that.status,_that.date,_that.amount,_that.payoutId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String status,  String date,  int amount,  String? payoutId)  $default,) {final _that = this;
switch (_that) {
case _EarningLineModel():
return $default(_that.id,_that.title,_that.status,_that.date,_that.amount,_that.payoutId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String status,  String date,  int amount,  String? payoutId)?  $default,) {final _that = this;
switch (_that) {
case _EarningLineModel() when $default != null:
return $default(_that.id,_that.title,_that.status,_that.date,_that.amount,_that.payoutId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EarningLineModel extends EarningLineModel {
  const _EarningLineModel({required this.id, required this.title, required this.status, required this.date, required this.amount, this.payoutId}): super._();
  factory _EarningLineModel.fromJson(Map<String, dynamic> json) => _$EarningLineModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String status;
@override final  String date;
@override final  int amount;
@override final  String? payoutId;

/// Create a copy of EarningLineModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarningLineModelCopyWith<_EarningLineModel> get copyWith => __$EarningLineModelCopyWithImpl<_EarningLineModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EarningLineModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarningLineModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.payoutId, payoutId) || other.payoutId == payoutId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,status,date,amount,payoutId);

@override
String toString() {
  return 'EarningLineModel(id: $id, title: $title, status: $status, date: $date, amount: $amount, payoutId: $payoutId)';
}


}

/// @nodoc
abstract mixin class _$EarningLineModelCopyWith<$Res> implements $EarningLineModelCopyWith<$Res> {
  factory _$EarningLineModelCopyWith(_EarningLineModel value, $Res Function(_EarningLineModel) _then) = __$EarningLineModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String status, String date, int amount, String? payoutId
});




}
/// @nodoc
class __$EarningLineModelCopyWithImpl<$Res>
    implements _$EarningLineModelCopyWith<$Res> {
  __$EarningLineModelCopyWithImpl(this._self, this._then);

  final _EarningLineModel _self;
  final $Res Function(_EarningLineModel) _then;

/// Create a copy of EarningLineModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? status = null,Object? date = null,Object? amount = null,Object? payoutId = freezed,}) {
  return _then(_EarningLineModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,payoutId: freezed == payoutId ? _self.payoutId : payoutId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
