// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mission.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Mission {

 String get id; String get title; MissionCategory get category; String get city; DateTime get startAt; int get durationMinutes; int get payAmount; int get slotsTotal; int get slotsFree; String get description; DateTime get applyDeadline; DateTime get publishedAt; PosterSummary get poster; int get publicQuestionsCount; bool get alreadyApplied;
/// Create a copy of Mission
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MissionCopyWith<Mission> get copyWith => _$MissionCopyWithImpl<Mission>(this as Mission, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Mission&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.city, city) || other.city == city)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.slotsTotal, slotsTotal) || other.slotsTotal == slotsTotal)&&(identical(other.slotsFree, slotsFree) || other.slotsFree == slotsFree)&&(identical(other.description, description) || other.description == description)&&(identical(other.applyDeadline, applyDeadline) || other.applyDeadline == applyDeadline)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.poster, poster) || other.poster == poster)&&(identical(other.publicQuestionsCount, publicQuestionsCount) || other.publicQuestionsCount == publicQuestionsCount)&&(identical(other.alreadyApplied, alreadyApplied) || other.alreadyApplied == alreadyApplied));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,category,city,startAt,durationMinutes,payAmount,slotsTotal,slotsFree,description,applyDeadline,publishedAt,poster,publicQuestionsCount,alreadyApplied);

@override
String toString() {
  return 'Mission(id: $id, title: $title, category: $category, city: $city, startAt: $startAt, durationMinutes: $durationMinutes, payAmount: $payAmount, slotsTotal: $slotsTotal, slotsFree: $slotsFree, description: $description, applyDeadline: $applyDeadline, publishedAt: $publishedAt, poster: $poster, publicQuestionsCount: $publicQuestionsCount, alreadyApplied: $alreadyApplied)';
}


}

/// @nodoc
abstract mixin class $MissionCopyWith<$Res>  {
  factory $MissionCopyWith(Mission value, $Res Function(Mission) _then) = _$MissionCopyWithImpl;
@useResult
$Res call({
 String id, String title, MissionCategory category, String city, DateTime startAt, int durationMinutes, int payAmount, int slotsTotal, int slotsFree, String description, DateTime applyDeadline, DateTime publishedAt, PosterSummary poster, int publicQuestionsCount, bool alreadyApplied
});


$PosterSummaryCopyWith<$Res> get poster;

}
/// @nodoc
class _$MissionCopyWithImpl<$Res>
    implements $MissionCopyWith<$Res> {
  _$MissionCopyWithImpl(this._self, this._then);

  final Mission _self;
  final $Res Function(Mission) _then;

/// Create a copy of Mission
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? category = null,Object? city = null,Object? startAt = null,Object? durationMinutes = null,Object? payAmount = null,Object? slotsTotal = null,Object? slotsFree = null,Object? description = null,Object? applyDeadline = null,Object? publishedAt = null,Object? poster = null,Object? publicQuestionsCount = null,Object? alreadyApplied = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as MissionCategory,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,payAmount: null == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int,slotsTotal: null == slotsTotal ? _self.slotsTotal : slotsTotal // ignore: cast_nullable_to_non_nullable
as int,slotsFree: null == slotsFree ? _self.slotsFree : slotsFree // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,applyDeadline: null == applyDeadline ? _self.applyDeadline : applyDeadline // ignore: cast_nullable_to_non_nullable
as DateTime,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,poster: null == poster ? _self.poster : poster // ignore: cast_nullable_to_non_nullable
as PosterSummary,publicQuestionsCount: null == publicQuestionsCount ? _self.publicQuestionsCount : publicQuestionsCount // ignore: cast_nullable_to_non_nullable
as int,alreadyApplied: null == alreadyApplied ? _self.alreadyApplied : alreadyApplied // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of Mission
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PosterSummaryCopyWith<$Res> get poster {
  
  return $PosterSummaryCopyWith<$Res>(_self.poster, (value) {
    return _then(_self.copyWith(poster: value));
  });
}
}


