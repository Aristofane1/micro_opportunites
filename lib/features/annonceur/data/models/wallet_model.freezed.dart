// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WalletModel {

 int get balance; int get available; List<BlockedAmountModel> get blocked; List<PosterPayoutModel> get payouts;
/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WalletModelCopyWith<WalletModel> get copyWith => _$WalletModelCopyWithImpl<WalletModel>(this as WalletModel, _$identity);

  /// Serializes this WalletModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WalletModel&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.available, available) || other.available == available)&&const DeepCollectionEquality().equals(other.blocked, blocked)&&const DeepCollectionEquality().equals(other.payouts, payouts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,balance,available,const DeepCollectionEquality().hash(blocked),const DeepCollectionEquality().hash(payouts));

@override
String toString() {
  return 'WalletModel(balance: $balance, available: $available, blocked: $blocked, payouts: $payouts)';
}


}

/// @nodoc
abstract mixin class $WalletModelCopyWith<$Res>  {
  factory $WalletModelCopyWith(WalletModel value, $Res Function(WalletModel) _then) = _$WalletModelCopyWithImpl;
@useResult
$Res call({
 int balance, int available, List<BlockedAmountModel> blocked, List<PosterPayoutModel> payouts
});




}
/// @nodoc
class _$WalletModelCopyWithImpl<$Res>
    implements $WalletModelCopyWith<$Res> {
  _$WalletModelCopyWithImpl(this._self, this._then);

  final WalletModel _self;
  final $Res Function(WalletModel) _then;

/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? balance = null,Object? available = null,Object? blocked = null,Object? payouts = null,}) {
  return _then(_self.copyWith(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as int,blocked: null == blocked ? _self.blocked : blocked // ignore: cast_nullable_to_non_nullable
as List<BlockedAmountModel>,payouts: null == payouts ? _self.payouts : payouts // ignore: cast_nullable_to_non_nullable
as List<PosterPayoutModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [WalletModel].
extension WalletModelPatterns on WalletModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WalletModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WalletModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WalletModel value)  $default,){
final _that = this;
switch (_that) {
case _WalletModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WalletModel value)?  $default,){
final _that = this;
switch (_that) {
case _WalletModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int balance,  int available,  List<BlockedAmountModel> blocked,  List<PosterPayoutModel> payouts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WalletModel() when $default != null:
return $default(_that.balance,_that.available,_that.blocked,_that.payouts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int balance,  int available,  List<BlockedAmountModel> blocked,  List<PosterPayoutModel> payouts)  $default,) {final _that = this;
switch (_that) {
case _WalletModel():
return $default(_that.balance,_that.available,_that.blocked,_that.payouts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int balance,  int available,  List<BlockedAmountModel> blocked,  List<PosterPayoutModel> payouts)?  $default,) {final _that = this;
switch (_that) {
case _WalletModel() when $default != null:
return $default(_that.balance,_that.available,_that.blocked,_that.payouts);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WalletModel extends WalletModel {
  const _WalletModel({required this.balance, required this.available, required final  List<BlockedAmountModel> blocked, required final  List<PosterPayoutModel> payouts}): _blocked = blocked,_payouts = payouts,super._();
  factory _WalletModel.fromJson(Map<String, dynamic> json) => _$WalletModelFromJson(json);

@override final  int balance;
@override final  int available;
 final  List<BlockedAmountModel> _blocked;
@override List<BlockedAmountModel> get blocked {
  if (_blocked is EqualUnmodifiableListView) return _blocked;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blocked);
}

 final  List<PosterPayoutModel> _payouts;
@override List<PosterPayoutModel> get payouts {
  if (_payouts is EqualUnmodifiableListView) return _payouts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_payouts);
}


/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WalletModelCopyWith<_WalletModel> get copyWith => __$WalletModelCopyWithImpl<_WalletModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WalletModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WalletModel&&(identical(other.balance, balance) || other.balance == balance)&&(identical(other.available, available) || other.available == available)&&const DeepCollectionEquality().equals(other._blocked, _blocked)&&const DeepCollectionEquality().equals(other._payouts, _payouts));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,balance,available,const DeepCollectionEquality().hash(_blocked),const DeepCollectionEquality().hash(_payouts));

@override
String toString() {
  return 'WalletModel(balance: $balance, available: $available, blocked: $blocked, payouts: $payouts)';
}


}

/// @nodoc
abstract mixin class _$WalletModelCopyWith<$Res> implements $WalletModelCopyWith<$Res> {
  factory _$WalletModelCopyWith(_WalletModel value, $Res Function(_WalletModel) _then) = __$WalletModelCopyWithImpl;
@override @useResult
$Res call({
 int balance, int available, List<BlockedAmountModel> blocked, List<PosterPayoutModel> payouts
});




}
/// @nodoc
class __$WalletModelCopyWithImpl<$Res>
    implements _$WalletModelCopyWith<$Res> {
  __$WalletModelCopyWithImpl(this._self, this._then);

  final _WalletModel _self;
  final $Res Function(_WalletModel) _then;

/// Create a copy of WalletModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? balance = null,Object? available = null,Object? blocked = null,Object? payouts = null,}) {
  return _then(_WalletModel(
balance: null == balance ? _self.balance : balance // ignore: cast_nullable_to_non_nullable
as int,available: null == available ? _self.available : available // ignore: cast_nullable_to_non_nullable
as int,blocked: null == blocked ? _self._blocked : blocked // ignore: cast_nullable_to_non_nullable
as List<BlockedAmountModel>,payouts: null == payouts ? _self._payouts : payouts // ignore: cast_nullable_to_non_nullable
as List<PosterPayoutModel>,
  ));
}


}


