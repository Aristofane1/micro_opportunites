// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'earnings_summary.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EarningLine {

 String get id; String get title; EarningStatus get status; DateTime get date; int get amount; String? get payoutId;
/// Create a copy of EarningLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarningLineCopyWith<EarningLine> get copyWith => _$EarningLineCopyWithImpl<EarningLine>(this as EarningLine, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarningLine&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.payoutId, payoutId) || other.payoutId == payoutId));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,status,date,amount,payoutId);

@override
String toString() {
  return 'EarningLine(id: $id, title: $title, status: $status, date: $date, amount: $amount, payoutId: $payoutId)';
}


}

/// @nodoc
abstract mixin class $EarningLineCopyWith<$Res>  {
  factory $EarningLineCopyWith(EarningLine value, $Res Function(EarningLine) _then) = _$EarningLineCopyWithImpl;
@useResult
$Res call({
 String id, String title, EarningStatus status, DateTime date, int amount, String? payoutId
});




}
/// @nodoc
class _$EarningLineCopyWithImpl<$Res>
    implements $EarningLineCopyWith<$Res> {
  _$EarningLineCopyWithImpl(this._self, this._then);

  final EarningLine _self;
  final $Res Function(EarningLine) _then;

/// Create a copy of EarningLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? status = null,Object? date = null,Object? amount = null,Object? payoutId = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EarningStatus,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,payoutId: freezed == payoutId ? _self.payoutId : payoutId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EarningLine].
extension EarningLinePatterns on EarningLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarningLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarningLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarningLine value)  $default,){
final _that = this;
switch (_that) {
case _EarningLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarningLine value)?  $default,){
final _that = this;
switch (_that) {
case _EarningLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  EarningStatus status,  DateTime date,  int amount,  String? payoutId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarningLine() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  EarningStatus status,  DateTime date,  int amount,  String? payoutId)  $default,) {final _that = this;
switch (_that) {
case _EarningLine():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  EarningStatus status,  DateTime date,  int amount,  String? payoutId)?  $default,) {final _that = this;
switch (_that) {
case _EarningLine() when $default != null:
return $default(_that.id,_that.title,_that.status,_that.date,_that.amount,_that.payoutId);case _:
  return null;

}
}

}

/// @nodoc


class _EarningLine implements EarningLine {
  const _EarningLine({required this.id, required this.title, required this.status, required this.date, required this.amount, this.payoutId});
  

@override final  String id;
@override final  String title;
@override final  EarningStatus status;
@override final  DateTime date;
@override final  int amount;
@override final  String? payoutId;

/// Create a copy of EarningLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarningLineCopyWith<_EarningLine> get copyWith => __$EarningLineCopyWithImpl<_EarningLine>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarningLine&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.date, date) || other.date == date)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.payoutId, payoutId) || other.payoutId == payoutId));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,status,date,amount,payoutId);

@override
String toString() {
  return 'EarningLine(id: $id, title: $title, status: $status, date: $date, amount: $amount, payoutId: $payoutId)';
}


}

