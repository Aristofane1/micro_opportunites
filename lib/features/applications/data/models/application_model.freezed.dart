// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ApplicationModel {

 String get id; String get missionId; String get status; String get message; String get createdAt; String? get offerExpiresAt; String? get assignmentId; ApplicationMissionModel get mission;
/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationModelCopyWith<ApplicationModel> get copyWith => _$ApplicationModelCopyWithImpl<ApplicationModel>(this as ApplicationModel, _$identity);

  /// Serializes this ApplicationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.missionId, missionId) || other.missionId == missionId)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.offerExpiresAt, offerExpiresAt) || other.offerExpiresAt == offerExpiresAt)&&(identical(other.assignmentId, assignmentId) || other.assignmentId == assignmentId)&&(identical(other.mission, mission) || other.mission == mission));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,missionId,status,message,createdAt,offerExpiresAt,assignmentId,mission);

@override
String toString() {
  return 'ApplicationModel(id: $id, missionId: $missionId, status: $status, message: $message, createdAt: $createdAt, offerExpiresAt: $offerExpiresAt, assignmentId: $assignmentId, mission: $mission)';
}


}

/// @nodoc
abstract mixin class $ApplicationModelCopyWith<$Res>  {
  factory $ApplicationModelCopyWith(ApplicationModel value, $Res Function(ApplicationModel) _then) = _$ApplicationModelCopyWithImpl;
@useResult
$Res call({
 String id, String missionId, String status, String message, String createdAt, String? offerExpiresAt, String? assignmentId, ApplicationMissionModel mission
});


$ApplicationMissionModelCopyWith<$Res> get mission;

}
/// @nodoc
class _$ApplicationModelCopyWithImpl<$Res>
    implements $ApplicationModelCopyWith<$Res> {
  _$ApplicationModelCopyWithImpl(this._self, this._then);

  final ApplicationModel _self;
  final $Res Function(ApplicationModel) _then;

/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? missionId = null,Object? status = null,Object? message = null,Object? createdAt = null,Object? offerExpiresAt = freezed,Object? assignmentId = freezed,Object? mission = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,missionId: null == missionId ? _self.missionId : missionId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,offerExpiresAt: freezed == offerExpiresAt ? _self.offerExpiresAt : offerExpiresAt // ignore: cast_nullable_to_non_nullable
as String?,assignmentId: freezed == assignmentId ? _self.assignmentId : assignmentId // ignore: cast_nullable_to_non_nullable
as String?,mission: null == mission ? _self.mission : mission // ignore: cast_nullable_to_non_nullable
as ApplicationMissionModel,
  ));
}
/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplicationMissionModelCopyWith<$Res> get mission {
  
  return $ApplicationMissionModelCopyWith<$Res>(_self.mission, (value) {
    return _then(_self.copyWith(mission: value));
  });
}
}


/// Adds pattern-matching-related methods to [ApplicationModel].
extension ApplicationModelPatterns on ApplicationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplicationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplicationModel value)  $default,){
final _that = this;
switch (_that) {
case _ApplicationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplicationModel value)?  $default,){
final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String missionId,  String status,  String message,  String createdAt,  String? offerExpiresAt,  String? assignmentId,  ApplicationMissionModel mission)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
return $default(_that.id,_that.missionId,_that.status,_that.message,_that.createdAt,_that.offerExpiresAt,_that.assignmentId,_that.mission);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String missionId,  String status,  String message,  String createdAt,  String? offerExpiresAt,  String? assignmentId,  ApplicationMissionModel mission)  $default,) {final _that = this;
switch (_that) {
case _ApplicationModel():
return $default(_that.id,_that.missionId,_that.status,_that.message,_that.createdAt,_that.offerExpiresAt,_that.assignmentId,_that.mission);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String missionId,  String status,  String message,  String createdAt,  String? offerExpiresAt,  String? assignmentId,  ApplicationMissionModel mission)?  $default,) {final _that = this;
switch (_that) {
case _ApplicationModel() when $default != null:
return $default(_that.id,_that.missionId,_that.status,_that.message,_that.createdAt,_that.offerExpiresAt,_that.assignmentId,_that.mission);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApplicationModel extends ApplicationModel {
  const _ApplicationModel({required this.id, required this.missionId, required this.status, required this.message, required this.createdAt, this.offerExpiresAt, this.assignmentId, required this.mission}): super._();
  factory _ApplicationModel.fromJson(Map<String, dynamic> json) => _$ApplicationModelFromJson(json);

@override final  String id;
@override final  String missionId;
@override final  String status;
@override final  String message;
@override final  String createdAt;
@override final  String? offerExpiresAt;
@override final  String? assignmentId;
@override final  ApplicationMissionModel mission;

/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationModelCopyWith<_ApplicationModel> get copyWith => __$ApplicationModelCopyWithImpl<_ApplicationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApplicationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplicationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.missionId, missionId) || other.missionId == missionId)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.offerExpiresAt, offerExpiresAt) || other.offerExpiresAt == offerExpiresAt)&&(identical(other.assignmentId, assignmentId) || other.assignmentId == assignmentId)&&(identical(other.mission, mission) || other.mission == mission));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,missionId,status,message,createdAt,offerExpiresAt,assignmentId,mission);