/// Adds pattern-matching-related methods to [Mission].
extension MissionPatterns on Mission {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Mission value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Mission() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Mission value)  $default,){
final _that = this;
switch (_that) {
case _Mission():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Mission value)?  $default,){
final _that = this;
switch (_that) {
case _Mission() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  MissionCategory category,  String city,  DateTime startAt,  int durationMinutes,  int payAmount,  int slotsTotal,  int slotsFree,  String description,  DateTime applyDeadline,  DateTime publishedAt,  PosterSummary poster,  int publicQuestionsCount,  bool alreadyApplied)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Mission() when $default != null:
return $default(_that.id,_that.title,_that.category,_that.city,_that.startAt,_that.durationMinutes,_that.payAmount,_that.slotsTotal,_that.slotsFree,_that.description,_that.applyDeadline,_that.publishedAt,_that.poster,_that.publicQuestionsCount,_that.alreadyApplied);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  MissionCategory category,  String city,  DateTime startAt,  int durationMinutes,  int payAmount,  int slotsTotal,  int slotsFree,  String description,  DateTime applyDeadline,  DateTime publishedAt,  PosterSummary poster,  int publicQuestionsCount,  bool alreadyApplied)  $default,) {final _that = this;
switch (_that) {
case _Mission():
return $default(_that.id,_that.title,_that.category,_that.city,_that.startAt,_that.durationMinutes,_that.payAmount,_that.slotsTotal,_that.slotsFree,_that.description,_that.applyDeadline,_that.publishedAt,_that.poster,_that.publicQuestionsCount,_that.alreadyApplied);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  MissionCategory category,  String city,  DateTime startAt,  int durationMinutes,  int payAmount,  int slotsTotal,  int slotsFree,  String description,  DateTime applyDeadline,  DateTime publishedAt,  PosterSummary poster,  int publicQuestionsCount,  bool alreadyApplied)?  $default,) {final _that = this;
switch (_that) {
case _Mission() when $default != null:
return $default(_that.id,_that.title,_that.category,_that.city,_that.startAt,_that.durationMinutes,_that.payAmount,_that.slotsTotal,_that.slotsFree,_that.description,_that.applyDeadline,_that.publishedAt,_that.poster,_that.publicQuestionsCount,_that.alreadyApplied);case _:
  return null;

}
}

}

/// @nodoc


class _Mission extends Mission {
  const _Mission({required this.id, required this.title, required this.category, required this.city, required this.startAt, required this.durationMinutes, required this.payAmount, required this.slotsTotal, required this.slotsFree, required this.description, required this.applyDeadline, required this.publishedAt, required this.poster, required this.publicQuestionsCount, required this.alreadyApplied}): super._();
  

@override final  String id;
@override final  String title;
@override final  MissionCategory category;
@override final  String city;
@override final  DateTime startAt;
@override final  int durationMinutes;
@override final  int payAmount;
@override final  int slotsTotal;
@override final  int slotsFree;
@override final  String description;
@override final  DateTime applyDeadline;
@override final  DateTime publishedAt;
@override final  PosterSummary poster;
@override final  int publicQuestionsCount;
@override final  bool alreadyApplied;

/// Create a copy of Mission
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MissionCopyWith<_Mission> get copyWith => __$MissionCopyWithImpl<_Mission>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Mission&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.category, category) || other.category == category)&&(identical(other.city, city) || other.city == city)&&(identical(other.startAt, startAt) || other.startAt == startAt)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.payAmount, payAmount) || other.payAmount == payAmount)&&(identical(other.slotsTotal, slotsTotal) || other.slotsTotal == slotsTotal)&&(identical(other.slotsFree, slotsFree) || other.slotsFree == slotsFree)&&(identical(other.description, description) || other.description == description)&&(identical(other.applyDeadline, applyDeadline) || other.applyDeadline == applyDeadline)&&(identical(other.publishedAt, publishedAt) || other.publishedAt == publishedAt)&&(identical(other.poster, poster) || other.poster == poster)&&(identical(other.publicQuestionsCount, publicQuestionsCount) || other.publicQuestionsCount == publicQuestionsCount)&&(identical(other.alreadyApplied, alreadyApplied) || other.alreadyApplied == alreadyApplied));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,category,city,startAt,durationMinutes,payAmount,slotsTotal,slotsFree,description,applyDeadline,publishedAt,poster,publicQuestionsCount,alreadyApplied);

@override
String toString() {
  return 'Mission(id: $id, title: $title, category: $category, city: $city, startAt: $startAt, durationMinutes: $durationMinutes, payAmount: $payAmount, slotsTotal: $slotsTotal, slotsFree: $slotsFree, description: $description, applyDeadline: $applyDeadline, publishedAt: $publishedAt, poster: $poster, publicQuestionsCount: $publicQuestionsCount, alreadyApplied: $alreadyApplied)';
}


}

/// @nodoc
abstract mixin class _$MissionCopyWith<$Res> implements $MissionCopyWith<$Res> {
  factory _$MissionCopyWith(_Mission value, $Res Function(_Mission) _then) = __$MissionCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, MissionCategory category, String city, DateTime startAt, int durationMinutes, int payAmount, int slotsTotal, int slotsFree, String description, DateTime applyDeadline, DateTime publishedAt, PosterSummary poster, int publicQuestionsCount, bool alreadyApplied
});