/// @nodoc
abstract mixin class _$EarningLineCopyWith<$Res> implements $EarningLineCopyWith<$Res> {
  factory _$EarningLineCopyWith(_EarningLine value, $Res Function(_EarningLine) _then) = __$EarningLineCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, EarningStatus status, DateTime date, int amount, String? payoutId
});




}
/// @nodoc
class __$EarningLineCopyWithImpl<$Res>
    implements _$EarningLineCopyWith<$Res> {
  __$EarningLineCopyWithImpl(this._self, this._then);

  final _EarningLine _self;
  final $Res Function(_EarningLine) _then;

/// Create a copy of EarningLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? status = null,Object? date = null,Object? amount = null,Object? payoutId = freezed,}) {
  return _then(_EarningLine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EarningStatus,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,payoutId: freezed == payoutId ? _self.payoutId : payoutId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc
mixin _$PayoutAccount {

 String get operator; String get maskedNumber; String get holderName;
/// Create a copy of PayoutAccount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayoutAccountCopyWith<PayoutAccount> get copyWith => _$PayoutAccountCopyWithImpl<PayoutAccount>(this as PayoutAccount, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayoutAccount&&(identical(other.operator, operator) || other.operator == operator)&&(identical(other.maskedNumber, maskedNumber) || other.maskedNumber == maskedNumber)&&(identical(other.holderName, holderName) || other.holderName == holderName));
}


@override
int get hashCode => Object.hash(runtimeType,operator,maskedNumber,holderName);

@override
String toString() {
  return 'PayoutAccount(operator: $operator, maskedNumber: $maskedNumber, holderName: $holderName)';
}


}

/// @nodoc
abstract mixin class $PayoutAccountCopyWith<$Res>  {
  factory $PayoutAccountCopyWith(PayoutAccount value, $Res Function(PayoutAccount) _then) = _$PayoutAccountCopyWithImpl;
@useResult
$Res call({
 String operator, String maskedNumber, String holderName
});




}
/// @nodoc
class _$PayoutAccountCopyWithImpl<$Res>
    implements $PayoutAccountCopyWith<$Res> {
  _$PayoutAccountCopyWithImpl(this._self, this._then);

  final PayoutAccount _self;
  final $Res Function(PayoutAccount) _then;

/// Create a copy of PayoutAccount
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


/// Adds pattern-matching-related methods to [PayoutAccount].
extension PayoutAccountPatterns on PayoutAccount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PayoutAccount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PayoutAccount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PayoutAccount value)  $default,){
final _that = this;
switch (_that) {
case _PayoutAccount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PayoutAccount value)?  $default,){
final _that = this;
switch (_that) {
case _PayoutAccount() when $default != null:
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
case _PayoutAccount() when $default != null:
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
case _PayoutAccount():
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
case _PayoutAccount() when $default != null:
return $default(_that.operator,_that.maskedNumber,_that.holderName);case _:
  return null;

}
}

}

/// @nodoc


class _PayoutAccount implements PayoutAccount {
  const _PayoutAccount({required this.operator, required this.maskedNumber, required this.holderName});
  

@override final  String operator;
@override final  String maskedNumber;
@override final  String holderName;

/// Create a copy of PayoutAccount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayoutAccountCopyWith<_PayoutAccount> get copyWith => __$PayoutAccountCopyWithImpl<_PayoutAccount>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayoutAccount&&(identical(other.operator, operator) || other.operator == operator)&&(identical(other.maskedNumber, maskedNumber) || other.maskedNumber == maskedNumber)&&(identical(other.holderName, holderName) || other.holderName == holderName));
}


@override
int get hashCode => Object.hash(runtimeType,operator,maskedNumber,holderName);

@override
String toString() {
  return 'PayoutAccount(operator: $operator, maskedNumber: $maskedNumber, holderName: $holderName)';
}


}

