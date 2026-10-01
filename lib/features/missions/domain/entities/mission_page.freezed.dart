// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_page.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MissionPage {

 List<Mission> get items; int get total; int get radiusKm; DateTime get updatedAt;
/// Create a copy of MissionPage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissionPageCopyWith<MissionPage> get copyWith => _$MissionPageCopyWithImpl<MissionPage>(this as MissionPage, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissionPage&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.total, total) || other.total == total)&&(identical(other.radiusKm, radiusKm) || other.radiusKm == radiusKm)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),total,radiusKm,updatedAt);

@override
String toString() {
  return 'MissionPage(items: $items, total: $total, radiusKm: $radiusKm, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $MissionPageCopyWith<$Res>  {
  factory $MissionPageCopyWith(MissionPage value, $Res Function(MissionPage) _then) = _$MissionPageCopyWithImpl;
@useResult
$Res call({
 List<Mission> items, int total, int radiusKm, DateTime updatedAt
});




}
/// @nodoc
class _$MissionPageCopyWithImpl<$Res>
    implements $MissionPageCopyWith<$Res> {
  _$MissionPageCopyWithImpl(this._self, this._then);

  final MissionPage _self;
  final $Res Function(MissionPage) _then;

/// Create a copy of MissionPage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? total = null,Object? radiusKm = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Mission>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,radiusKm: null == radiusKm ? _self.radiusKm : radiusKm // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [MissionPage].
extension MissionPagePatterns on MissionPage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MissionPage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MissionPage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MissionPage value)  $default,){
final _that = this;
switch (_that) {
case _MissionPage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MissionPage value)?  $default,){
final _that = this;
switch (_that) {
case _MissionPage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Mission> items,  int total,  int radiusKm,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MissionPage() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Mission> items,  int total,  int radiusKm,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _MissionPage():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Mission> items,  int total,  int radiusKm,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _MissionPage() when $default != null:
return $default(_that.items,_that.total,_that.radiusKm,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc


class _MissionPage implements MissionPage {
  const _MissionPage({required final  List<Mission> items, required this.total, required this.radiusKm, required this.updatedAt}): _items = items;
  

 final  List<Mission> _items;
@override List<Mission> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  int total;
@override final  int radiusKm;
@override final  DateTime updatedAt;

/// Create a copy of MissionPage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissionPageCopyWith<_MissionPage> get copyWith => __$MissionPageCopyWithImpl<_MissionPage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissionPage&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.total, total) || other.total == total)&&(identical(other.radiusKm, radiusKm) || other.radiusKm == radiusKm)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),total,radiusKm,updatedAt);

@override
String toString() {
  return 'MissionPage(items: $items, total: $total, radiusKm: $radiusKm, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$MissionPageCopyWith<$Res> implements $MissionPageCopyWith<$Res> {
  factory _$MissionPageCopyWith(_MissionPage value, $Res Function(_MissionPage) _then) = __$MissionPageCopyWithImpl;
@override @useResult
$Res call({
 List<Mission> items, int total, int radiusKm, DateTime updatedAt
});




}
/// @nodoc
class __$MissionPageCopyWithImpl<$Res>
    implements _$MissionPageCopyWith<$Res> {
  __$MissionPageCopyWithImpl(this._self, this._then);

  final _MissionPage _self;
  final $Res Function(_MissionPage) _then;

/// Create a copy of MissionPage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? total = null,Object? radiusKm = null,Object? updatedAt = null,}) {
  return _then(_MissionPage(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Mission>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,radiusKm: null == radiusKm ? _self.radiusKm : radiusKm // ignore: cast_nullable_to_non_nullable
as int,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