@override
String toString() {
  return 'ApplicationModel(id: $id, missionId: $missionId, status: $status, message: $message, createdAt: $createdAt, offerExpiresAt: $offerExpiresAt, assignmentId: $assignmentId, mission: $mission)';
}


}

/// @nodoc
abstract mixin class _$ApplicationModelCopyWith<$Res> implements $ApplicationModelCopyWith<$Res> {
  factory _$ApplicationModelCopyWith(_ApplicationModel value, $Res Function(_ApplicationModel) _then) = __$ApplicationModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String missionId, String status, String message, String createdAt, String? offerExpiresAt, String? assignmentId, ApplicationMissionModel mission
});


@override $ApplicationMissionModelCopyWith<$Res> get mission;

}
/// @nodoc
class __$ApplicationModelCopyWithImpl<$Res>
    implements _$ApplicationModelCopyWith<$Res> {
  __$ApplicationModelCopyWithImpl(this._self, this._then);

  final _ApplicationModel _self;
  final $Res Function(_ApplicationModel) _then;

/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? missionId = null,Object? status = null,Object? message = null,Object? createdAt = null,Object? offerExpiresAt = freezed,Object? assignmentId = freezed,Object? mission = null,}) {
  return _then(_ApplicationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,missionId: null == missionId ? _self.missionId : missionId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,offerExpiresAt: freezed == offerExpiresAt ? _self.offerExpiresAt : offerExpiresAt // ignore: cast_nullable_to_non_nullable
as String?,assignmentId: freezed == assignmentId ? _self.assignmentId : assignmentId // ignore: cast_nullable_to_non_nullable
as String?,mission: null == mission ? _self.mission : mission // ignore: cast_nullable_to_non_nullable
as ApplicationMissionModel,
  ));
}

/// Create a copy of ApplicationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplicationMissionModelCopyWith<$Res> get mission {
  
  return $ApplicationMissionModelCopyWith<$Res>(_self.mission, (value) {
    return _then(_self.copyWith(mission: value));
  });
}
}


/// @nodoc
mixin _$ApplicationMissionModel {

 String get title; String get city; String get startAt; int get durationMin; int get payAmount; String get posterName; double get posterRating; bool get posterVerified;
/// Create a copy of ApplicationMissionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationMissionModelCopyWith<ApplicationMissionModel> get copyWith => _$ApplicationMissionModelCopyWithImpl<ApplicationMissionModel>(this as ApplicationMissionModel, _$identity);

  /// Serializes this ApplicationMissionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationMissionModel&&(identical(other.title, title) || other.title == title)&&(identical(other.city, city) || other.city == city)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMin, durationMin) || other.durationMin == durationMin)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.posterName, posterName) || other.posterName == posterName)&&(identical(other.posterRating, posterRating) || other.posterRating == posterRating)&&(identical(other.posterVerified, posterVerified) || other.posterVerified == posterVerified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,city,startAt,durationMin,payAmount,posterName,posterRating,posterVerified);

@override
String toString() {
  return 'ApplicationMissionModel(title: $title, city: $city, startAt: $startAt, durationMin: $durationMin, payAmount: $payAmount, posterName: $posterName, posterRating: $posterRating, posterVerified: $posterVerified)';
}


}