/// @nodoc
abstract mixin class _$PayoutAccountCopyWith<$Res> implements $PayoutAccountCopyWith<$Res> {
  factory _$PayoutAccountCopyWith(_PayoutAccount value, $Res Function(_PayoutAccount) _then) = __$PayoutAccountCopyWithImpl;
@override @useResult
$Res call({
 String operator, String maskedNumber, String holderName
});




}
/// @nodoc
class __$PayoutAccountCopyWithImpl<$Res>
    implements _$PayoutAccountCopyWith<$Res> {
  __$PayoutAccountCopyWithImpl(this._self, this._then);

  final _PayoutAccount _self;
  final $Res Function(_PayoutAccount) _then;

/// Create a copy of PayoutAccount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? operator = null,Object? maskedNumber = null,Object? holderName = null,}) {
  return _then(_PayoutAccount(
operator: null == operator ? _self.operator : operator // ignore: cast_nullable_to_non_nullable
as String,maskedNumber: null == maskedNumber ? _self.maskedNumber : maskedNumber // ignore: cast_nullable_to_non_nullable
as String,holderName: null == holderName ? _self.holderName : holderName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$EarningsSummary {

 int get upcomingAmount; int get upcomingCount; int get paidAmount; int get paidCount; String get paidPeriodLabel; PayoutAccount get payoutAccount; List<EarningLine> get lines;
/// Create a copy of EarningsSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EarningsSummaryCopyWith<EarningsSummary> get copyWith => _$EarningsSummaryCopyWithImpl<EarningsSummary>(this as EarningsSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EarningsSummary&&(identical(other.upcomingAmount, upcomingAmount) || other.upcomingAmount == upcomingAmount)&&(identical(other.upcomingCount, upcomingCount) || other.upcomingCount == upcomingCount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.paidCount, paidCount) || other.paidCount == paidCount)&&(identical(other.paidPeriodLabel, paidPeriodLabel) || other.paidPeriodLabel == paidPeriodLabel)&&(identical(other.payoutAccount, payoutAccount) || other.payoutAccount == payoutAccount)&&const DeepCollectionEquality().equals(other.lines, lines));
}


@override
int get hashCode => Object.hash(runtimeType,upcomingAmount,upcomingCount,paidAmount,paidCount,paidPeriodLabel,payoutAccount,const DeepCollectionEquality().hash(lines));

@override
String toString() {
  return 'EarningsSummary(upcomingAmount: $upcomingAmount, upcomingCount: $upcomingCount, paidAmount: $paidAmount, paidCount: $paidCount, paidPeriodLabel: $paidPeriodLabel, payoutAccount: $payoutAccount, lines: $lines)';
}


}

/// @nodoc
abstract mixin class $EarningsSummaryCopyWith<$Res>  {
  factory $EarningsSummaryCopyWith(EarningsSummary value, $Res Function(EarningsSummary) _then) = _$EarningsSummaryCopyWithImpl;
@useResult
$Res call({
 int upcomingAmount, int upcomingCount, int paidAmount, int paidCount, String paidPeriodLabel, PayoutAccount payoutAccount, List<EarningLine> lines
});


$PayoutAccountCopyWith<$Res> get payoutAccount;

}
/// @nodoc
class _$EarningsSummaryCopyWithImpl<$Res>
    implements $EarningsSummaryCopyWith<$Res> {
  _$EarningsSummaryCopyWithImpl(this._self, this._then);

  final EarningsSummary _self;
  final $Res Function(EarningsSummary) _then;

/// Create a copy of EarningsSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? upcomingAmount = null,Object? upcomingCount = null,Object? paidAmount = null,Object? paidCount = null,Object? paidPeriodLabel = null,Object? payoutAccount = null,Object? lines = null,}) {
  return _then(_self.copyWith(
upcomingAmount: null == upcomingAmount ? _self.upcomingAmount : upcomingAmount // ignore: cast_nullable_to_non_nullable
as int,upcomingCount: null == upcomingCount ? _self.upcomingCount : upcomingCount // ignore: cast_nullable_to_non_nullable
as int,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int,paidCount: null == paidCount ? _self.paidCount : paidCount // ignore: cast_nullable_to_non_nullable
as int,paidPeriodLabel: null == paidPeriodLabel ? _self.paidPeriodLabel : paidPeriodLabel // ignore: cast_nullable_to_non_nullable
as String,payoutAccount: null == payoutAccount ? _self.payoutAccount : payoutAccount // ignore: cast_nullable_to_non_nullable
as PayoutAccount,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<EarningLine>,
  ));
}
/// Create a copy of EarningsSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayoutAccountCopyWith<$Res> get payoutAccount {
  
  return $PayoutAccountCopyWith<$Res>(_self.payoutAccount, (value) {
    return _then(_self.copyWith(payoutAccount: value));
  });
}
}


/// Adds pattern-matching-related methods to [EarningsSummary].
extension EarningsSummaryPatterns on EarningsSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EarningsSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EarningsSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EarningsSummary value)  $default,){
final _that = this;
switch (_that) {
case _EarningsSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EarningsSummary value)?  $default,){
final _that = this;
switch (_that) {
case _EarningsSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int upcomingAmount,  int upcomingCount,  int paidAmount,  int paidCount,  String paidPeriodLabel,  PayoutAccount payoutAccount,  List<EarningLine> lines)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EarningsSummary() when $default != null:
return $default(_that.upcomingAmount,_that.upcomingCount,_that.paidAmount,_that.paidCount,_that.paidPeriodLabel,_that.payoutAccount,_that.lines);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int upcomingAmount,  int upcomingCount,  int paidAmount,  int paidCount,  String paidPeriodLabel,  PayoutAccount payoutAccount,  List<EarningLine> lines)  $default,) {final _that = this;
switch (_that) {
case _EarningsSummary():
return $default(_that.upcomingAmount,_that.upcomingCount,_that.paidAmount,_that.paidCount,_that.paidPeriodLabel,_that.payoutAccount,_that.lines);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int upcomingAmount,  int upcomingCount,  int paidAmount,  int paidCount,  String paidPeriodLabel,  PayoutAccount payoutAccount,  List<EarningLine> lines)?  $default,) {final _that = this;
switch (_that) {
case _EarningsSummary() when $default != null:
return $default(_that.upcomingAmount,_that.upcomingCount,_that.paidAmount,_that.paidCount,_that.paidPeriodLabel,_that.payoutAccount,_that.lines);case _:
  return null;

}
}

}

