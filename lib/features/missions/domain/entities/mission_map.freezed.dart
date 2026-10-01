// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_map.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CityCluster {

 String get city; int get count; double get latitude; double get longitude; int get minPay; int get maxPay;
/// Create a copy of CityCluster
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CityClusterCopyWith<CityCluster> get copyWith => _$CityClusterCopyWithImpl<CityCluster>(this as CityCluster, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CityCluster&&(identical(other.city, city) || other.city == city)&&(identical(other.count, count) || other.count == count)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.minPay, minPay) || other.minPay == minPay)&&(identical(other.maxPay, maxPay) || other.maxPay == maxPay));
}


@override
int get hashCode => Object.hash(runtimeType,city,count,latitude,longitude,minPay,maxPay);

@override
String toString() {
  return 'CityCluster(city: $city, count: $count, latitude: $latitude, longitude: $longitude, minPay: $minPay, maxPay: $maxPay)';
}


}

/// @nodoc
abstract mixin class $CityClusterCopyWith<$Res>  {
  factory $CityClusterCopyWith(CityCluster value, $Res Function(CityCluster) _then) = _$CityClusterCopyWithImpl;
@useResult
$Res call({
 String city, int count, double latitude, double longitude, int minPay, int maxPay
});




}
/// @nodoc
class _$CityClusterCopyWithImpl<$Res>
    implements $CityClusterCopyWith<$Res> {
  _$CityClusterCopyWithImpl(this._self, this._then);

  final CityCluster _self;
  final $Res Function(CityCluster) _then;

/// Create a copy of CityCluster
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? city = null,Object? count = null,Object? latitude = null,Object? longitude = null,Object? minPay = null,Object? maxPay = null,}) {
  return _then(_self.copyWith(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,minPay: null == minPay ? _self.minPay : minPay // ignore: cast_nullable_to_non_nullable
as int,maxPay: null == maxPay ? _self.maxPay : maxPay // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CityCluster].
extension CityClusterPatterns on CityCluster {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CityCluster value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CityCluster() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CityCluster value)  $default,){
final _that = this;
switch (_that) {
case _CityCluster():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CityCluster value)?  $default,){
final _that = this;
switch (_that) {
case _CityCluster() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String city,  int count,  double latitude,  double longitude,  int minPay,  int maxPay)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CityCluster() when $default != null:
return $default(_that.city,_that.count,_that.latitude,_that.longitude,_that.minPay,_that.maxPay);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String city,  int count,  double latitude,  double longitude,  int minPay,  int maxPay)  $default,) {final _that = this;
switch (_that) {
case _CityCluster():
return $default(_that.city,_that.count,_that.latitude,_that.longitude,_that.minPay,_that.maxPay);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String city,  int count,  double latitude,  double longitude,  int minPay,  int maxPay)?  $default,) {final _that = this;
switch (_that) {
case _CityCluster() when $default != null:
return $default(_that.city,_that.count,_that.latitude,_that.longitude,_that.minPay,_that.maxPay);case _:
  return null;

}
}

}

/// @nodoc


class _CityCluster implements CityCluster {
  const _CityCluster({required this.city, required this.count, required this.latitude, required this.longitude, required this.minPay, required this.maxPay});
  

@override final  String city;
@override final  int count;
@override final  double latitude;
@override final  double longitude;
@override final  int minPay;
@override final  int maxPay;

/// Create a copy of CityCluster
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CityClusterCopyWith<_CityCluster> get copyWith => __$CityClusterCopyWithImpl<_CityCluster>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CityCluster&&(identical(other.city, city) || other.city == city)&&(identical(other.count, count) || other.count == count)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.minPay, minPay) || other.minPay == minPay)&&(identical(other.maxPay, maxPay) || other.maxPay == maxPay));
}


@override
int get hashCode => Object.hash(runtimeType,city,count,latitude,longitude,minPay,maxPay);

@override
String toString() {
  return 'CityCluster(city: $city, count: $count, latitude: $latitude, longitude: $longitude, minPay: $minPay, maxPay: $maxPay)';
}


}