/// @nodoc
abstract mixin class $ApplicationMissionModelCopyWith<$Res>  {
  factory $ApplicationMissionModelCopyWith(ApplicationMissionModel value, $Res Function(ApplicationMissionModel) _then) = _$ApplicationMissionModelCopyWithImpl;
@useResult
$Res call({
 String title, String city, String startAt, int durationMin, int payAmount, String posterName, double posterRating, bool posterVerified
});




}
/// @nodoc
class _$ApplicationMissionModelCopyWithImpl<$Res>
    implements $ApplicationMissionModelCopyWith<$Res> {
  _$ApplicationMissionModelCopyWithImpl(this._self, this._then);

  final ApplicationMissionModel _self;
  final $Res Function(ApplicationMissionModel) _then;

/// Create a copy of ApplicationMissionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? city = null,Object? startAt = null,Object? durationMin = null,Object? payAmount = null,Object? posterName = null,Object? posterRating = null,Object? posterVerified = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String,durationMin: null == durationMin ? _self.durationMin : durationMin // ignore: cast_nullable_to_non_nullable
as int,payAmount: null == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int,posterName: null == posterName ? _self.posterName : posterName // ignore: cast_nullable_to_non_nullable
as String,posterRating: null == posterRating ? _self.posterRating : posterRating // ignore: cast_nullable_to_non_nullable
as double,posterVerified: null == posterVerified ? _self.posterVerified : posterVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ApplicationMissionModel].
extension ApplicationMissionModelPatterns on ApplicationMissionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplicationMissionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplicationMissionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplicationMissionModel value)  $default,){
final _that = this;
switch (_that) {
case _ApplicationMissionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplicationMissionModel value)?  $default,){
final _that = this;
switch (_that) {
case _ApplicationMissionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String city,  String startAt,  int durationMin,  int payAmount,  String posterName,  double posterRating,  bool posterVerified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplicationMissionModel() when $default != null:
return $default(_that.title,_that.city,_that.startAt,_that.durationMin,_that.payAmount,_that.posterName,_that.posterRating,_that.posterVerified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String city,  String startAt,  int durationMin,  int payAmount,  String posterName,  double posterRating,  bool posterVerified)  $default,) {final _that = this;
switch (_that) {
case _ApplicationMissionModel():
return $default(_that.title,_that.city,_that.startAt,_that.durationMin,_that.payAmount,_that.posterName,_that.posterRating,_that.posterVerified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String city,  String startAt,  int durationMin,  int payAmount,  String posterName,  double posterRating,  bool posterVerified)?  $default,) {final _that = this;
switch (_that) {
case _ApplicationMissionModel() when $default != null:
return $default(_that.title,_that.city,_that.startAt,_that.durationMin,_that.payAmount,_that.posterName,_that.posterRating,_that.posterVerified);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApplicationMissionModel extends ApplicationMissionModel {
  const _ApplicationMissionModel({required this.title, required this.city, required this.startAt, required this.durationMin, required this.payAmount, required this.posterName, required this.posterRating, required this.posterVerified}): super._();
  factory _ApplicationMissionModel.fromJson(Map<String, dynamic> json) => _$ApplicationMissionModelFromJson(json);

@override final  String title;
@override final  String city;
@override final  String startAt;
@override final  int durationMin;
@override final  int payAmount;
@override final  String posterName;
@override final  double posterRating;
@override final  bool posterVerified;

/// Create a copy of ApplicationMissionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationMissionModelCopyWith<_ApplicationMissionModel> get copyWith => __$ApplicationMissionModelCopyWithImpl<_ApplicationMissionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApplicationMissionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplicationMissionModel&&(identical(other.title, title) || other.title == title)&&(identical(other.city, city) || other.city == city)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMin, durationMin) || other.durationMin == durationMin)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.posterName, posterName) || other.posterName == posterName)&&(identical(other.posterRating, posterRating) || other.posterRating == posterRating)&&(identical(other.posterVerified, posterVerified) || other.posterVerified == posterVerified));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,city,startAt,durationMin,payAmount,posterName,posterRating,posterVerified);

@override
String toString() {
  return 'ApplicationMissionModel(title: $title, city: $city, startAt: $startAt, durationMin: $durationMin, payAmount: $payAmount, posterName: $posterName, posterRating: $posterRating, posterVerified: $posterVerified)';
}


}

/// @nodoc
abstract mixin class _$ApplicationMissionModelCopyWith<$Res> implements $ApplicationMissionModelCopyWith<$Res> {
  factory _$ApplicationMissionModelCopyWith(_ApplicationMissionModel value, $Res Function(_ApplicationMissionModel) _then) = __$ApplicationMissionModelCopyWithImpl;
@override @useResult
$Res call({
 String title, String city, String startAt, int durationMin, int payAmount, String posterName, double posterRating, bool posterVerified
});




}
/// @nodoc
class __$ApplicationMissionModelCopyWithImpl<$Res>
    implements _$ApplicationMissionModelCopyWith<$Res> {
  __$ApplicationMissionModelCopyWithImpl(this._self, this._then);

  final _ApplicationMissionModel _self;
  final $Res Function(_ApplicationMissionModel) _then;

/// Create a copy of ApplicationMissionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? city = null,Object? startAt = null,Object? durationMin = null,Object? payAmount = null,Object? posterName = null,Object? posterRating = null,Object? posterVerified = null,}) {
  return _then(_ApplicationMissionModel(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String,durationMin: null == durationMin ? _self.durationMin : durationMin // ignore: cast_nullable_to_non_nullable
as int,payAmount: null == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int,posterName: null == posterName ? _self.posterName : posterName // ignore: cast_nullable_to_non_nullable
as String,posterRating: null == posterRating ? _self.posterRating : posterRating // ignore: cast_nullable_to_non_nullable
as double,posterVerified: null == posterVerified ? _self.posterVerified : posterVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
