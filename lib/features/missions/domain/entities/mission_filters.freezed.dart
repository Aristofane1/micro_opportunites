// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_filters.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MissionFilters {

 int get radiusKm; Set<MissionCategory> get categories; int? get minPay; MissionPeriod get period; bool get multiSlotsOnly; String? get city; String? get query;
/// Create a copy of MissionFilters
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissionFiltersCopyWith<MissionFilters> get copyWith => _$MissionFiltersCopyWithImpl<MissionFilters>(this as MissionFilters, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissionFilters&&(identical(other.radiusKm, radiusKm) || other.radiusKm == radiusKm)&&const DeepCollectionEquality().equals(other.categories, categories)&&(identical(other.minPay, minPay) || other.minPay == minPay)&&(identical(other.period, period) || other.period == period)&&(identical(other.multiSlotsOnly, multiSlotsOnly) || other.multiSlotsOnly == multiSlotsOnly)&&(identical(other.city, city) || other.city == city)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,radiusKm,const DeepCollectionEquality().hash(categories),minPay,period,multiSlotsOnly,city,query);

@override
String toString() {
  return 'MissionFilters(radiusKm: $radiusKm, categories: $categories, minPay: $minPay, period: $period, multiSlotsOnly: $multiSlotsOnly, city: $city, query: $query)';
}


}

/// @nodoc
abstract mixin class $MissionFiltersCopyWith<$Res>  {
  factory $MissionFiltersCopyWith(MissionFilters value, $Res Function(MissionFilters) _then) = _$MissionFiltersCopyWithImpl;
@useResult
$Res call({
 int radiusKm, Set<MissionCategory> categories, int? minPay, MissionPeriod period, bool multiSlotsOnly, String? city, String? query
});




}
/// @nodoc
class _$MissionFiltersCopyWithImpl<$Res>
    implements $MissionFiltersCopyWith<$Res> {
  _$MissionFiltersCopyWithImpl(this._self, this._then);

  final MissionFilters _self;
  final $Res Function(MissionFilters) _then;

/// Create a copy of MissionFilters
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? radiusKm = null,Object? categories = null,Object? minPay = freezed,Object? period = null,Object? multiSlotsOnly = null,Object? city = freezed,Object? query = freezed,}) {
  return _then(_self.copyWith(
radiusKm: null == radiusKm ? _self.radiusKm : radiusKm // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as Set<MissionCategory>,minPay: freezed == minPay ? _self.minPay : minPay // ignore: cast_nullable_to_non_nullable
as int?,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as MissionPeriod,multiSlotsOnly: null == multiSlotsOnly ? _self.multiSlotsOnly : multiSlotsOnly // ignore: cast_nullable_to_non_nullable
as bool,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MissionFilters].
extension MissionFiltersPatterns on MissionFilters {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MissionFilters value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MissionFilters() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MissionFilters value)  $default,){
final _that = this;
switch (_that) {
case _MissionFilters():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MissionFilters value)?  $default,){
final _that = this;
switch (_that) {
case _MissionFilters() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int radiusKm,  Set<MissionCategory> categories,  int? minPay,  MissionPeriod period,  bool multiSlotsOnly,  String? city,  String? query)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MissionFilters() when $default != null:
return $default(_that.radiusKm,_that.categories,_that.minPay,_that.period,_that.multiSlotsOnly,_that.city,_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int radiusKm,  Set<MissionCategory> categories,  int? minPay,  MissionPeriod period,  bool multiSlotsOnly,  String? city,  String? query)  $default,) {final _that = this;
switch (_that) {
case _MissionFilters():
return $default(_that.radiusKm,_that.categories,_that.minPay,_that.period,_that.multiSlotsOnly,_that.city,_that.query);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int radiusKm,  Set<MissionCategory> categories,  int? minPay,  MissionPeriod period,  bool multiSlotsOnly,  String? city,  String? query)?  $default,) {final _that = this;
switch (_that) {
case _MissionFilters() when $default != null:
return $default(_that.radiusKm,_that.categories,_that.minPay,_that.period,_that.multiSlotsOnly,_that.city,_that.query);case _:
  return null;

}
}

}

/// @nodoc


class _MissionFilters extends MissionFilters {
  const _MissionFilters({this.radiusKm = 5, final  Set<MissionCategory> categories = const <MissionCategory>{}, this.minPay, this.period = MissionPeriod.all, this.multiSlotsOnly = false, this.city, this.query}): _categories = categories,super._();
  

@override@JsonKey() final  int radiusKm;
 final  Set<MissionCategory> _categories;
@override@JsonKey() Set<MissionCategory> get categories {
  if (_categories is EqualUnmodifiableSetView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_categories);
}

@override final  int? minPay;
@override@JsonKey() final  MissionPeriod period;
@override@JsonKey() final  bool multiSlotsOnly;
@override final  String? city;
@override final  String? query;

/// Create a copy of MissionFilters
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissionFiltersCopyWith<_MissionFilters> get copyWith => __$MissionFiltersCopyWithImpl<_MissionFilters>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissionFilters&&(identical(other.radiusKm, radiusKm) || other.radiusKm == radiusKm)&&const DeepCollectionEquality().equals(other._categories, _categories)&&(identical(other.minPay, minPay) || other.minPay == minPay)&&(identical(other.period, period) || other.period == period)&&(identical(other.multiSlotsOnly, multiSlotsOnly) || other.multiSlotsOnly == multiSlotsOnly)&&(identical(other.city, city) || other.city == city)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,radiusKm,const DeepCollectionEquality().hash(_categories),minPay,period,multiSlotsOnly,city,query);

@override
String toString() {
  return 'MissionFilters(radiusKm: $radiusKm, categories: $categories, minPay: $minPay, period: $period, multiSlotsOnly: $multiSlotsOnly, city: $city, query: $query)';
}


}

/// @nodoc
abstract mixin class _$MissionFiltersCopyWith<$Res> implements $MissionFiltersCopyWith<$Res> {
  factory _$MissionFiltersCopyWith(_MissionFilters value, $Res Function(_MissionFilters) _then) = __$MissionFiltersCopyWithImpl;
@override @useResult
$Res call({
 int radiusKm, Set<MissionCategory> categories, int? minPay, MissionPeriod period, bool multiSlotsOnly, String? city, String? query
});




}
/// @nodoc
class __$MissionFiltersCopyWithImpl<$Res>
    implements _$MissionFiltersCopyWith<$Res> {
  __$MissionFiltersCopyWithImpl(this._self, this._then);

  final _MissionFilters _self;
  final $Res Function(_MissionFilters) _then;

/// Create a copy of MissionFilters
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? radiusKm = null,Object? categories = null,Object? minPay = freezed,Object? period = null,Object? multiSlotsOnly = null,Object? city = freezed,Object? query = freezed,}) {
  return _then(_MissionFilters(
radiusKm: null == radiusKm ? _self.radiusKm : radiusKm // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as Set<MissionCategory>,minPay: freezed == minPay ? _self.minPay : minPay // ignore: cast_nullable_to_non_nullable
as int?,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as MissionPeriod,multiSlotsOnly: null == multiSlotsOnly ? _self.multiSlotsOnly : multiSlotsOnly // ignore: cast_nullable_to_non_nullable
as bool,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,query: freezed == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
