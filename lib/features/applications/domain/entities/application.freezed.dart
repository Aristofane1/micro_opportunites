// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'application.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Application {

 String get id; String get missionId; ApplicationStatus get status; String get message; DateTime get createdAt; DateTime? get offerExpiresAt; String? get assignmentId; ApplicationMission get mission;
/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationCopyWith<Application> get copyWith => _$ApplicationCopyWithImpl<Application>(this as Application, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Application&&(identical(other.id, id) || other.id == id)&&(identical(other.missionId, missionId) || other.missionId == missionId)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.offerExpiresAt, offerExpiresAt) || other.offerExpiresAt == offerExpiresAt)&&(identical(other.assignmentId, assignmentId) || other.assignmentId == assignmentId)&&(identical(other.mission, mission) || other.mission == mission));
}


@override
int get hashCode => Object.hash(runtimeType,id,missionId,status,message,createdAt,offerExpiresAt,assignmentId,mission);

@override
String toString() {
  return 'Application(id: $id, missionId: $missionId, status: $status, message: $message, createdAt: $createdAt, offerExpiresAt: $offerExpiresAt, assignmentId: $assignmentId, mission: $mission)';
}


}

/// @nodoc
abstract mixin class $ApplicationCopyWith<$Res>  {
  factory $ApplicationCopyWith(Application value, $Res Function(Application) _then) = _$ApplicationCopyWithImpl;
@useResult
$Res call({
 String id, String missionId, ApplicationStatus status, String message, DateTime createdAt, DateTime? offerExpiresAt, String? assignmentId, ApplicationMission mission
});


$ApplicationMissionCopyWith<$Res> get mission;

}
/// @nodoc
class _$ApplicationCopyWithImpl<$Res>
    implements $ApplicationCopyWith<$Res> {
  _$ApplicationCopyWithImpl(this._self, this._then);

  final Application _self;
  final $Res Function(Application) _then;

/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? missionId = null,Object? status = null,Object? message = null,Object? createdAt = null,Object? offerExpiresAt = freezed,Object? assignmentId = freezed,Object? mission = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,missionId: null == missionId ? _self.missionId : missionId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,offerExpiresAt: freezed == offerExpiresAt ? _self.offerExpiresAt : offerExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,assignmentId: freezed == assignmentId ? _self.assignmentId : assignmentId // ignore: cast_nullable_to_non_nullable
as String?,mission: null == mission ? _self.mission : mission // ignore: cast_nullable_to_non_nullable
as ApplicationMission,
  ));
}
/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplicationMissionCopyWith<$Res> get mission {
  
  return $ApplicationMissionCopyWith<$Res>(_self.mission, (value) {
    return _then(_self.copyWith(mission: value));
  });
}
}


/// Adds pattern-matching-related methods to [Application].
extension ApplicationPatterns on Application {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Application value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Application() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Application value)  $default,){
final _that = this;
switch (_that) {
case _Application():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Application value)?  $default,){
final _that = this;
switch (_that) {
case _Application() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String missionId,  ApplicationStatus status,  String message,  DateTime createdAt,  DateTime? offerExpiresAt,  String? assignmentId,  ApplicationMission mission)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Application() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String missionId,  ApplicationStatus status,  String message,  DateTime createdAt,  DateTime? offerExpiresAt,  String? assignmentId,  ApplicationMission mission)  $default,) {final _that = this;
switch (_that) {
case _Application():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String missionId,  ApplicationStatus status,  String message,  DateTime createdAt,  DateTime? offerExpiresAt,  String? assignmentId,  ApplicationMission mission)?  $default,) {final _that = this;
switch (_that) {
case _Application() when $default != null:
return $default(_that.id,_that.missionId,_that.status,_that.message,_that.createdAt,_that.offerExpiresAt,_that.assignmentId,_that.mission);case _:
  return null;

}
}

}

/// @nodoc


class _Application implements Application {
  const _Application({required this.id, required this.missionId, required this.status, required this.message, required this.createdAt, this.offerExpiresAt, this.assignmentId, required this.mission});
  

@override final  String id;
@override final  String missionId;
@override final  ApplicationStatus status;
@override final  String message;
@override final  DateTime createdAt;
@override final  DateTime? offerExpiresAt;
@override final  String? assignmentId;
@override final  ApplicationMission mission;

/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationCopyWith<_Application> get copyWith => __$ApplicationCopyWithImpl<_Application>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Application&&(identical(other.id, id) || other.id == id)&&(identical(other.missionId, missionId) || other.missionId == missionId)&&(identical(other.status, status) || other.status == status)&&(identical(other.message, message) || other.message == message)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.offerExpiresAt, offerExpiresAt) || other.offerExpiresAt == offerExpiresAt)&&(identical(other.assignmentId, assignmentId) || other.assignmentId == assignmentId)&&(identical(other.mission, mission) || other.mission == mission));
}