/// @nodoc
mixin _$BlockedAmountModel {

 String get missionId; String get title; int get amount;
/// Create a copy of BlockedAmountModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlockedAmountModelCopyWith<BlockedAmountModel> get copyWith => _$BlockedAmountModelCopyWithImpl<BlockedAmountModel>(this as BlockedAmountModel, _$identity);

  /// Serializes this BlockedAmountModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlockedAmountModel&&(identical(other.missionId, missionId) || other.missionId == missionId)&&(identical(other.title, title) || other.title == title)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,missionId,title,amount);

@override
String toString() {
  return 'BlockedAmountModel(missionId: $missionId, title: $title, amount: $amount)';
}


}

/// @nodoc
abstract mixin class $BlockedAmountModelCopyWith<$Res>  {
  factory $BlockedAmountModelCopyWith(BlockedAmountModel value, $Res Function(BlockedAmountModel) _then) = _$BlockedAmountModelCopyWithImpl;
@useResult
$Res call({
 String missionId, String title, int amount
});




}
/// @nodoc
class _$BlockedAmountModelCopyWithImpl<$Res>
    implements $BlockedAmountModelCopyWith<$Res> {
  _$BlockedAmountModelCopyWithImpl(this._self, this._then);

  final BlockedAmountModel _self;
  final $Res Function(BlockedAmountModel) _then;

/// Create a copy of BlockedAmountModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? missionId = null,Object? title = null,Object? amount = null,}) {
  return _then(_self.copyWith(
missionId: null == missionId ? _self.missionId : missionId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BlockedAmountModel].
extension BlockedAmountModelPatterns on BlockedAmountModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlockedAmountModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlockedAmountModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlockedAmountModel value)  $default,){
final _that = this;
switch (_that) {
case _BlockedAmountModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlockedAmountModel value)?  $default,){
final _that = this;
switch (_that) {
case _BlockedAmountModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String missionId,  String title,  int amount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlockedAmountModel() when $default != null:
return $default(_that.missionId,_that.title,_that.amount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String missionId,  String title,  int amount)  $default,) {final _that = this;
switch (_that) {
case _BlockedAmountModel():
return $default(_that.missionId,_that.title,_that.amount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String missionId,  String title,  int amount)?  $default,) {final _that = this;
switch (_that) {
case _BlockedAmountModel() when $default != null:
return $default(_that.missionId,_that.title,_that.amount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BlockedAmountModel extends BlockedAmountModel {
  const _BlockedAmountModel({required this.missionId, required this.title, required this.amount}): super._();
  factory _BlockedAmountModel.fromJson(Map<String, dynamic> json) => _$BlockedAmountModelFromJson(json);

@override final  String missionId;
@override final  String title;
@override final  int amount;

/// Create a copy of BlockedAmountModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlockedAmountModelCopyWith<_BlockedAmountModel> get copyWith => __$BlockedAmountModelCopyWithImpl<_BlockedAmountModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlockedAmountModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlockedAmountModel&&(identical(other.missionId, missionId) || other.missionId == missionId)&&(identical(other.title, title) || other.title == title)&&(identical(other.amount, amount) || other.amount == amount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,missionId,title,amount);

@override
String toString() {
  return 'BlockedAmountModel(missionId: $missionId, title: $title, amount: $amount)';
}


}

/// @nodoc
abstract mixin class _$BlockedAmountModelCopyWith<$Res> implements $BlockedAmountModelCopyWith<$Res> {
  factory _$BlockedAmountModelCopyWith(_BlockedAmountModel value, $Res Function(_BlockedAmountModel) _then) = __$BlockedAmountModelCopyWithImpl;
@override @useResult
$Res call({
 String missionId, String title, int amount
});




}
/// @nodoc
class __$BlockedAmountModelCopyWithImpl<$Res>
    implements _$BlockedAmountModelCopyWith<$Res> {
  __$BlockedAmountModelCopyWithImpl(this._self, this._then);

  final _BlockedAmountModel _self;
  final $Res Function(_BlockedAmountModel) _then;

/// Create a copy of BlockedAmountModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? missionId = null,Object? title = null,Object? amount = null,}) {
  return _then(_BlockedAmountModel(
missionId: null == missionId ? _self.missionId : missionId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$PosterPayoutModel {

 String get id; String get missionTitle; String get workerName; int get amount; String get paidAt;
/// Create a copy of PosterPayoutModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PosterPayoutModelCopyWith<PosterPayoutModel> get copyWith => _$PosterPayoutModelCopyWithImpl<PosterPayoutModel>(this as PosterPayoutModel, _$identity);

  /// Serializes this PosterPayoutModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PosterPayoutModel&&(identical(other.id, id) || other.id == id)&&(identical(other.missionTitle, missionTitle) || other.missionTitle == missionTitle)&&(identical(other.workerName, workerName) || other.workerName == workerName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,missionTitle,workerName,amount,paidAt);

@override
String toString() {
  return 'PosterPayoutModel(id: $id, missionTitle: $missionTitle, workerName: $workerName, amount: $amount, paidAt: $paidAt)';
}


}

/// @nodoc
abstract mixin class $PosterPayoutModelCopyWith<$Res>  {
  factory $PosterPayoutModelCopyWith(PosterPayoutModel value, $Res Function(PosterPayoutModel) _then) = _$PosterPayoutModelCopyWithImpl;
@useResult
$Res call({
 String id, String missionTitle, String workerName, int amount, String paidAt
});




}
/// @nodoc
class _$PosterPayoutModelCopyWithImpl<$Res>
    implements $PosterPayoutModelCopyWith<$Res> {
  _$PosterPayoutModelCopyWithImpl(this._self, this._then);

  final PosterPayoutModel _self;
  final $Res Function(PosterPayoutModel) _then;

/// Create a copy of PosterPayoutModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? missionTitle = null,Object? workerName = null,Object? amount = null,Object? paidAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,missionTitle: null == missionTitle ? _self.missionTitle : missionTitle // ignore: cast_nullable_to_non_nullable
as String,workerName: null == workerName ? _self.workerName : workerName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,paidAt: null == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PosterPayoutModel].
extension PosterPayoutModelPatterns on PosterPayoutModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PosterPayoutModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PosterPayoutModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PosterPayoutModel value)  $default,){
final _that = this;
switch (_that) {
case _PosterPayoutModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PosterPayoutModel value)?  $default,){
final _that = this;
switch (_that) {
case _PosterPayoutModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String missionTitle,  String workerName,  int amount,  String paidAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PosterPayoutModel() when $default != null:
return $default(_that.id,_that.missionTitle,_that.workerName,_that.amount,_that.paidAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String missionTitle,  String workerName,  int amount,  String paidAt)  $default,) {final _that = this;
switch (_that) {
case _PosterPayoutModel():
return $default(_that.id,_that.missionTitle,_that.workerName,_that.amount,_that.paidAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String missionTitle,  String workerName,  int amount,  String paidAt)?  $default,) {final _that = this;
switch (_that) {
case _PosterPayoutModel() when $default != null:
return $default(_that.id,_that.missionTitle,_that.workerName,_that.amount,_that.paidAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PosterPayoutModel extends PosterPayoutModel {
  const _PosterPayoutModel({required this.id, required this.missionTitle, required this.workerName, required this.amount, required this.paidAt}): super._();
  factory _PosterPayoutModel.fromJson(Map<String, dynamic> json) => _$PosterPayoutModelFromJson(json);

@override final  String id;
@override final  String missionTitle;
@override final  String workerName;
@override final  int amount;
@override final  String paidAt;

/// Create a copy of PosterPayoutModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PosterPayoutModelCopyWith<_PosterPayoutModel> get copyWith => __$PosterPayoutModelCopyWithImpl<_PosterPayoutModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PosterPayoutModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PosterPayoutModel&&(identical(other.id, id) || other.id == id)&&(identical(other.missionTitle, missionTitle) || other.missionTitle == missionTitle)&&(identical(other.workerName, workerName) || other.workerName == workerName)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.paidAt, paidAt) || other.paidAt == paidAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,missionTitle,workerName,amount,paidAt);

@override
String toString() {
  return 'PosterPayoutModel(id: $id, missionTitle: $missionTitle, workerName: $workerName, amount: $amount, paidAt: $paidAt)';
}


}

/// @nodoc
abstract mixin class _$PosterPayoutModelCopyWith<$Res> implements $PosterPayoutModelCopyWith<$Res> {
  factory _$PosterPayoutModelCopyWith(_PosterPayoutModel value, $Res Function(_PosterPayoutModel) _then) = __$PosterPayoutModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String missionTitle, String workerName, int amount, String paidAt
});




}
/// @nodoc
class __$PosterPayoutModelCopyWithImpl<$Res>
    implements _$PosterPayoutModelCopyWith<$Res> {
  __$PosterPayoutModelCopyWithImpl(this._self, this._then);

  final _PosterPayoutModel _self;
  final $Res Function(_PosterPayoutModel) _then;

/// Create a copy of PosterPayoutModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? missionTitle = null,Object? workerName = null,Object? amount = null,Object? paidAt = null,}) {
  return _then(_PosterPayoutModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,missionTitle: null == missionTitle ? _self.missionTitle : missionTitle // ignore: cast_nullable_to_non_nullable
as String,workerName: null == workerName ? _self.workerName : workerName // ignore: cast_nullable_to_non_nullable
as String,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,paidAt: null == paidAt ? _self.paidAt : paidAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
