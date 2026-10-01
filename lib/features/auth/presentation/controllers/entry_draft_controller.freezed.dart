// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry_draft_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EntryDraft {

 String? get phone; PhoneVerification? get verification; String get documentType; String get countryCode; bool get frontCaptured; bool get backCaptured;
/// Create a copy of EntryDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntryDraftCopyWith<EntryDraft> get copyWith => _$EntryDraftCopyWithImpl<EntryDraft>(this as EntryDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntryDraft&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.verification, verification) || other.verification == verification)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.frontCaptured, frontCaptured) || other.frontCaptured == frontCaptured)&&(identical(other.backCaptured, backCaptured) || other.backCaptured == backCaptured));
}


@override
int get hashCode => Object.hash(runtimeType,phone,verification,documentType,countryCode,frontCaptured,backCaptured);

@override
String toString() {
  return 'EntryDraft(phone: $phone, verification: $verification, documentType: $documentType, countryCode: $countryCode, frontCaptured: $frontCaptured, backCaptured: $backCaptured)';
}


}

/// @nodoc
abstract mixin class $EntryDraftCopyWith<$Res>  {
  factory $EntryDraftCopyWith(EntryDraft value, $Res Function(EntryDraft) _then) = _$EntryDraftCopyWithImpl;
@useResult
$Res call({
 String? phone, PhoneVerification? verification, String documentType, String countryCode, bool frontCaptured, bool backCaptured
});


$PhoneVerificationCopyWith<$Res>? get verification;

}
/// @nodoc
class _$EntryDraftCopyWithImpl<$Res>
    implements $EntryDraftCopyWith<$Res> {
  _$EntryDraftCopyWithImpl(this._self, this._then);

  final EntryDraft _self;
  final $Res Function(EntryDraft) _then;

/// Create a copy of EntryDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? phone = freezed,Object? verification = freezed,Object? documentType = null,Object? countryCode = null,Object? frontCaptured = null,Object? backCaptured = null,}) {
  return _then(_self.copyWith(
phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,verification: freezed == verification ? _self.verification : verification // ignore: cast_nullable_to_non_nullable
as PhoneVerification?,documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,frontCaptured: null == frontCaptured ? _self.frontCaptured : frontCaptured // ignore: cast_nullable_to_non_nullable
as bool,backCaptured: null == backCaptured ? _self.backCaptured : backCaptured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of EntryDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhoneVerificationCopyWith<$Res>? get verification {
    if (_self.verification == null) {
    return null;
  }

  return $PhoneVerificationCopyWith<$Res>(_self.verification!, (value) {
    return _then(_self.copyWith(verification: value));
  });
}
}


/// Adds pattern-matching-related methods to [EntryDraft].
extension EntryDraftPatterns on EntryDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntryDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntryDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntryDraft value)  $default,){
final _that = this;
switch (_that) {
case _EntryDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntryDraft value)?  $default,){
final _that = this;
switch (_that) {
case _EntryDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? phone,  PhoneVerification? verification,  String documentType,  String countryCode,  bool frontCaptured,  bool backCaptured)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntryDraft() when $default != null:
return $default(_that.phone,_that.verification,_that.documentType,_that.countryCode,_that.frontCaptured,_that.backCaptured);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? phone,  PhoneVerification? verification,  String documentType,  String countryCode,  bool frontCaptured,  bool backCaptured)  $default,) {final _that = this;
switch (_that) {
case _EntryDraft():
return $default(_that.phone,_that.verification,_that.documentType,_that.countryCode,_that.frontCaptured,_that.backCaptured);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? phone,  PhoneVerification? verification,  String documentType,  String countryCode,  bool frontCaptured,  bool backCaptured)?  $default,) {final _that = this;
switch (_that) {
case _EntryDraft() when $default != null:
return $default(_that.phone,_that.verification,_that.documentType,_that.countryCode,_that.frontCaptured,_that.backCaptured);case _:
  return null;

}
}

}

/// @nodoc


class _EntryDraft implements EntryDraft {
  const _EntryDraft({this.phone, this.verification, this.documentType = 'id_card', this.countryCode = 'BJ', this.frontCaptured = false, this.backCaptured = false});
  

@override final  String? phone;
@override final  PhoneVerification? verification;
@override@JsonKey() final  String documentType;
@override@JsonKey() final  String countryCode;
@override@JsonKey() final  bool frontCaptured;
@override@JsonKey() final  bool backCaptured;

/// Create a copy of EntryDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntryDraftCopyWith<_EntryDraft> get copyWith => __$EntryDraftCopyWithImpl<_EntryDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntryDraft&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.verification, verification) || other.verification == verification)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.frontCaptured, frontCaptured) || other.frontCaptured == frontCaptured)&&(identical(other.backCaptured, backCaptured) || other.backCaptured == backCaptured));
}


@override
int get hashCode => Object.hash(runtimeType,phone,verification,documentType,countryCode,frontCaptured,backCaptured);

@override
String toString() {
  return 'EntryDraft(phone: $phone, verification: $verification, documentType: $documentType, countryCode: $countryCode, frontCaptured: $frontCaptured, backCaptured: $backCaptured)';
}


}

/// @nodoc
abstract mixin class _$EntryDraftCopyWith<$Res> implements $EntryDraftCopyWith<$Res> {
  factory _$EntryDraftCopyWith(_EntryDraft value, $Res Function(_EntryDraft) _then) = __$EntryDraftCopyWithImpl;
@override @useResult
$Res call({
 String? phone, PhoneVerification? verification, String documentType, String countryCode, bool frontCaptured, bool backCaptured
});


@override $PhoneVerificationCopyWith<$Res>? get verification;

}
/// @nodoc
class __$EntryDraftCopyWithImpl<$Res>
    implements _$EntryDraftCopyWith<$Res> {
  __$EntryDraftCopyWithImpl(this._self, this._then);

  final _EntryDraft _self;
  final $Res Function(_EntryDraft) _then;

/// Create a copy of EntryDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? phone = freezed,Object? verification = freezed,Object? documentType = null,Object? countryCode = null,Object? frontCaptured = null,Object? backCaptured = null,}) {
  return _then(_EntryDraft(
phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,verification: freezed == verification ? _self.verification : verification // ignore: cast_nullable_to_non_nullable
as PhoneVerification?,documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,frontCaptured: null == frontCaptured ? _self.frontCaptured : frontCaptured // ignore: cast_nullable_to_non_nullable
as bool,backCaptured: null == backCaptured ? _self.backCaptured : backCaptured // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of EntryDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PhoneVerificationCopyWith<$Res>? get verification {
    if (_self.verification == null) {
    return null;
  }

  return $PhoneVerificationCopyWith<$Res>(_self.verification!, (value) {
    return _then(_self.copyWith(verification: value));
  });
}
}

// dart format on