@override
int get hashCode => Object.hash(runtimeType,id,missionId,status,message,createdAt,offerExpiresAt,assignmentId,mission);

@override
String toString() {
  return 'Application(id: $id, missionId: $missionId, status: $status, message: $message, createdAt: $createdAt, offerExpiresAt: $offerExpiresAt, assignmentId: $assignmentId, mission: $mission)';
}


}

/// @nodoc
abstract mixin class _$ApplicationCopyWith<$Res> implements $ApplicationCopyWith<$Res> {
  factory _$ApplicationCopyWith(_Application value, $Res Function(_Application) _then) = __$ApplicationCopyWithImpl;
@override @useResult
$Res call({
 String id, String missionId, ApplicationStatus status, String message, DateTime createdAt, DateTime? offerExpiresAt, String? assignmentId, ApplicationMission mission
});


@override $ApplicationMissionCopyWith<$Res> get mission;

}
/// @nodoc
class __$ApplicationCopyWithImpl<$Res>
    implements _$ApplicationCopyWith<$Res> {
  __$ApplicationCopyWithImpl(this._self, this._then);

  final _Application _self;
  final $Res Function(_Application) _then;

/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? missionId = null,Object? status = null,Object? message = null,Object? createdAt = null,Object? offerExpiresAt = freezed,Object? assignmentId = freezed,Object? mission = null,}) {
  return _then(_Application(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,missionId: null == missionId ? _self.missionId : missionId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,offerExpiresAt: freezed == offerExpiresAt ? _self.offerExpiresAt : offerExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,assignmentId: freezed == assignmentId ? _self.assignmentId : assignmentId // ignore: cast_nullable_to_non_nullable
as String?,mission: null == mission ? _self.mission : mission // ignore: cast_nullable_to_non_nullable
as ApplicationMission,
  ));
}

/// Create a copy of Application
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplicationMissionCopyWith<$Res> get mission {
  
  return $ApplicationMissionCopyWith<$Res>(_self.mission, (value) {
    return _then(_self.copyWith(mission: value));
  });
}
}

/// @nodoc
mixin _$ApplicationMission {

 String get title; String get city; DateTime get startAt; int get durationMinutes; int get payAmount; String get posterName; double get posterRating; bool get posterVerified;
/// Create a copy of ApplicationMission
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationMissionCopyWith<ApplicationMission> get copyWith => _$ApplicationMissionCopyWithImpl<ApplicationMission>(this as ApplicationMission, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationMission&&(identical(other.title, title) || other.title == title)&&(identical(other.city, city) || other.city == city)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.posterName, posterName) || other.posterName == posterName)&&(identical(other.posterRating, posterRating) || other.posterRating == posterRating)&&(identical(other.posterVerified, posterVerified) || other.posterVerified == posterVerified));
}


@override
int get hashCode => Object.hash(runtimeType,title,city,startAt,durationMinutes,payAmount,posterName,posterRating,posterVerified);

@override
String toString() {
  return 'ApplicationMission(title: $title, city: $city, startAt: $startAt, durationMinutes: $durationMinutes, payAmount: $payAmount, posterName: $posterName, posterRating: $posterRating, posterVerified: $posterVerified)';
}


}

