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

 bool get creatingAccount; String get documentType; String get countryCode; String? get frontPath; String? get backPath; String? get selfiePath;
/// Create a copy of EntryDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntryDraftCopyWith<EntryDraft> get copyWith => _$EntryDraftCopyWithImpl<EntryDraft>(this as EntryDraft, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntryDraft&&(identical(other.creatingAccount, creatingAccount) || other.creatingAccount == creatingAccount)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.frontPath, frontPath) || other.frontPath == frontPath)&&(identical(other.backPath, backPath) || other.backPath == backPath)&&(identical(other.selfiePath, selfiePath) || other.selfiePath == selfiePath));
}


@override
int get hashCode => Object.hash(runtimeType,creatingAccount,documentType,countryCode,frontPath,backPath,selfiePath);

@override
String toString() {
  return 'EntryDraft(creatingAccount: $creatingAccount, documentType: $documentType, countryCode: $countryCode, frontPath: $frontPath, backPath: $backPath, selfiePath: $selfiePath)';
}


}

/// @nodoc
abstract mixin class $EntryDraftCopyWith<$Res>  {
  factory $EntryDraftCopyWith(EntryDraft value, $Res Function(EntryDraft) _then) = _$EntryDraftCopyWithImpl;
@useResult
$Res call({
 bool creatingAccount, String documentType, String countryCode, String? frontPath, String? backPath, String? selfiePath
});




}
/// @nodoc
class _$EntryDraftCopyWithImpl<$Res>
    implements $EntryDraftCopyWith<$Res> {
  _$EntryDraftCopyWithImpl(this._self, this._then);

  final EntryDraft _self;
  final $Res Function(EntryDraft) _then;

/// Create a copy of EntryDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? creatingAccount = null,Object? documentType = null,Object? countryCode = null,Object? frontPath = freezed,Object? backPath = freezed,Object? selfiePath = freezed,}) {
  return _then(_self.copyWith(
creatingAccount: null == creatingAccount ? _self.creatingAccount : creatingAccount // ignore: cast_nullable_to_non_nullable
as bool,documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,frontPath: freezed == frontPath ? _self.frontPath : frontPath // ignore: cast_nullable_to_non_nullable
as String?,backPath: freezed == backPath ? _self.backPath : backPath // ignore: cast_nullable_to_non_nullable
as String?,selfiePath: freezed == selfiePath ? _self.selfiePath : selfiePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool creatingAccount,  String documentType,  String countryCode,  String? frontPath,  String? backPath,  String? selfiePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntryDraft() when $default != null:
return $default(_that.creatingAccount,_that.documentType,_that.countryCode,_that.frontPath,_that.backPath,_that.selfiePath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool creatingAccount,  String documentType,  String countryCode,  String? frontPath,  String? backPath,  String? selfiePath)  $default,) {final _that = this;
switch (_that) {
case _EntryDraft():
return $default(_that.creatingAccount,_that.documentType,_that.countryCode,_that.frontPath,_that.backPath,_that.selfiePath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool creatingAccount,  String documentType,  String countryCode,  String? frontPath,  String? backPath,  String? selfiePath)?  $default,) {final _that = this;
switch (_that) {
case _EntryDraft() when $default != null:
return $default(_that.creatingAccount,_that.documentType,_that.countryCode,_that.frontPath,_that.backPath,_that.selfiePath);case _:
  return null;

}
}

}

/// @nodoc


class _EntryDraft implements EntryDraft {
  const _EntryDraft({this.creatingAccount = true, this.documentType = 'id_card', this.countryCode = 'BJ', this.frontPath, this.backPath, this.selfiePath});
  

@override@JsonKey() final  bool creatingAccount;
@override@JsonKey() final  String documentType;
@override@JsonKey() final  String countryCode;
@override final  String? frontPath;
@override final  String? backPath;
@override final  String? selfiePath;

/// Create a copy of EntryDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntryDraftCopyWith<_EntryDraft> get copyWith => __$EntryDraftCopyWithImpl<_EntryDraft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntryDraft&&(identical(other.creatingAccount, creatingAccount) || other.creatingAccount == creatingAccount)&&(identical(other.documentType, documentType) || other.documentType == documentType)&&(identical(other.countryCode, countryCode) || other.countryCode == countryCode)&&(identical(other.frontPath, frontPath) || other.frontPath == frontPath)&&(identical(other.backPath, backPath) || other.backPath == backPath)&&(identical(other.selfiePath, selfiePath) || other.selfiePath == selfiePath));
}


@override
int get hashCode => Object.hash(runtimeType,creatingAccount,documentType,countryCode,frontPath,backPath,selfiePath);

@override
String toString() {
  return 'EntryDraft(creatingAccount: $creatingAccount, documentType: $documentType, countryCode: $countryCode, frontPath: $frontPath, backPath: $backPath, selfiePath: $selfiePath)';
}


}

/// @nodoc
abstract mixin class _$EntryDraftCopyWith<$Res> implements $EntryDraftCopyWith<$Res> {
  factory _$EntryDraftCopyWith(_EntryDraft value, $Res Function(_EntryDraft) _then) = __$EntryDraftCopyWithImpl;
@override @useResult
$Res call({
 bool creatingAccount, String documentType, String countryCode, String? frontPath, String? backPath, String? selfiePath
});




}
/// @nodoc
class __$EntryDraftCopyWithImpl<$Res>
    implements _$EntryDraftCopyWith<$Res> {
  __$EntryDraftCopyWithImpl(this._self, this._then);

  final _EntryDraft _self;
  final $Res Function(_EntryDraft) _then;

/// Create a copy of EntryDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? creatingAccount = null,Object? documentType = null,Object? countryCode = null,Object? frontPath = freezed,Object? backPath = freezed,Object? selfiePath = freezed,}) {
  return _then(_EntryDraft(
creatingAccount: null == creatingAccount ? _self.creatingAccount : creatingAccount // ignore: cast_nullable_to_non_nullable
as bool,documentType: null == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String,countryCode: null == countryCode ? _self.countryCode : countryCode // ignore: cast_nullable_to_non_nullable
as String,frontPath: freezed == frontPath ? _self.frontPath : frontPath // ignore: cast_nullable_to_non_nullable
as String?,backPath: freezed == backPath ? _self.backPath : backPath // ignore: cast_nullable_to_non_nullable
as String?,selfiePath: freezed == selfiePath ? _self.selfiePath : selfiePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
