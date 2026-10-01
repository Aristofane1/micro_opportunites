// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MissionModel {

 String get id; String get title; String get category; String get city; String get startAt; int get durationMin; PayModel get pay; int get slotsTotal; int get slotsFree; String get description; String get applyDeadline; String get publishedAt; PosterSummaryModel get poster; int get publicQuestionsCount; bool get alreadyApplied;
/// Create a copy of MissionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissionModelCopyWith<MissionModel> get copyWith => _$MissionModelCopyWithImpl<MissionModel>(this as MissionModel, _$identity);

  /// Serializes this MissionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MissionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.city, city) || other.city == city)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMin, durationMin) || other.durationMin == durationMin)&&(identical(other.pay, pay) || other.pay == pay)&&(identical(other.slotsTotal, slotsTotal) || other.slotsTotal == slotsTotal)&&(identical(other.slotsFree, slotsFree) || other.slotsFree == slotsFree)&&(identical(other.description, description) || other.description == description)&&(identical(other.applyDeadline, applyDeadline) || other.applyDeadline == applyDeadline)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.poster, poster) || other.poster == poster)&&(identical(other.publicQuestionsCount, publicQuestionsCount) || other.publicQuestionsCount == publicQuestionsCount)&&(identical(other.alreadyApplied, alreadyApplied) || other.alreadyApplied == alreadyApplied));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,category,city,startAt,durationMin,pay,slotsTotal,slotsFree,description,applyDeadline,publishedAt,poster,publicQuestionsCount,alreadyApplied);

@override
String toString() {
  return 'MissionModel(id: $id, title: $title, category: $category, city: $city, startAt: $startAt, durationMin: $durationMin, pay: $pay, slotsTotal: $slotsTotal, slotsFree: $slotsFree, description: $description, applyDeadline: $applyDeadline, publishedAt: $publishedAt, poster: $poster, publicQuestionsCount: $publicQuestionsCount, alreadyApplied: $alreadyApplied)';
}


}

/// @nodoc
abstract mixin class $MissionModelCopyWith<$Res>  {
  factory $MissionModelCopyWith(MissionModel value, $Res Function(MissionModel) _then) = _$MissionModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String category, String city, String startAt, int durationMin, PayModel pay, int slotsTotal, int slotsFree, String description, String applyDeadline, String publishedAt, PosterSummaryModel poster, int publicQuestionsCount, bool alreadyApplied
});


$PayModelCopyWith<$Res> get pay;$PosterSummaryModelCopyWith<$Res> get poster;

}
/// @nodoc
class _$MissionModelCopyWithImpl<$Res>
    implements $MissionModelCopyWith<$Res> {
  _$MissionModelCopyWithImpl(this._self, this._then);

  final MissionModel _self;
  final $Res Function(MissionModel) _then;

/// Create a copy of MissionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? category = null,Object? city = null,Object? startAt = null,Object? durationMin = null,Object? pay = null,Object? slotsTotal = null,Object? slotsFree = null,Object? description = null,Object? applyDeadline = null,Object? publishedAt = null,Object? poster = null,Object? publicQuestionsCount = null,Object? alreadyApplied = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String,durationMin: null == durationMin ? _self.durationMin : durationMin // ignore: cast_nullable_to_non_nullable
as int,pay: null == pay ? _self.pay : pay // ignore: cast_nullable_to_non_nullable
as PayModel,slotsTotal: null == slotsTotal ? _self.slotsTotal : slotsTotal // ignore: cast_nullable_to_non_nullable
as int,slotsFree: null == slotsFree ? _self.slotsFree : slotsFree // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,applyDeadline: null == applyDeadline ? _self.applyDeadline : applyDeadline // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,poster: null == poster ? _self.poster : poster // ignore: cast_nullable_to_non_nullable
as PosterSummaryModel,publicQuestionsCount: null == publicQuestionsCount ? _self.publicQuestionsCount : publicQuestionsCount // ignore: cast_nullable_to_non_nullable
as int,alreadyApplied: null == alreadyApplied ? _self.alreadyApplied : alreadyApplied // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of MissionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayModelCopyWith<$Res> get pay {
  
  return $PayModelCopyWith<$Res>(_self.pay, (value) {
    return _then(_self.copyWith(pay: value));
  });
}/// Create a copy of MissionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PosterSummaryModelCopyWith<$Res> get poster {
  
  return $PosterSummaryModelCopyWith<$Res>(_self.poster, (value) {
    return _then(_self.copyWith(poster: value));
  });
}
}