/// @nodoc
abstract mixin class _$CityClusterCopyWith<$Res> implements $CityClusterCopyWith<$Res> {
  factory _$CityClusterCopyWith(_CityCluster value, $Res Function(_CityCluster) _then) = __$CityClusterCopyWithImpl;
@override @useResult
$Res call({
 String city, int count, double latitude, double longitude, int minPay, int maxPay
});




}
/// @nodoc
class __$CityClusterCopyWithImpl<$Res>
    implements _$CityClusterCopyWith<$Res> {
  __$CityClusterCopyWithImpl(this._self, this._then);

  final _CityCluster _self;
  final $Res Function(_CityCluster) _then;

/// Create a copy of CityCluster
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? city = null,Object? count = null,Object? latitude = null,Object? longitude = null,Object? minPay = null,Object? maxPay = null,}) {
  return _then(_CityCluster(
city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,minPay: null == minPay ? _self.minPay : minPay // ignore: cast_nullable_to_non_nullable
as int,maxPay: null == maxPay ? _self.maxPay : maxPay // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$MissionMap {

 List<CityCluster> get clusters; double get userLatitude; double get userLongitude;
/// Create a copy of MissionMap
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissionMapCopyWith<MissionMap> get copyWith => _$MissionMapCopyWithImpl<MissionMap>(this as MissionMap, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissionMap&&const DeepCollectionEquality().equals(other.clusters, clusters)&&(identical(other.userLatitude, userLatitude) || other.userLatitude == userLatitude)&&(identical(other.userLongitude, userLongitude) || other.userLongitude == userLongitude));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(clusters),userLatitude,userLongitude);

@override
String toString() {
  return 'MissionMap(clusters: $clusters, userLatitude: $userLatitude, userLongitude: $userLongitude)';
}


}

/// @nodoc
abstract mixin class $MissionMapCopyWith<$Res>  {
  factory $MissionMapCopyWith(MissionMap value, $Res Function(MissionMap) _then) = _$MissionMapCopyWithImpl;
@useResult
$Res call({
 List<CityCluster> clusters, double userLatitude, double userLongitude
});




}
/// @nodoc
class _$MissionMapCopyWithImpl<$Res>
    implements $MissionMapCopyWith<$Res> {
  _$MissionMapCopyWithImpl(this._self, this._then);

  final MissionMap _self;
  final $Res Function(MissionMap) _then;

/// Create a copy of MissionMap
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clusters = null,Object? userLatitude = null,Object? userLongitude = null,}) {
  return _then(_self.copyWith(
clusters: null == clusters ? _self.clusters : clusters // ignore: cast_nullable_to_non_nullable
as List<CityCluster>,userLatitude: null == userLatitude ? _self.userLatitude : userLatitude // ignore: cast_nullable_to_non_nullable
as double,userLongitude: null == userLongitude ? _self.userLongitude : userLongitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [MissionMap].
extension MissionMapPatterns on MissionMap {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MissionMap value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MissionMap() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MissionMap value)  $default,){
final _that = this;
switch (_that) {
case _MissionMap():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MissionMap value)?  $default,){
final _that = this;
switch (_that) {
case _MissionMap() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<CityCluster> clusters,  double userLatitude,  double userLongitude)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MissionMap() when $default != null:
return $default(_that.clusters,_that.userLatitude,_that.userLongitude);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<CityCluster> clusters,  double userLatitude,  double userLongitude)  $default,) {final _that = this;
switch (_that) {
case _MissionMap():
return $default(_that.clusters,_that.userLatitude,_that.userLongitude);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<CityCluster> clusters,  double userLatitude,  double userLongitude)?  $default,) {final _that = this;
switch (_that) {
case _MissionMap() when $default != null:
return $default(_that.clusters,_that.userLatitude,_that.userLongitude);case _:
  return null;

}
}

}

/// @nodoc


class _MissionMap implements MissionMap {
  const _MissionMap({required final  List<CityCluster> clusters, required this.userLatitude, required this.userLongitude}): _clusters = clusters;
  

 final  List<CityCluster> _clusters;
@override List<CityCluster> get clusters {
  if (_clusters is EqualUnmodifiableListView) return _clusters;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_clusters);
}

@override final  double userLatitude;
@override final  double userLongitude;

/// Create a copy of MissionMap
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissionMapCopyWith<_MissionMap> get copyWith => __$MissionMapCopyWithImpl<_MissionMap>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissionMap&&const DeepCollectionEquality().equals(other._clusters, _clusters)&&(identical(other.userLatitude, userLatitude) || other.userLatitude == userLatitude)&&(identical(other.userLongitude, userLongitude) || other.userLongitude == userLongitude));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_clusters),userLatitude,userLongitude);

@override
String toString() {
  return 'MissionMap(clusters: $clusters, userLatitude: $userLatitude, userLongitude: $userLongitude)';
}


}

/// @nodoc
abstract mixin class _$MissionMapCopyWith<$Res> implements $MissionMapCopyWith<$Res> {
  factory _$MissionMapCopyWith(_MissionMap value, $Res Function(_MissionMap) _then) = __$MissionMapCopyWithImpl;
@override @useResult
$Res call({
 List<CityCluster> clusters, double userLatitude, double userLongitude
});




}
/// @nodoc
class __$MissionMapCopyWithImpl<$Res>
    implements _$MissionMapCopyWith<$Res> {
  __$MissionMapCopyWithImpl(this._self, this._then);

  final _MissionMap _self;
  final $Res Function(_MissionMap) _then;

/// Create a copy of MissionMap
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clusters = null,Object? userLatitude = null,Object? userLongitude = null,}) {
  return _then(_MissionMap(
clusters: null == clusters ? _self._clusters : clusters // ignore: cast_nullable_to_non_nullable
as List<CityCluster>,userLatitude: null == userLatitude ? _self.userLatitude : userLatitude // ignore: cast_nullable_to_non_nullable
as double,userLongitude: null == userLongitude ? _self.userLongitude : userLongitude // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
