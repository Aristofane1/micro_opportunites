// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_map_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MissionMapModel {

 List<CityClusterModel> get items; double get userLat; double get userLng;
/// Create a copy of MissionMapModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissionMapModelCopyWith<MissionMapModel> get copyWith => _$MissionMapModelCopyWithImpl<MissionMapModel>(this as MissionMapModel, _$identity);

  /// Serializes this MissionMapModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissionMapModel&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.userLat, userLat) || other.userLat == userLat)&&(identical(other.userLng, userLng) || other.userLng == userLng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),userLat,userLng);

@override
String toString() {
  return 'MissionMapModel(items: $items, userLat: $userLat, userLng: $userLng)';
}


}

/// @nodoc
abstract mixin class $MissionMapModelCopyWith<$Res>  {
  factory $MissionMapModelCopyWith(MissionMapModel value, $Res Function(MissionMapModel) _then) = _$MissionMapModelCopyWithImpl;
@useResult
$Res call({
 List<CityClusterModel> items, double userLat, double userLng
});




}
/// @nodoc
class _$MissionMapModelCopyWithImpl<$Res>
    implements $MissionMapModelCopyWith<$Res> {
  _$MissionMapModelCopyWithImpl(this._self, this._then);

  final MissionMapModel _self;
  final $Res Function(MissionMapModel) _then;

/// Create a copy of MissionMapModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? userLat = null,Object? userLng = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<CityClusterModel>,userLat: null == userLat ? _self.userLat : userLat // ignore: cast_nullable_to_non_nullable
as double,userLng: null == userLng ? _self.userLng : userLng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MissionMapModel].
extension MissionMapModelPatterns on MissionMapModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MissionMapModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MissionMapModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MissionMapModel value)  $default,){
final _that = this;
switch (_that) {
case _MissionMapModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MissionMapModel value)?  $default,){
final _that = this;
switch (_that) {
case _MissionMapModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CityClusterModel> items,  double userLat,  double userLng)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MissionMapModel() when $default != null:
return $default(_that.items,_that.userLat,_that.userLng);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CityClusterModel> items,  double userLat,  double userLng)  $default,) {final _that = this;
switch (_that) {
case _MissionMapModel():
return $default(_that.items,_that.userLat,_that.userLng);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CityClusterModel> items,  double userLat,  double userLng)?  $default,) {final _that = this;
switch (_that) {
case _MissionMapModel() when $default != null:
return $default(_that.items,_that.userLat,_that.userLng);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MissionMapModel extends MissionMapModel {
  const _MissionMapModel({required final  List<CityClusterModel> items, required this.userLat, required this.userLng}): _items = items,super._();
  factory _MissionMapModel.fromJson(Map<String, dynamic> json) => _$MissionMapModelFromJson(json);

 final  List<CityClusterModel> _items;
@override List<CityClusterModel> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  double userLat;
@override final  double userLng;

/// Create a copy of MissionMapModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissionMapModelCopyWith<_MissionMapModel> get copyWith => __$MissionMapModelCopyWithImpl<_MissionMapModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MissionMapModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissionMapModel&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.userLat, userLat) || other.userLat == userLat)&&(identical(other.userLng, userLng) || other.userLng == userLng));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),userLat,userLng);

@override
String toString() {
  return 'MissionMapModel(items: $items, userLat: $userLat, userLng: $userLng)';
}


}

/// @nodoc
abstract mixin class _$MissionMapModelCopyWith<$Res> implements $MissionMapModelCopyWith<$Res> {
  factory _$MissionMapModelCopyWith(_MissionMapModel value, $Res Function(_MissionMapModel) _then) = __$MissionMapModelCopyWithImpl;
@override @useResult
$Res call({
 List<CityClusterModel> items, double userLat, double userLng
});




}
/// @nodoc
class __$MissionMapModelCopyWithImpl<$Res>
    implements _$MissionMapModelCopyWith<$Res> {
  __$MissionMapModelCopyWithImpl(this._self, this._then);

  final _MissionMapModel _self;
  final $Res Function(_MissionMapModel) _then;

/// Create a copy of MissionMapModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? userLat = null,Object? userLng = null,}) {
  return _then(_MissionMapModel(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<CityClusterModel>,userLat: null == userLat ? _self.userLat : userLat // ignore: cast_nullable_to_non_nullable
as double,userLng: null == userLng ? _self.userLng : userLng // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$CityClusterModel {

 String get city; int get count; double get lat; double get lng; int get minPay; int get maxPay;
/// Create a copy of CityClusterModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityClusterModelCopyWith<CityClusterModel> get copyWith => _$CityClusterModelCopyWithImpl<CityClusterModel>(this as CityClusterModel, _$identity);

  /// Serializes this CityClusterModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityClusterModel&&(identical(other.city, city) || other.city == city)&&(identical(other.count, count) || other.count == count)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.minPay, minPay) || other.minPay == minPay)&&(identical(other.maxPay, maxPay) || other.maxPay == maxPay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,count,lat,lng,minPay,maxPay);

@override
String toString() {
  return 'CityClusterModel(city: $city, count: $count, lat: $lat, lng: $lng, minPay: $minPay, maxPay: $maxPay)';
}


}

/// @nodoc
abstract mixin class $CityClusterModelCopyWith<$Res>  {
  factory $CityClusterModelCopyWith(CityClusterModel value, $Res Function(CityClusterModel) _then) = _$CityClusterModelCopyWithImpl;
@useResult
$Res call({
 String city, int count, double lat, double lng, int minPay, int maxPay
});




}
/// @nodoc
class _$CityClusterModelCopyWithImpl<$Res>
    implements $CityClusterModelCopyWith<$Res> {
  _$CityClusterModelCopyWithImpl(this._self, this._then);

  final CityClusterModel _self;
  final $Res Function(CityClusterModel) _then;

/// Create a copy of CityClusterModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? city = null,Object? count = null,Object? lat = null,Object? lng = null,Object? minPay = null,Object? maxPay = null,}) {
  return _then(_self.copyWith(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,minPay: null == minPay ? _self.minPay : minPay // ignore: cast_nullable_to_non_nullable
as int,maxPay: null == maxPay ? _self.maxPay : maxPay // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CityClusterModel].
extension CityClusterModelPatterns on CityClusterModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CityClusterModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CityClusterModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CityClusterModel value)  $default,){
final _that = this;
switch (_that) {
case _CityClusterModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CityClusterModel value)?  $default,){
final _that = this;
switch (_that) {
case _CityClusterModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String city,  int count,  double lat,  double lng,  int minPay,  int maxPay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CityClusterModel() when $default != null:
return $default(_that.city,_that.count,_that.lat,_that.lng,_that.minPay,_that.maxPay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String city,  int count,  double lat,  double lng,  int minPay,  int maxPay)  $default,) {final _that = this;
switch (_that) {
case _CityClusterModel():
return $default(_that.city,_that.count,_that.lat,_that.lng,_that.minPay,_that.maxPay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String city,  int count,  double lat,  double lng,  int minPay,  int maxPay)?  $default,) {final _that = this;
switch (_that) {
case _CityClusterModel() when $default != null:
return $default(_that.city,_that.count,_that.lat,_that.lng,_that.minPay,_that.maxPay);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CityClusterModel extends CityClusterModel {
  const _CityClusterModel({required this.city, required this.count, required this.lat, required this.lng, required this.minPay, required this.maxPay}): super._();
  factory _CityClusterModel.fromJson(Map<String, dynamic> json) => _$CityClusterModelFromJson(json);

@override final  String city;
@override final  int count;
@override final  double lat;
@override final  double lng;
@override final  int minPay;
@override final  int maxPay;

/// Create a copy of CityClusterModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityClusterModelCopyWith<_CityClusterModel> get copyWith => __$CityClusterModelCopyWithImpl<_CityClusterModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CityClusterModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CityClusterModel&&(identical(other.city, city) || other.city == city)&&(identical(other.count, count) || other.count == count)&&(identical(other.lat, lat) || other.lat == lat)&&(identical(other.lng, lng) || other.lng == lng)&&(identical(other.minPay, minPay) || other.minPay == minPay)&&(identical(other.maxPay, maxPay) || other.maxPay == maxPay));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,city,count,lat,lng,minPay,maxPay);

@override
String toString() {
  return 'CityClusterModel(city: $city, count: $count, lat: $lat, lng: $lng, minPay: $minPay, maxPay: $maxPay)';
}


}

/// @nodoc
abstract mixin class _$CityClusterModelCopyWith<$Res> implements $CityClusterModelCopyWith<$Res> {
  factory _$CityClusterModelCopyWith(_CityClusterModel value, $Res Function(_CityClusterModel) _then) = __$CityClusterModelCopyWithImpl;
@override @useResult
$Res call({
 String city, int count, double lat, double lng, int minPay, int maxPay
});




}
/// @nodoc
class __$CityClusterModelCopyWithImpl<$Res>
    implements _$CityClusterModelCopyWith<$Res> {
  __$CityClusterModelCopyWithImpl(this._self, this._then);

  final _CityClusterModel _self;
  final $Res Function(_CityClusterModel) _then;

/// Create a copy of CityClusterModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? city = null,Object? count = null,Object? lat = null,Object? lng = null,Object? minPay = null,Object? maxPay = null,}) {
  return _then(_CityClusterModel(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,lat: null == lat ? _self.lat : lat // ignore: cast_nullable_to_non_nullable
as double,lng: null == lng ? _self.lng : lng // ignore: cast_nullable_to_non_nullable
as double,minPay: null == minPay ? _self.minPay : minPay // ignore: cast_nullable_to_non_nullable
as int,maxPay: null == maxPay ? _self.maxPay : maxPay // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
