// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PhoneVerificationModel {

 String get requestId; String get demoCode; String get maskedPhone;
/// Create a copy of PhoneVerificationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PhoneVerificationModelCopyWith<PhoneVerificationModel> get copyWith => _$PhoneVerificationModelCopyWithImpl<PhoneVerificationModel>(this as PhoneVerificationModel, _$identity);

  /// Serializes this PhoneVerificationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PhoneVerificationModel&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.demoCode, demoCode) || other.demoCode == demoCode)&&(identical(other.maskedPhone, maskedPhone) || other.maskedPhone == maskedPhone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requestId,demoCode,maskedPhone);

@override
String toString() {
  return 'PhoneVerificationModel(requestId: $requestId, demoCode: $demoCode, maskedPhone: $maskedPhone)';
}


}

/// @nodoc
abstract mixin class $PhoneVerificationModelCopyWith<$Res>  {
  factory $PhoneVerificationModelCopyWith(PhoneVerificationModel value, $Res Function(PhoneVerificationModel) _then) = _$PhoneVerificationModelCopyWithImpl;
@useResult
$Res call({
 String requestId, String demoCode, String maskedPhone
});




}
/// @nodoc
class _$PhoneVerificationModelCopyWithImpl<$Res>
    implements $PhoneVerificationModelCopyWith<$Res> {
  _$PhoneVerificationModelCopyWithImpl(this._self, this._then);

  final PhoneVerificationModel _self;
  final $Res Function(PhoneVerificationModel) _then;

/// Create a copy of PhoneVerificationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? requestId = null,Object? demoCode = null,Object? maskedPhone = null,}) {
  return _then(_self.copyWith(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,demoCode: null == demoCode ? _self.demoCode : demoCode // ignore: cast_nullable_to_non_nullable
as String,maskedPhone: null == maskedPhone ? _self.maskedPhone : maskedPhone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PhoneVerificationModel].
extension PhoneVerificationModelPatterns on PhoneVerificationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PhoneVerificationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PhoneVerificationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PhoneVerificationModel value)  $default,){
final _that = this;
switch (_that) {
case _PhoneVerificationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PhoneVerificationModel value)?  $default,){
final _that = this;
switch (_that) {
case _PhoneVerificationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String requestId,  String demoCode,  String maskedPhone)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PhoneVerificationModel() when $default != null:
return $default(_that.requestId,_that.demoCode,_that.maskedPhone);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String requestId,  String demoCode,  String maskedPhone)  $default,) {final _that = this;
switch (_that) {
case _PhoneVerificationModel():
return $default(_that.requestId,_that.demoCode,_that.maskedPhone);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String requestId,  String demoCode,  String maskedPhone)?  $default,) {final _that = this;
switch (_that) {
case _PhoneVerificationModel() when $default != null:
return $default(_that.requestId,_that.demoCode,_that.maskedPhone);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PhoneVerificationModel extends PhoneVerificationModel {
  const _PhoneVerificationModel({required this.requestId, required this.demoCode, required this.maskedPhone}): super._();
  factory _PhoneVerificationModel.fromJson(Map<String, dynamic> json) => _$PhoneVerificationModelFromJson(json);

@override final  String requestId;
@override final  String demoCode;
@override final  String maskedPhone;

/// Create a copy of PhoneVerificationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PhoneVerificationModelCopyWith<_PhoneVerificationModel> get copyWith => __$PhoneVerificationModelCopyWithImpl<_PhoneVerificationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PhoneVerificationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PhoneVerificationModel&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.demoCode, demoCode) || other.demoCode == demoCode)&&(identical(other.maskedPhone, maskedPhone) || other.maskedPhone == maskedPhone));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,requestId,demoCode,maskedPhone);

@override
String toString() {
  return 'PhoneVerificationModel(requestId: $requestId, demoCode: $demoCode, maskedPhone: $maskedPhone)';
}


}

/// @nodoc
abstract mixin class _$PhoneVerificationModelCopyWith<$Res> implements $PhoneVerificationModelCopyWith<$Res> {
  factory _$PhoneVerificationModelCopyWith(_PhoneVerificationModel value, $Res Function(_PhoneVerificationModel) _then) = __$PhoneVerificationModelCopyWithImpl;
@override @useResult
$Res call({
 String requestId, String demoCode, String maskedPhone
});




}
/// @nodoc
class __$PhoneVerificationModelCopyWithImpl<$Res>
    implements _$PhoneVerificationModelCopyWith<$Res> {
  __$PhoneVerificationModelCopyWithImpl(this._self, this._then);

  final _PhoneVerificationModel _self;
  final $Res Function(_PhoneVerificationModel) _then;

/// Create a copy of PhoneVerificationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? demoCode = null,Object? maskedPhone = null,}) {
  return _then(_PhoneVerificationModel(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as String,demoCode: null == demoCode ? _self.demoCode : demoCode // ignore: cast_nullable_to_non_nullable
as String,maskedPhone: null == maskedPhone ? _self.maskedPhone : maskedPhone // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$UserProfileModel {

 String get firstName; String get lastName; String get birthDate;
/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileModelCopyWith<UserProfileModel> get copyWith => _$UserProfileModelCopyWithImpl<UserProfileModel>(this as UserProfileModel, _$identity);

  /// Serializes this UserProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileModel&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,birthDate);

@override
String toString() {
  return 'UserProfileModel(firstName: $firstName, lastName: $lastName, birthDate: $birthDate)';
}


}

/// @nodoc
abstract mixin class $UserProfileModelCopyWith<$Res>  {
  factory $UserProfileModelCopyWith(UserProfileModel value, $Res Function(UserProfileModel) _then) = _$UserProfileModelCopyWithImpl;
@useResult
$Res call({
 String firstName, String lastName, String birthDate
});




}
/// @nodoc
class _$UserProfileModelCopyWithImpl<$Res>
    implements $UserProfileModelCopyWith<$Res> {
  _$UserProfileModelCopyWithImpl(this._self, this._then);

  final UserProfileModel _self;
  final $Res Function(UserProfileModel) _then;

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? firstName = null,Object? lastName = null,Object? birthDate = null,}) {
  return _then(_self.copyWith(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,birthDate: null == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserProfileModel].
extension UserProfileModelPatterns on UserProfileModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String birthDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
return $default(_that.firstName,_that.lastName,_that.birthDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String firstName,  String lastName,  String birthDate)  $default,) {final _that = this;
switch (_that) {
case _UserProfileModel():
return $default(_that.firstName,_that.lastName,_that.birthDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String firstName,  String lastName,  String birthDate)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileModel() when $default != null:
return $default(_that.firstName,_that.lastName,_that.birthDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileModel extends UserProfileModel {
  const _UserProfileModel({required this.firstName, required this.lastName, required this.birthDate}): super._();
  factory _UserProfileModel.fromJson(Map<String, dynamic> json) => _$UserProfileModelFromJson(json);

@override final  String firstName;
@override final  String lastName;
@override final  String birthDate;

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileModelCopyWith<_UserProfileModel> get copyWith => __$UserProfileModelCopyWithImpl<_UserProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileModel&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.birthDate, birthDate) || other.birthDate == birthDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,firstName,lastName,birthDate);

@override
String toString() {
  return 'UserProfileModel(firstName: $firstName, lastName: $lastName, birthDate: $birthDate)';
}


}

/// @nodoc
abstract mixin class _$UserProfileModelCopyWith<$Res> implements $UserProfileModelCopyWith<$Res> {
  factory _$UserProfileModelCopyWith(_UserProfileModel value, $Res Function(_UserProfileModel) _then) = __$UserProfileModelCopyWithImpl;
@override @useResult
$Res call({
 String firstName, String lastName, String birthDate
});




}
/// @nodoc
class __$UserProfileModelCopyWithImpl<$Res>
    implements _$UserProfileModelCopyWith<$Res> {
  __$UserProfileModelCopyWithImpl(this._self, this._then);

  final _UserProfileModel _self;
  final $Res Function(_UserProfileModel) _then;

/// Create a copy of UserProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? firstName = null,Object? lastName = null,Object? birthDate = null,}) {
  return _then(_UserProfileModel(
firstName: null == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String,lastName: null == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String,birthDate: null == birthDate ? _self.birthDate : birthDate // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$KycStateModel {

 String get status; String? get submittedAt;
/// Create a copy of KycStateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KycStateModelCopyWith<KycStateModel> get copyWith => _$KycStateModelCopyWithImpl<KycStateModel>(this as KycStateModel, _$identity);

  /// Serializes this KycStateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KycStateModel&&(identical(other.status, status) || other.status == status)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,submittedAt);

@override
String toString() {
  return 'KycStateModel(status: $status, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class $KycStateModelCopyWith<$Res>  {
  factory $KycStateModelCopyWith(KycStateModel value, $Res Function(KycStateModel) _then) = _$KycStateModelCopyWithImpl;
@useResult
$Res call({
 String status, String? submittedAt
});




}
/// @nodoc
class _$KycStateModelCopyWithImpl<$Res>
    implements $KycStateModelCopyWith<$Res> {
  _$KycStateModelCopyWithImpl(this._self, this._then);

  final KycStateModel _self;
  final $Res Function(KycStateModel) _then;

/// Create a copy of KycStateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? submittedAt = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [KycStateModel].
extension KycStateModelPatterns on KycStateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KycStateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KycStateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KycStateModel value)  $default,){
final _that = this;
switch (_that) {
case _KycStateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KycStateModel value)?  $default,){
final _that = this;
switch (_that) {
case _KycStateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String status,  String? submittedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KycStateModel() when $default != null:
return $default(_that.status,_that.submittedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String status,  String? submittedAt)  $default,) {final _that = this;
switch (_that) {
case _KycStateModel():
return $default(_that.status,_that.submittedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String status,  String? submittedAt)?  $default,) {final _that = this;
switch (_that) {
case _KycStateModel() when $default != null:
return $default(_that.status,_that.submittedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KycStateModel extends KycStateModel {
  const _KycStateModel({required this.status, this.submittedAt}): super._();
  factory _KycStateModel.fromJson(Map<String, dynamic> json) => _$KycStateModelFromJson(json);

@override final  String status;
@override final  String? submittedAt;

/// Create a copy of KycStateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KycStateModelCopyWith<_KycStateModel> get copyWith => __$KycStateModelCopyWithImpl<_KycStateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KycStateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KycStateModel&&(identical(other.status, status) || other.status == status)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,submittedAt);

@override
String toString() {
  return 'KycStateModel(status: $status, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class _$KycStateModelCopyWith<$Res> implements $KycStateModelCopyWith<$Res> {
  factory _$KycStateModelCopyWith(_KycStateModel value, $Res Function(_KycStateModel) _then) = __$KycStateModelCopyWithImpl;
@override @useResult
$Res call({
 String status, String? submittedAt
});




}
/// @nodoc
class __$KycStateModelCopyWithImpl<$Res>
    implements _$KycStateModelCopyWith<$Res> {
  __$KycStateModelCopyWithImpl(this._self, this._then);

  final _KycStateModel _self;
  final $Res Function(_KycStateModel) _then;

/// Create a copy of KycStateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? submittedAt = freezed,}) {
  return _then(_KycStateModel(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,submittedAt: freezed == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
