// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_alert_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MissionAlertModel {

 String get id; String? get keyword; String? get category; String get zone; int? get minPay; String get days;
/// Create a copy of MissionAlertModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissionAlertModelCopyWith<MissionAlertModel> get copyWith => _$MissionAlertModelCopyWithImpl<MissionAlertModel>(this as MissionAlertModel, _$identity);

  /// Serializes this MissionAlertModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissionAlertModel&&(identical(other.id, id) || other.id == id)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.category, category) || other.category == category)&&(identical(other.zone, zone) || other.zone == zone)&&(identical(other.minPay, minPay) || other.minPay == minPay)&&(identical(other.days, days) || other.days == days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,keyword,category,zone,minPay,days);

@override
String toString() {
  return 'MissionAlertModel(id: $id, keyword: $keyword, category: $category, zone: $zone, minPay: $minPay, days: $days)';
}


}

/// @nodoc
abstract mixin class $MissionAlertModelCopyWith<$Res>  {
  factory $MissionAlertModelCopyWith(MissionAlertModel value, $Res Function(MissionAlertModel) _then) = _$MissionAlertModelCopyWithImpl;
@useResult
$Res call({
 String id, String? keyword, String? category, String zone, int? minPay, String days
});




}
/// @nodoc
class _$MissionAlertModelCopyWithImpl<$Res>
    implements $MissionAlertModelCopyWith<$Res> {
  _$MissionAlertModelCopyWithImpl(this._self, this._then);

  final MissionAlertModel _self;
  final $Res Function(MissionAlertModel) _then;

/// Create a copy of MissionAlertModel
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


/// Adds pattern-matching-related methods to [MissionAlertModel].
extension MissionAlertModelPatterns on MissionAlertModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MissionAlertModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MissionAlertModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MissionAlertModel value)  $default,){
final _that = this;
switch (_that) {
case _MissionAlertModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MissionAlertModel value)?  $default,){
final _that = this;
switch (_that) {
case _MissionAlertModel() when $default != null:
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
case _MissionAlertModel() when $default != null:
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
case _MissionAlertModel():
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
case _MissionAlertModel() when $default != null:
return $default(_that.id,_that.keyword,_that.category,_that.zone,_that.minPay,_that.days);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MissionAlertModel extends MissionAlertModel {
  const _MissionAlertModel({required this.id, this.keyword, this.category, required this.zone, this.minPay, required this.days}): super._();
  factory _MissionAlertModel.fromJson(Map<String, dynamic> json) => _$MissionAlertModelFromJson(json);

@override final  String id;
@override final  String? keyword;
@override final  String? category;
@override final  String zone;
@override final  int? minPay;
@override final  String days;

/// Create a copy of MissionAlertModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissionAlertModelCopyWith<_MissionAlertModel> get copyWith => __$MissionAlertModelCopyWithImpl<_MissionAlertModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MissionAlertModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissionAlertModel&&(identical(other.id, id) || other.id == id)&&(identical(other.keyword, keyword) || other.keyword == keyword)&&(identical(other.category, category) || other.category == category)&&(identical(other.zone, zone) || other.zone == zone)&&(identical(other.minPay, minPay) || other.minPay == minPay)&&(identical(other.days, days) || other.days == days));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,keyword,category,zone,minPay,days);

@override
String toString() {
  return 'MissionAlertModel(id: $id, keyword: $keyword, category: $category, zone: $zone, minPay: $minPay, days: $days)';
}


}

/// @nodoc
abstract mixin class _$MissionAlertModelCopyWith<$Res> implements $MissionAlertModelCopyWith<$Res> {
  factory _$MissionAlertModelCopyWith(_MissionAlertModel value, $Res Function(_MissionAlertModel) _then) = __$MissionAlertModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? keyword, String? category, String zone, int? minPay, String days
});




}
/// @nodoc
class __$MissionAlertModelCopyWithImpl<$Res>
    implements _$MissionAlertModelCopyWith<$Res> {
  __$MissionAlertModelCopyWithImpl(this._self, this._then);

  final _MissionAlertModel _self;
  final $Res Function(_MissionAlertModel) _then;

/// Create a copy of MissionAlertModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? keyword = freezed,Object? category = freezed,Object? zone = null,Object? minPay = freezed,Object? days = null,}) {
  return _then(_MissionAlertModel(
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

// dart format on