/// @nodoc


class _EarningsSummary implements EarningsSummary {
  const _EarningsSummary({required this.upcomingAmount, required this.upcomingCount, required this.paidAmount, required this.paidCount, required this.paidPeriodLabel, required this.payoutAccount, required final  List<EarningLine> lines}): _lines = lines;
  

@override final  int upcomingAmount;
@override final  int upcomingCount;
@override final  int paidAmount;
@override final  int paidCount;
@override final  String paidPeriodLabel;
@override final  PayoutAccount payoutAccount;
 final  List<EarningLine> _lines;
@override List<EarningLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}


/// Create a copy of EarningsSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EarningsSummaryCopyWith<_EarningsSummary> get copyWith => __$EarningsSummaryCopyWithImpl<_EarningsSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EarningsSummary&&(identical(other.upcomingAmount, upcomingAmount) || other.upcomingAmount == upcomingAmount)&&(identical(other.upcomingCount, upcomingCount) || other.upcomingCount == upcomingCount)&&(identical(other.paidAmount, paidAmount) || other.paidAmount == paidAmount)&&(identical(other.paidCount, paidCount) || other.paidCount == paidCount)&&(identical(other.paidPeriodLabel, paidPeriodLabel) || other.paidPeriodLabel == paidPeriodLabel)&&(identical(other.payoutAccount, payoutAccount) || other.payoutAccount == payoutAccount)&&const DeepCollectionEquality().equals(other._lines, _lines));
}


@override
int get hashCode => Object.hash(runtimeType,upcomingAmount,upcomingCount,paidAmount,paidCount,paidPeriodLabel,payoutAccount,const DeepCollectionEquality().hash(_lines));

@override
String toString() {
  return 'EarningsSummary(upcomingAmount: $upcomingAmount, upcomingCount: $upcomingCount, paidAmount: $paidAmount, paidCount: $paidCount, paidPeriodLabel: $paidPeriodLabel, payoutAccount: $payoutAccount, lines: $lines)';
}


}

/// @nodoc
abstract mixin class _$EarningsSummaryCopyWith<$Res> implements $EarningsSummaryCopyWith<$Res> {
  factory _$EarningsSummaryCopyWith(_EarningsSummary value, $Res Function(_EarningsSummary) _then) = __$EarningsSummaryCopyWithImpl;
@override @useResult
$Res call({
 int upcomingAmount, int upcomingCount, int paidAmount, int paidCount, String paidPeriodLabel, PayoutAccount payoutAccount, List<EarningLine> lines
});


@override $PayoutAccountCopyWith<$Res> get payoutAccount;

}
/// @nodoc
class __$EarningsSummaryCopyWithImpl<$Res>
    implements _$EarningsSummaryCopyWith<$Res> {
  __$EarningsSummaryCopyWithImpl(this._self, this._then);

  final _EarningsSummary _self;
  final $Res Function(_EarningsSummary) _then;

/// Create a copy of EarningsSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? upcomingAmount = null,Object? upcomingCount = null,Object? paidAmount = null,Object? paidCount = null,Object? paidPeriodLabel = null,Object? payoutAccount = null,Object? lines = null,}) {
  return _then(_EarningsSummary(
upcomingAmount: null == upcomingAmount ? _self.upcomingAmount : upcomingAmount // ignore: cast_nullable_to_non_nullable
as int,upcomingCount: null == upcomingCount ? _self.upcomingCount : upcomingCount // ignore: cast_nullable_to_non_nullable
as int,paidAmount: null == paidAmount ? _self.paidAmount : paidAmount // ignore: cast_nullable_to_non_nullable
as int,paidCount: null == paidCount ? _self.paidCount : paidCount // ignore: cast_nullable_to_non_nullable
as int,paidPeriodLabel: null == paidPeriodLabel ? _self.paidPeriodLabel : paidPeriodLabel // ignore: cast_nullable_to_non_nullable
as String,payoutAccount: null == payoutAccount ? _self.payoutAccount : payoutAccount // ignore: cast_nullable_to_non_nullable
as PayoutAccount,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<EarningLine>,
  ));
}

/// Create a copy of EarningsSummary
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayoutAccountCopyWith<$Res> get payoutAccount {
  
  return $PayoutAccountCopyWith<$Res>(_self.payoutAccount, (value) {
    return _then(_self.copyWith(payoutAccount: value));
  });
}
}

// dart format on