/// Adds pattern-matching-related methods to [MissionModel].
extension MissionModelPatterns on MissionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MissionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MissionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MissionModel value)  $default,){
final _that = this;
switch (_that) {
case _MissionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MissionModel value)?  $default,){
final _that = this;
switch (_that) {
case _MissionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String category,  String city,  String startAt,  int durationMin,  PayModel pay,  int slotsTotal,  int slotsFree,  String description,  String applyDeadline,  String publishedAt,  PosterSummaryModel poster,  int publicQuestionsCount,  bool alreadyApplied)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MissionModel() when $default != null:
return $default(_that.id,_that.title,_that.category,_that.city,_that.startAt,_that.durationMin,_that.pay,_that.slotsTotal,_that.slotsFree,_that.description,_that.applyDeadline,_that.publishedAt,_that.poster,_that.publicQuestionsCount,_that.alreadyApplied);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String category,  String city,  String startAt,  int durationMin,  PayModel pay,  int slotsTotal,  int slotsFree,  String description,  String applyDeadline,  String publishedAt,  PosterSummaryModel poster,  int publicQuestionsCount,  bool alreadyApplied)  $default,) {final _that = this;
switch (_that) {
case _MissionModel():
return $default(_that.id,_that.title,_that.category,_that.city,_that.startAt,_that.durationMin,_that.pay,_that.slotsTotal,_that.slotsFree,_that.description,_that.applyDeadline,_that.publishedAt,_that.poster,_that.publicQuestionsCount,_that.alreadyApplied);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String category,  String city,  String startAt,  int durationMin,  PayModel pay,  int slotsTotal,  int slotsFree,  String description,  String applyDeadline,  String publishedAt,  PosterSummaryModel poster,  int publicQuestionsCount,  bool alreadyApplied)?  $default,) {final _that = this;
switch (_that) {
case _MissionModel() when $default != null:
return $default(_that.id,_that.title,_that.category,_that.city,_that.startAt,_that.durationMin,_that.pay,_that.slotsTotal,_that.slotsFree,_that.description,_that.applyDeadline,_that.publishedAt,_that.poster,_that.publicQuestionsCount,_that.alreadyApplied);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MissionModel extends MissionModel {
  const _MissionModel({required this.id, required this.title, required this.category, required this.city, required this.startAt, required this.durationMin, required this.pay, required this.slotsTotal, required this.slotsFree, required this.description, required this.applyDeadline, required this.publishedAt, required this.poster, required this.publicQuestionsCount, required this.alreadyApplied}): super._();
  factory _MissionModel.fromJson(Map<String, dynamic> json) => _$MissionModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String category;
@override final  String city;
@override final  String startAt;
@override final  int durationMin;
@override final  PayModel pay;
@override final  int slotsTotal;
@override final  int slotsFree;
@override final  String description;
@override final  String applyDeadline;
@override final  String publishedAt;
@override final  PosterSummaryModel poster;
@override final  int publicQuestionsCount;
@override final  bool alreadyApplied;

/// Create a copy of MissionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissionModelCopyWith<_MissionModel> get copyWith => __$MissionModelCopyWithImpl<_MissionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MissionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MissionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.city, city) || other.city == city)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMin, durationMin) || other.durationMin == durationMin)&&(identical(other.pay, pay) || other.pay == pay)&&(identical(other.slotsTotal, slotsTotal) || other.slotsTotal == slotsTotal)&&(identical(other.slotsFree, slotsFree) || other.slotsFree == slotsFree)&&(identical(other.description, description) || other.description == description)&&(identical(other.applyDeadline, applyDeadline) || other.applyDeadline == applyDeadline)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.poster, poster) || other.poster == poster)&&(identical(other.publicQuestionsCount, publicQuestionsCount) || other.publicQuestionsCount == publicQuestionsCount)&&(identical(other.alreadyApplied, alreadyApplied) || other.alreadyApplied == alreadyApplied));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,category,city,startAt,durationMin,pay,slotsTotal,slotsFree,description,applyDeadline,publishedAt,poster,publicQuestionsCount,alreadyApplied);

@override
String toString() {
  return 'MissionModel(id: $id, title: $title, category: $category, city: $city, startAt: $startAt, durationMin: $durationMin, pay: $pay, slotsTotal: $slotsTotal, slotsFree: $slotsFree, description: $description, applyDeadline: $applyDeadline, publishedAt: $publishedAt, poster: $poster, publicQuestionsCount: $publicQuestionsCount, alreadyApplied: $alreadyApplied)';
}


}

/// @nodoc
abstract mixin class _$MissionModelCopyWith<$Res> implements $MissionModelCopyWith<$Res> {
  factory _$MissionModelCopyWith(_MissionModel value, $Res Function(_MissionModel) _then) = __$MissionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String category, String city, String startAt, int durationMin, PayModel pay, int slotsTotal, int slotsFree, String description, String applyDeadline, String publishedAt, PosterSummaryModel poster, int publicQuestionsCount, bool alreadyApplied
});


@override $PayModelCopyWith<$Res> get pay;@override $PosterSummaryModelCopyWith<$Res> get poster;

}
/// @nodoc
class __$MissionModelCopyWithImpl<$Res>
    implements _$MissionModelCopyWith<$Res> {
  __$MissionModelCopyWithImpl(this._self, this._then);

  final _MissionModel _self;
  final $Res Function(_MissionModel) _then;

/// Create a copy of MissionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? category = null,Object? city = null,Object? startAt = null,Object? durationMin = null,Object? pay = null,Object? slotsTotal = null,Object? slotsFree = null,Object? description = null,Object? applyDeadline = null,Object? publishedAt = null,Object? poster = null,Object? publicQuestionsCount = null,Object? alreadyApplied = null,}) {
  return _then(_MissionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as String,durationMin: null == durationMin ? _self.durationMin : durationMin // ignore: cast_nullable_to_non_nullable
as int,pay: null == pay ? _self.pay : pay // ignore: cast_nullable_to_non_nullable
as PayModel,slotsTotal: null == slotsTotal ? _self.slotsTotal : slotsTotal // ignore: cast_nullable_to_non_nullable
as int,slotsFree: null == slotsFree ? _self.slotsFree : slotsFree // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,applyDeadline: null == applyDeadline ? _self.applyDeadline : applyDeadline // ignore: cast_nullable_to_non_nullable
as String,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as String,poster: null == poster ? _self.poster : poster // ignore: cast_nullable_to_non_nullable
as PosterSummaryModel,publicQuestionsCount: null == publicQuestionsCount ? _self.publicQuestionsCount : publicQuestionsCount // ignore: cast_nullable_to_non_nullable
as int,alreadyApplied: null == alreadyApplied ? _self.alreadyApplied : alreadyApplied // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of MissionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PayModelCopyWith<$Res> get pay {
  
  return $PayModelCopyWith<$Res>(_self.pay, (value) {
    return _then(_self.copyWith(pay: value));
  });
}/// Create a copy of MissionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PosterSummaryModelCopyWith<$Res> get poster {
  
  return $PosterSummaryModelCopyWith<$Res>(_self.poster, (value) {
    return _then(_self.copyWith(poster: value));
  });
}
}


