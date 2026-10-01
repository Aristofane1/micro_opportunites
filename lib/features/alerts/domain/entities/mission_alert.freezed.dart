// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_alert.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MissionAlert {

 String get id; String? get keyword; String? get category; String get zone; int? get minPay; String get days;
/// Create a copy of MissionAlert
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissionAlertCopyWith<MissionAlert> get copyWith => _$MissionAlertCopyWithImpl<MissionAlert>(this as MissionAlert, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissionAlert&&(identical(other.id, id) || other.id == id)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.category, category) || other.category == category)&&(identical(other.zone, zone) || other.zone == zone)&&(identical(other.minPay, minPay) || other.minPay == minPay)&&(identical(other.days, days) || other.days == days));
}


@override
int get hashCode => Object.hash(runtimeType,id,keyword,category,zone,minPay,days);

@override
String toString() {
  return 'MissionAlert(id: $id, keyword: $keyword, category: $category, zone: $zone, minPay: $minPay, days: $days)';
}


}

/// @nodoc
abstract mixin class $MissionAlertCopyWith<$Res>  {
  factory $MissionAlertCopyWith(MissionAlert value, $Res Function(MissionAlert) _then) = _$MissionAlertCopyWithImpl;
@useResult
$Res call({
 String id, String? keyword, String? category, String zone, int? minPay, String days
});




}
/// @nodoc
class _$MissionAlertCopyWithImpl<$Res>
    implements $MissionAlertCopyWith<$Res> {
  _$MissionAlertCopyWithImpl(this._self, this._then);

  final MissionAlert _self;
  final $Res Function(MissionAlert) _then;

/// Create a copy of MissionAlert
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? keyword = freezed,Object? category = freezed,Object? zone = null,Object? minPay = freezed,Object? days = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,zone: null == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String,minPay: freezed == minPay ? _self.minPay : minPay // ignore: cast_nullable_to_non_nullable
as int?,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MissionAlert].
extension MissionAlertPatterns on MissionAlert {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MissionAlert value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MissionAlert() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MissionAlert value)  $default,){
final _that = this;
switch (_that) {
case _MissionAlert():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MissionAlert value)?  $default,){
final _that = this;
switch (_that) {
case _MissionAlert() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? keyword,  String? category,  String zone,  int? minPay,  String days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MissionAlert() when $default != null:
return $default(_that.id,_that.keyword,_that.category,_that.zone,_that.minPay,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? keyword,  String? category,  String zone,  int? minPay,  String days)  $default,) {final _that = this;
switch (_that) {
case _MissionAlert():
return $default(_that.id,_that.keyword,_that.category,_that.zone,_that.minPay,_that.days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? keyword,  String? category,  String zone,  int? minPay,  String days)?  $default,) {final _that = this;
switch (_that) {
case _MissionAlert() when $default != null:
return $default(_that.id,_that.keyword,_that.category,_that.zone,_that.minPay,_that.days);case _:
  return null;

}
}

}

/// @nodoc


class _MissionAlert extends MissionAlert {
  const _MissionAlert({required this.id, this.keyword, this.category, required this.zone, this.minPay, required this.days}): super._();
  

@override final  String id;
@override final  String? keyword;
@override final  String? category;
@override final  String zone;
@override final  int? minPay;
@override final  String days;

/// Create a copy of MissionAlert
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissionAlertCopyWith<_MissionAlert> get copyWith => __$MissionAlertCopyWithImpl<_MissionAlert>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissionAlert&&(identical(other.id, id) || other.id == id)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.category, category) || other.category == category)&&(identical(other.zone, zone) || other.zone == zone)&&(identical(other.minPay, minPay) || other.minPay == minPay)&&(identical(other.days, days) || other.days == days));
}


@override
int get hashCode => Object.hash(runtimeType,id,keyword,category,zone,minPay,days);

@override
String toString() {
  return 'MissionAlert(id: $id, keyword: $keyword, category: $category, zone: $zone, minPay: $minPay, days: $days)';
}


}

