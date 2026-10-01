// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_page_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MissionPageModel {

 List<MissionModel> get items; int get total; int get radiusKm; String get updatedAt;
/// Create a copy of MissionPageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissionPageModelCopyWith<MissionPageModel> get copyWith => _$MissionPageModelCopyWithImpl<MissionPageModel>(this as MissionPageModel, _$identity);

  /// Serializes this MissionPageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissionPageModel&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.total, total) || other.total == total)&&(identical(other.radiusKm, radiusKm) || other.radiusKm == radiusKm)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),total,radiusKm,updatedAt);

@override
String toString() {
  return 'MissionPageModel(items: $items, total: $total, radiusKm: $radiusKm, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MissionPageModelCopyWith<$Res>  {
  factory $MissionPageModelCopyWith(MissionPageModel value, $Res Function(MissionPageModel) _then) = _$MissionPageModelCopyWithImpl;
@useResult
$Res call({
 List<MissionModel> items, int total, int radiusKm, String updatedAt
});




}
/// @nodoc
class _$MissionPageModelCopyWithImpl<$Res>
    implements $MissionPageModelCopyWith<$Res> {
  _$MissionPageModelCopyWithImpl(this._self, this._then);

  final MissionPageModel _self;
  final $Res Function(MissionPageModel) _then;

/// Create a copy of MissionPageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? total = null,Object? radiusKm = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<MissionModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,radiusKm: null == radiusKm ? _self.radiusKm : radiusKm // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MissionPageModel].
extension MissionPageModelPatterns on MissionPageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MissionPageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MissionPageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MissionPageModel value)  $default,){
final _that = this;
switch (_that) {
case _MissionPageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MissionPageModel value)?  $default,){
final _that = this;
switch (_that) {
case _MissionPageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<MissionModel> items,  int total,  int radiusKm,  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MissionPageModel() when $default != null:
return $default(_that.items,_that.total,_that.radiusKm,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<MissionModel> items,  int total,  int radiusKm,  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _MissionPageModel():
return $default(_that.items,_that.total,_that.radiusKm,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<MissionModel> items,  int total,  int radiusKm,  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MissionPageModel() when $default != null:
return $default(_that.items,_that.total,_that.radiusKm,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MissionPageModel extends MissionPageModel {
  const _MissionPageModel({required final  List<MissionModel> items, required this.total, required this.radiusKm, required this.updatedAt}): _items = items,super._();
  factory _MissionPageModel.fromJson(Map<String, dynamic> json) => _$MissionPageModelFromJson(json);

 final  List<MissionModel> _items;
@override List<MissionModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int total;
@override final  int radiusKm;
@override final  String updatedAt;

/// Create a copy of MissionPageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissionPageModelCopyWith<_MissionPageModel> get copyWith => __$MissionPageModelCopyWithImpl<_MissionPageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MissionPageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissionPageModel&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.total, total) || other.total == total)&&(identical(other.radiusKm, radiusKm) || other.radiusKm == radiusKm)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),total,radiusKm,updatedAt);

@override
String toString() {
  return 'MissionPageModel(items: $items, total: $total, radiusKm: $radiusKm, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MissionPageModelCopyWith<$Res> implements $MissionPageModelCopyWith<$Res> {
  factory _$MissionPageModelCopyWith(_MissionPageModel value, $Res Function(_MissionPageModel) _then) = __$MissionPageModelCopyWithImpl;
@override @useResult
$Res call({
 List<MissionModel> items, int total, int radiusKm, String updatedAt
});




}
/// @nodoc
class __$MissionPageModelCopyWithImpl<$Res>
    implements _$MissionPageModelCopyWith<$Res> {
  __$MissionPageModelCopyWithImpl(this._self, this._then);

  final _MissionPageModel _self;
  final $Res Function(_MissionPageModel) _then;

/// Create a copy of MissionPageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? total = null,Object? radiusKm = null,Object? updatedAt = null,}) {
  return _then(_MissionPageModel(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<MissionModel>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,radiusKm: null == radiusKm ? _self.radiusKm : radiusKm // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