/// @nodoc
mixin _$PayModel {

 int get amount; String get type;
/// Create a copy of PayModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PayModelCopyWith<PayModel> get copyWith => _$PayModelCopyWithImpl<PayModel>(this as PayModel, _$identity);

  /// Serializes this PayModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PayModel&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,type);

@override
String toString() {
  return 'PayModel(amount: $amount, type: $type)';
}


}

/// @nodoc
abstract mixin class $PayModelCopyWith<$Res>  {
  factory $PayModelCopyWith(PayModel value, $Res Function(PayModel) _then) = _$PayModelCopyWithImpl;
@useResult
$Res call({
 int amount, String type
});




}
/// @nodoc
class _$PayModelCopyWithImpl<$Res>
    implements $PayModelCopyWith<$Res> {
  _$PayModelCopyWithImpl(this._self, this._then);

  final PayModel _self;
  final $Res Function(PayModel) _then;

/// Create a copy of PayModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? type = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PayModel].
extension PayModelPatterns on PayModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PayModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PayModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PayModel value)  $default,){
final _that = this;
switch (_that) {
case _PayModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PayModel value)?  $default,){
final _that = this;
switch (_that) {
case _PayModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int amount,  String type)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PayModel() when $default != null:
return $default(_that.amount,_that.type);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int amount,  String type)  $default,) {final _that = this;
switch (_that) {
case _PayModel():
return $default(_that.amount,_that.type);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int amount,  String type)?  $default,) {final _that = this;
switch (_that) {
case _PayModel() when $default != null:
return $default(_that.amount,_that.type);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PayModel implements PayModel {
  const _PayModel({required this.amount, required this.type});
  factory _PayModel.fromJson(Map<String, dynamic> json) => _$PayModelFromJson(json);

@override final  int amount;
@override final  String type;

/// Create a copy of PayModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PayModelCopyWith<_PayModel> get copyWith => __$PayModelCopyWithImpl<_PayModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PayModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PayModel&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,type);

@override
String toString() {
  return 'PayModel(amount: $amount, type: $type)';
}


}

/// @nodoc
abstract mixin class _$PayModelCopyWith<$Res> implements $PayModelCopyWith<$Res> {
  factory _$PayModelCopyWith(_PayModel value, $Res Function(_PayModel) _then) = __$PayModelCopyWithImpl;
@override @useResult
$Res call({
 int amount, String type
});




}
/// @nodoc
class __$PayModelCopyWithImpl<$Res>
    implements _$PayModelCopyWith<$Res> {
  __$PayModelCopyWithImpl(this._self, this._then);

  final _PayModel _self;
  final $Res Function(_PayModel) _then;

/// Create a copy of PayModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? type = null,}) {
  return _then(_PayModel(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as int,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$PosterSummaryModel {

 String get id; String get displayName; String get initials; bool get verified; double get rating; int get avgValidationHours;
/// Create a copy of PosterSummaryModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PosterSummaryModelCopyWith<PosterSummaryModel> get copyWith => _$PosterSummaryModelCopyWithImpl<PosterSummaryModel>(this as PosterSummaryModel, _$identity);

  /// Serializes this PosterSummaryModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PosterSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.initials, initials) || other.initials == initials)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.avgValidationHours, avgValidationHours) || other.avgValidationHours == avgValidationHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,initials,verified,rating,avgValidationHours);

@override
String toString() {
  return 'PosterSummaryModel(id: $id, displayName: $displayName, initials: $initials, verified: $verified, rating: $rating, avgValidationHours: $avgValidationHours)';
}


}

/// @nodoc
abstract mixin class $PosterSummaryModelCopyWith<$Res>  {
  factory $PosterSummaryModelCopyWith(PosterSummaryModel value, $Res Function(PosterSummaryModel) _then) = _$PosterSummaryModelCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, String initials, bool verified, double rating, int avgValidationHours
});




}
/// @nodoc
class _$PosterSummaryModelCopyWithImpl<$Res>
    implements $PosterSummaryModelCopyWith<$Res> {
  _$PosterSummaryModelCopyWithImpl(this._self, this._then);

  final PosterSummaryModel _self;
  final $Res Function(PosterSummaryModel) _then;

/// Create a copy of PosterSummaryModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? initials = null,Object? verified = null,Object? rating = null,Object? avgValidationHours = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,initials: null == initials ? _self.initials : initials // ignore: cast_nullable_to_non_nullable
as String,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,avgValidationHours: null == avgValidationHours ? _self.avgValidationHours : avgValidationHours // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PosterSummaryModel].
extension PosterSummaryModelPatterns on PosterSummaryModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PosterSummaryModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PosterSummaryModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PosterSummaryModel value)  $default,){
final _that = this;
switch (_that) {
case _PosterSummaryModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PosterSummaryModel value)?  $default,){
final _that = this;
switch (_that) {
case _PosterSummaryModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  String initials,  bool verified,  double rating,  int avgValidationHours)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PosterSummaryModel() when $default != null:
return $default(_that.id,_that.displayName,_that.initials,_that.verified,_that.rating,_that.avgValidationHours);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  String initials,  bool verified,  double rating,  int avgValidationHours)  $default,) {final _that = this;
switch (_that) {
case _PosterSummaryModel():
return $default(_that.id,_that.displayName,_that.initials,_that.verified,_that.rating,_that.avgValidationHours);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  String initials,  bool verified,  double rating,  int avgValidationHours)?  $default,) {final _that = this;
switch (_that) {
case _PosterSummaryModel() when $default != null:
return $default(_that.id,_that.displayName,_that.initials,_that.verified,_that.rating,_that.avgValidationHours);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PosterSummaryModel extends PosterSummaryModel {
  const _PosterSummaryModel({required this.id, required this.displayName, required this.initials, required this.verified, required this.rating, required this.avgValidationHours}): super._();
  factory _PosterSummaryModel.fromJson(Map<String, dynamic> json) => _$PosterSummaryModelFromJson(json);

@override final  String id;
@override final  String displayName;
@override final  String initials;
@override final  bool verified;
@override final  double rating;
@override final  int avgValidationHours;

/// Create a copy of PosterSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PosterSummaryModelCopyWith<_PosterSummaryModel> get copyWith => __$PosterSummaryModelCopyWithImpl<_PosterSummaryModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PosterSummaryModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PosterSummaryModel&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.initials, initials) || other.initials == initials)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.avgValidationHours, avgValidationHours) || other.avgValidationHours == avgValidationHours));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,initials,verified,rating,avgValidationHours);

@override
String toString() {
  return 'PosterSummaryModel(id: $id, displayName: $displayName, initials: $initials, verified: $verified, rating: $rating, avgValidationHours: $avgValidationHours)';
}


}

/// @nodoc
abstract mixin class _$PosterSummaryModelCopyWith<$Res> implements $PosterSummaryModelCopyWith<$Res> {
  factory _$PosterSummaryModelCopyWith(_PosterSummaryModel value, $Res Function(_PosterSummaryModel) _then) = __$PosterSummaryModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, String initials, bool verified, double rating, int avgValidationHours
});




}
/// @nodoc
class __$PosterSummaryModelCopyWithImpl<$Res>
    implements _$PosterSummaryModelCopyWith<$Res> {
  __$PosterSummaryModelCopyWithImpl(this._self, this._then);

  final _PosterSummaryModel _self;
  final $Res Function(_PosterSummaryModel) _then;

/// Create a copy of PosterSummaryModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? initials = null,Object? verified = null,Object? rating = null,Object? avgValidationHours = null,}) {
  return _then(_PosterSummaryModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,initials: null == initials ? _self.initials : initials // ignore: cast_nullable_to_non_nullable
as String,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,avgValidationHours: null == avgValidationHours ? _self.avgValidationHours : avgValidationHours // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