/// @nodoc
abstract mixin class _$MissionAlertCopyWith<$Res> implements $MissionAlertCopyWith<$Res> {
  factory _$MissionAlertCopyWith(_MissionAlert value, $Res Function(_MissionAlert) _then) = __$MissionAlertCopyWithImpl;
@override @useResult
$Res call({
 String id, String? keyword, String? category, String zone, int? minPay, String days
});




}
/// @nodoc
class __$MissionAlertCopyWithImpl<$Res>
    implements _$MissionAlertCopyWith<$Res> {
  __$MissionAlertCopyWithImpl(this._self, this._then);

  final _MissionAlert _self;
  final $Res Function(_MissionAlert) _then;

/// Create a copy of MissionAlert
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? keyword = freezed,Object? category = freezed,Object? zone = null,Object? minPay = freezed,Object? days = null,}) {
  return _then(_MissionAlert(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,zone: null == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String,minPay: freezed == minPay ? _self.minPay : minPay // ignore: cast_nullable_to_non_nullable
as int?,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$AlertDraft {

 String? get keyword; String? get category; String get zone; int? get minPay; String get days;
/// Create a copy of AlertDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AlertDraftCopyWith<AlertDraft> get copyWith => _$AlertDraftCopyWithImpl<AlertDraft>(this as AlertDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AlertDraft&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.category, category) || other.category == category)&&(identical(other.zone, zone) || other.zone == zone)&&(identical(other.minPay, minPay) || other.minPay == minPay)&&(identical(other.days, days) || other.days == days));
}


@override
int get hashCode => Object.hash(runtimeType,keyword,category,zone,minPay,days);

@override
String toString() {
  return 'AlertDraft(keyword: $keyword, category: $category, zone: $zone, minPay: $minPay, days: $days)';
}


}

/// @nodoc
abstract mixin class $AlertDraftCopyWith<$Res>  {
  factory $AlertDraftCopyWith(AlertDraft value, $Res Function(AlertDraft) _then) = _$AlertDraftCopyWithImpl;
@useResult
$Res call({
 String? keyword, String? category, String zone, int? minPay, String days
});




}
/// @nodoc
class _$AlertDraftCopyWithImpl<$Res>
    implements $AlertDraftCopyWith<$Res> {
  _$AlertDraftCopyWithImpl(this._self, this._then);

  final AlertDraft _self;
  final $Res Function(AlertDraft) _then;

/// Create a copy of AlertDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? keyword = freezed,Object? category = freezed,Object? zone = null,Object? minPay = freezed,Object? days = null,}) {
  return _then(_self.copyWith(
keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,zone: null == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String,minPay: freezed == minPay ? _self.minPay : minPay // ignore: cast_nullable_to_non_nullable
as int?,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AlertDraft].
extension AlertDraftPatterns on AlertDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AlertDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AlertDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AlertDraft value)  $default,){
final _that = this;
switch (_that) {
case _AlertDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AlertDraft value)?  $default,){
final _that = this;
switch (_that) {
case _AlertDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? keyword,  String? category,  String zone,  int? minPay,  String days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AlertDraft() when $default != null:
return $default(_that.keyword,_that.category,_that.zone,_that.minPay,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? keyword,  String? category,  String zone,  int? minPay,  String days)  $default,) {final _that = this;
switch (_that) {
case _AlertDraft():
return $default(_that.keyword,_that.category,_that.zone,_that.minPay,_that.days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? keyword,  String? category,  String zone,  int? minPay,  String days)?  $default,) {final _that = this;
switch (_that) {
case _AlertDraft() when $default != null:
return $default(_that.keyword,_that.category,_that.zone,_that.minPay,_that.days);case _:
  return null;

}
}

}

/// @nodoc


class _AlertDraft implements AlertDraft {
  const _AlertDraft({this.keyword, this.category, required this.zone, this.minPay, required this.days});
  

@override final  String? keyword;
@override final  String? category;
@override final  String zone;
@override final  int? minPay;
@override final  String days;

/// Create a copy of AlertDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AlertDraftCopyWith<_AlertDraft> get copyWith => __$AlertDraftCopyWithImpl<_AlertDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AlertDraft&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.category, category) || other.category == category)&&(identical(other.zone, zone) || other.zone == zone)&&(identical(other.minPay, minPay) || other.minPay == minPay)&&(identical(other.days, days) || other.days == days));
}


@override
int get hashCode => Object.hash(runtimeType,keyword,category,zone,minPay,days);

@override
String toString() {
  return 'AlertDraft(keyword: $keyword, category: $category, zone: $zone, minPay: $minPay, days: $days)';
}


}

/// @nodoc
abstract mixin class _$AlertDraftCopyWith<$Res> implements $AlertDraftCopyWith<$Res> {
  factory _$AlertDraftCopyWith(_AlertDraft value, $Res Function(_AlertDraft) _then) = __$AlertDraftCopyWithImpl;
@override @useResult
$Res call({
 String? keyword, String? category, String zone, int? minPay, String days
});




}
/// @nodoc
class __$AlertDraftCopyWithImpl<$Res>
    implements _$AlertDraftCopyWith<$Res> {
  __$AlertDraftCopyWithImpl(this._self, this._then);

  final _AlertDraft _self;
  final $Res Function(_AlertDraft) _then;

/// Create a copy of AlertDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? keyword = freezed,Object? category = freezed,Object? zone = null,Object? minPay = freezed,Object? days = null,}) {
  return _then(_AlertDraft(
keyword: freezed == keyword ? _self.keyword : keyword // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,zone: null == zone ? _self.zone : zone // ignore: cast_nullable_to_non_nullable
as String,minPay: freezed == minPay ? _self.minPay : minPay // ignore: cast_nullable_to_non_nullable
as int?,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