/// @nodoc
abstract mixin class $ApplicationMissionCopyWith<$Res>  {
  factory $ApplicationMissionCopyWith(ApplicationMission value, $Res Function(ApplicationMission) _then) = _$ApplicationMissionCopyWithImpl;
@useResult
$Res call({
 String title, String city, DateTime startAt, int durationMinutes, int payAmount, String posterName, double posterRating, bool posterVerified
});




}
/// @nodoc
class _$ApplicationMissionCopyWithImpl<$Res>
    implements $ApplicationMissionCopyWith<$Res> {
  _$ApplicationMissionCopyWithImpl(this._self, this._then);

  final ApplicationMission _self;
  final $Res Function(ApplicationMission) _then;

/// Create a copy of ApplicationMission
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? city = null,Object? startAt = null,Object? durationMinutes = null,Object? payAmount = null,Object? posterName = null,Object? posterRating = null,Object? posterVerified = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,payAmount: null == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int,posterName: null == posterName ? _self.posterName : posterName // ignore: cast_nullable_to_non_nullable
as String,posterRating: null == posterRating ? _self.posterRating : posterRating // ignore: cast_nullable_to_non_nullable
as double,posterVerified: null == posterVerified ? _self.posterVerified : posterVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ApplicationMission].
extension ApplicationMissionPatterns on ApplicationMission {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplicationMission value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplicationMission() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplicationMission value)  $default,){
final _that = this;
switch (_that) {
case _ApplicationMission():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplicationMission value)?  $default,){
final _that = this;
switch (_that) {
case _ApplicationMission() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String city,  DateTime startAt,  int durationMinutes,  int payAmount,  String posterName,  double posterRating,  bool posterVerified)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplicationMission() when $default != null:
return $default(_that.title,_that.city,_that.startAt,_that.durationMinutes,_that.payAmount,_that.posterName,_that.posterRating,_that.posterVerified);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String city,  DateTime startAt,  int durationMinutes,  int payAmount,  String posterName,  double posterRating,  bool posterVerified)  $default,) {final _that = this;
switch (_that) {
case _ApplicationMission():
return $default(_that.title,_that.city,_that.startAt,_that.durationMinutes,_that.payAmount,_that.posterName,_that.posterRating,_that.posterVerified);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String city,  DateTime startAt,  int durationMinutes,  int payAmount,  String posterName,  double posterRating,  bool posterVerified)?  $default,) {final _that = this;
switch (_that) {
case _ApplicationMission() when $default != null:
return $default(_that.title,_that.city,_that.startAt,_that.durationMinutes,_that.payAmount,_that.posterName,_that.posterRating,_that.posterVerified);case _:
  return null;

}
}

}

/// @nodoc


class _ApplicationMission extends ApplicationMission {
  const _ApplicationMission({required this.title, required this.city, required this.startAt, required this.durationMinutes, required this.payAmount, required this.posterName, required this.posterRating, required this.posterVerified}): super._();
  

@override final  String title;
@override final  String city;
@override final  DateTime startAt;
@override final  int durationMinutes;
@override final  int payAmount;
@override final  String posterName;
@override final  double posterRating;
@override final  bool posterVerified;

/// Create a copy of ApplicationMission
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationMissionCopyWith<_ApplicationMission> get copyWith => __$ApplicationMissionCopyWithImpl<_ApplicationMission>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplicationMission&&(identical(other.title, title) || other.title == title)&&(identical(other.city, city) || other.city == city)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.posterName, posterName) || other.posterName == posterName)&&(identical(other.posterRating, posterRating) || other.posterRating == posterRating)&&(identical(other.posterVerified, posterVerified) || other.posterVerified == posterVerified));
}


@override
int get hashCode => Object.hash(runtimeType,title,city,startAt,durationMinutes,payAmount,posterName,posterRating,posterVerified);

@override
String toString() {
  return 'ApplicationMission(title: $title, city: $city, startAt: $startAt, durationMinutes: $durationMinutes, payAmount: $payAmount, posterName: $posterName, posterRating: $posterRating, posterVerified: $posterVerified)';
}


}

/// @nodoc
abstract mixin class _$ApplicationMissionCopyWith<$Res> implements $ApplicationMissionCopyWith<$Res> {
  factory _$ApplicationMissionCopyWith(_ApplicationMission value, $Res Function(_ApplicationMission) _then) = __$ApplicationMissionCopyWithImpl;
@override @useResult
$Res call({
 String title, String city, DateTime startAt, int durationMinutes, int payAmount, String posterName, double posterRating, bool posterVerified
});




}
/// @nodoc
class __$ApplicationMissionCopyWithImpl<$Res>
    implements _$ApplicationMissionCopyWith<$Res> {
  __$ApplicationMissionCopyWithImpl(this._self, this._then);

  final _ApplicationMission _self;
  final $Res Function(_ApplicationMission) _then;

/// Create a copy of ApplicationMission
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? city = null,Object? startAt = null,Object? durationMinutes = null,Object? payAmount = null,Object? posterName = null,Object? posterRating = null,Object? posterVerified = null,}) {
  return _then(_ApplicationMission(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,payAmount: null == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int,posterName: null == posterName ? _self.posterName : posterName // ignore: cast_nullable_to_non_nullable
as String,posterRating: null == posterRating ? _self.posterRating : posterRating // ignore: cast_nullable_to_non_nullable
as double,posterVerified: null == posterVerified ? _self.posterVerified : posterVerified // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
