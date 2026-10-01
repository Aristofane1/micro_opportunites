// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'current_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CurrentUserModel {

 String get id; String get firstName; String get city;
/// Create a copy of CurrentUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CurrentUserModelCopyWith<CurrentUserModel> get copyWith => _$CurrentUserModelCopyWithImpl<CurrentUserModel>(this as CurrentUserModel, _$identity);

  /// Serializes this CurrentUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CurrentUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.city, city) || other.city == city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,city);

@override
String toString() {
  return 'CurrentUserModel(id: $id, firstName: $firstName, city: $city)';
}


}

/// @nodoc
abstract mixin class $CurrentUserModelCopyWith<$Res>  {
  factory $CurrentUserModelCopyWith(CurrentUserModel value, $Res Function(CurrentUserModel) _then) = _$CurrentUserModelCopyWithImpl;
@useResult
$Res call({
 String id, String firstName, String city
});




}
/// @nodoc
class _$CurrentUserModelCopyWithImpl<$Res>
    implements $CurrentUserModelCopyWith<$Res> {
  _$CurrentUserModelCopyWithImpl(this._self, this._then);

  final CurrentUserModel _self;
  final $Res Function(CurrentUserModel) _then;

/// Create a copy of CurrentUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? firstName = null,Object? city = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CurrentUserModel].
extension CurrentUserModelPatterns on CurrentUserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CurrentUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CurrentUserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CurrentUserModel value)  $default,){
final _that = this;
switch (_that) {
case _CurrentUserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CurrentUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _CurrentUserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String firstName,  String city)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CurrentUserModel() when $default != null:
return $default(_that.id,_that.firstName,_that.city);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String firstName,  String city)  $default,) {final _that = this;
switch (_that) {
case _CurrentUserModel():
return $default(_that.id,_that.firstName,_that.city);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String firstName,  String city)?  $default,) {final _that = this;
switch (_that) {
case _CurrentUserModel() when $default != null:
return $default(_that.id,_that.firstName,_that.city);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CurrentUserModel extends CurrentUserModel {
  const _CurrentUserModel({required this.id, required this.firstName, required this.city}): super._();
  factory _CurrentUserModel.fromJson(Map<String, dynamic> json) => _$CurrentUserModelFromJson(json);

@override final  String id;
@override final  String firstName;
@override final  String city;

/// Create a copy of CurrentUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CurrentUserModelCopyWith<_CurrentUserModel> get copyWith => __$CurrentUserModelCopyWithImpl<_CurrentUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CurrentUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CurrentUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.city, city) || other.city == city));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,firstName,city);

@override
String toString() {
  return 'CurrentUserModel(id: $id, firstName: $firstName, city: $city)';
}


}

/// @nodoc
abstract mixin class _$CurrentUserModelCopyWith<$Res> implements $CurrentUserModelCopyWith<$Res> {
  factory _$CurrentUserModelCopyWith(_CurrentUserModel value, $Res Function(_CurrentUserModel) _then) = __$CurrentUserModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String firstName, String city
});




}
/// @nodoc
class __$CurrentUserModelCopyWithImpl<$Res>
    implements _$CurrentUserModelCopyWith<$Res> {
  __$CurrentUserModelCopyWithImpl(this._self, this._then);

  final _CurrentUserModel _self;
  final $Res Function(_CurrentUserModel) _then;

/// Create a copy of CurrentUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? firstName = null,Object? city = null,}) {
  return _then(_CurrentUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