@override $PosterSummaryCopyWith<$Res> get poster;

}
/// @nodoc
class __$MissionCopyWithImpl<$Res>
    implements _$MissionCopyWith<$Res> {
  __$MissionCopyWithImpl(this._self, this._then);

  final _Mission _self;
  final $Res Function(_Mission) _then;

/// Create a copy of Mission
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? category = null,Object? city = null,Object? startAt = null,Object? durationMinutes = null,Object? payAmount = null,Object? slotsTotal = null,Object? slotsFree = null,Object? description = null,Object? applyDeadline = null,Object? publishedAt = null,Object? poster = null,Object? publicQuestionsCount = null,Object? alreadyApplied = null,}) {
  return _then(_Mission(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as MissionCategory,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,startAt: null == startAt ? _self.startAt : startAt // ignore: cast_nullable_to_non_nullable
as DateTime,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,payAmount: null == payAmount ? _self.payAmount : payAmount // ignore: cast_nullable_to_non_nullable
as int,slotsTotal: null == slotsTotal ? _self.slotsTotal : slotsTotal // ignore: cast_nullable_to_non_nullable
as int,slotsFree: null == slotsFree ? _self.slotsFree : slotsFree // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,applyDeadline: null == applyDeadline ? _self.applyDeadline : applyDeadline // ignore: cast_nullable_to_non_nullable
as DateTime,publishedAt: null == publishedAt ? _self.publishedAt : publishedAt // ignore: cast_nullable_to_non_nullable
as DateTime,poster: null == poster ? _self.poster : poster // ignore: cast_nullable_to_non_nullable
as PosterSummary,publicQuestionsCount: null == publicQuestionsCount ? _self.publicQuestionsCount : publicQuestionsCount // ignore: cast_nullable_to_non_nullable
as int,alreadyApplied: null == alreadyApplied ? _self.alreadyApplied : alreadyApplied // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of Mission
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PosterSummaryCopyWith<$Res> get poster {
  
  return $PosterSummaryCopyWith<$Res>(_self.poster, (value) {
    return _then(_self.copyWith(poster: value));
  });
}
}

/// @nodoc
mixin _$PosterSummary {

 String get id; String get displayName; String get initials; bool get verified; double get rating; int get avgValidationHours;
/// Create a copy of PosterSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PosterSummaryCopyWith<PosterSummary> get copyWith => _$PosterSummaryCopyWithImpl<PosterSummary>(this as PosterSummary, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PosterSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.initials, initials) || other.initials == initials)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.avgValidationHours, avgValidationHours) || other.avgValidationHours == avgValidationHours));
}


@override
int get hashCode => Object.hash(runtimeType,id,displayName,initials,verified,rating,avgValidationHours);

@override
String toString() {
  return 'PosterSummary(id: $id, displayName: $displayName, initials: $initials, verified: $verified, rating: $rating, avgValidationHours: $avgValidationHours)';
}


}

/// @nodoc
abstract mixin class $PosterSummaryCopyWith<$Res>  {
  factory $PosterSummaryCopyWith(PosterSummary value, $Res Function(PosterSummary) _then) = _$PosterSummaryCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, String initials, bool verified, double rating, int avgValidationHours
});




}
/// @nodoc
class _$PosterSummaryCopyWithImpl<$Res>
    implements $PosterSummaryCopyWith<$Res> {
  _$PosterSummaryCopyWithImpl(this._self, this._then);

  final PosterSummary _self;
  final $Res Function(PosterSummary) _then;

/// Create a copy of PosterSummary
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


/// Adds pattern-matching-related methods to [PosterSummary].
extension PosterSummaryPatterns on PosterSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PosterSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PosterSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PosterSummary value)  $default,){
final _that = this;
switch (_that) {
case _PosterSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PosterSummary value)?  $default,){
final _that = this;
switch (_that) {
case _PosterSummary() when $default != null:
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
case _PosterSummary() when $default != null:
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
case _PosterSummary():
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
case _PosterSummary() when $default != null:
return $default(_that.id,_that.displayName,_that.initials,_that.verified,_that.rating,_that.avgValidationHours);case _:
  return null;

}
}

}

/// @nodoc


class _PosterSummary implements PosterSummary {
  const _PosterSummary({required this.id, required this.displayName, required this.initials, required this.verified, required this.rating, required this.avgValidationHours});
  

@override final  String id;
@override final  String displayName;
@override final  String initials;
@override final  bool verified;
@override final  double rating;
@override final  int avgValidationHours;

/// Create a copy of PosterSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PosterSummaryCopyWith<_PosterSummary> get copyWith => __$PosterSummaryCopyWithImpl<_PosterSummary>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PosterSummary&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.initials, initials) || other.initials == initials)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.avgValidationHours, avgValidationHours) || other.avgValidationHours == avgValidationHours));
}


@override
int get hashCode => Object.hash(runtimeType,id,displayName,initials,verified,rating,avgValidationHours);

@override
String toString() {
  return 'PosterSummary(id: $id, displayName: $displayName, initials: $initials, verified: $verified, rating: $rating, avgValidationHours: $avgValidationHours)';
}


}

/// @nodoc
abstract mixin class _$PosterSummaryCopyWith<$Res> implements $PosterSummaryCopyWith<$Res> {
  factory _$PosterSummaryCopyWith(_PosterSummary value, $Res Function(_PosterSummary) _then) = __$PosterSummaryCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, String initials, bool verified, double rating, int avgValidationHours
});




}
/// @nodoc
class __$PosterSummaryCopyWithImpl<$Res>
    implements _$PosterSummaryCopyWith<$Res> {
  __$PosterSummaryCopyWithImpl(this._self, this._then);

  final _PosterSummary _self;
  final $Res Function(_PosterSummary) _then;

/// Create a copy of PosterSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? initials = null,Object? verified = null,Object? rating = null,Object? avgValidationHours = null,}) {
  return _then(_PosterSummary(
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
