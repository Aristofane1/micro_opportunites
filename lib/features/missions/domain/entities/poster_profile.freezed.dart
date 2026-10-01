// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poster_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PosterProfile {

 String get id; String get displayName; String get initials; bool get verified; bool get reliable; String get city; DateTime get memberSince; double get rating; int get reviewsCount; int get paidMissions; int get avgValidationHours; List<Review> get reviews;
/// Create a copy of PosterProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PosterProfileCopyWith<PosterProfile> get copyWith => _$PosterProfileCopyWithImpl<PosterProfile>(this as PosterProfile, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PosterProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.initials, initials) || other.initials == initials)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.reliable, reliable) || other.reliable == reliable)&&(identical(other.city, city) || other.city == city)&&(identical(other.memberSince, memberSince) || other.memberSince == memberSince)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.paidMissions, paidMissions) || other.paidMissions == paidMissions)&&(identical(other.avgValidationHours, avgValidationHours) || other.avgValidationHours == avgValidationHours)&&const DeepCollectionEquality().equals(other.reviews, reviews));
}


@override
int get hashCode => Object.hash(runtimeType,id,displayName,initials,verified,reliable,city,memberSince,rating,reviewsCount,paidMissions,avgValidationHours,const DeepCollectionEquality().hash(reviews));

@override
String toString() {
  return 'PosterProfile(id: $id, displayName: $displayName, initials: $initials, verified: $verified, reliable: $reliable, city: $city, memberSince: $memberSince, rating: $rating, reviewsCount: $reviewsCount, paidMissions: $paidMissions, avgValidationHours: $avgValidationHours, reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class $PosterProfileCopyWith<$Res>  {
  factory $PosterProfileCopyWith(PosterProfile value, $Res Function(PosterProfile) _then) = _$PosterProfileCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, String initials, bool verified, bool reliable, String city, DateTime memberSince, double rating, int reviewsCount, int paidMissions, int avgValidationHours, List<Review> reviews
});




}
/// @nodoc
class _$PosterProfileCopyWithImpl<$Res>
    implements $PosterProfileCopyWith<$Res> {
  _$PosterProfileCopyWithImpl(this._self, this._then);

  final PosterProfile _self;
  final $Res Function(PosterProfile) _then;

/// Create a copy of PosterProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = null,Object? initials = null,Object? verified = null,Object? reliable = null,Object? city = null,Object? memberSince = null,Object? rating = null,Object? reviewsCount = null,Object? paidMissions = null,Object? avgValidationHours = null,Object? reviews = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,initials: null == initials ? _self.initials : initials // ignore: cast_nullable_to_non_nullable
as String,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,reliable: null == reliable ? _self.reliable : reliable // ignore: cast_nullable_to_non_nullable
as bool,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,memberSince: null == memberSince ? _self.memberSince : memberSince // ignore: cast_nullable_to_non_nullable
as DateTime,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,paidMissions: null == paidMissions ? _self.paidMissions : paidMissions // ignore: cast_nullable_to_non_nullable
as int,avgValidationHours: null == avgValidationHours ? _self.avgValidationHours : avgValidationHours // ignore: cast_nullable_to_non_nullable
as int,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,
  ));
}

}


/// Adds pattern-matching-related methods to [PosterProfile].
extension PosterProfilePatterns on PosterProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PosterProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PosterProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PosterProfile value)  $default,){
final _that = this;
switch (_that) {
case _PosterProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PosterProfile value)?  $default,){
final _that = this;
switch (_that) {
case _PosterProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  String initials,  bool verified,  bool reliable,  String city,  DateTime memberSince,  double rating,  int reviewsCount,  int paidMissions,  int avgValidationHours,  List<Review> reviews)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PosterProfile() when $default != null:
return $default(_that.id,_that.displayName,_that.initials,_that.verified,_that.reliable,_that.city,_that.memberSince,_that.rating,_that.reviewsCount,_that.paidMissions,_that.avgValidationHours,_that.reviews);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  String initials,  bool verified,  bool reliable,  String city,  DateTime memberSince,  double rating,  int reviewsCount,  int paidMissions,  int avgValidationHours,  List<Review> reviews)  $default,) {final _that = this;
switch (_that) {
case _PosterProfile():
return $default(_that.id,_that.displayName,_that.initials,_that.verified,_that.reliable,_that.city,_that.memberSince,_that.rating,_that.reviewsCount,_that.paidMissions,_that.avgValidationHours,_that.reviews);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  String initials,  bool verified,  bool reliable,  String city,  DateTime memberSince,  double rating,  int reviewsCount,  int paidMissions,  int avgValidationHours,  List<Review> reviews)?  $default,) {final _that = this;
switch (_that) {
case _PosterProfile() when $default != null:
return $default(_that.id,_that.displayName,_that.initials,_that.verified,_that.reliable,_that.city,_that.memberSince,_that.rating,_that.reviewsCount,_that.paidMissions,_that.avgValidationHours,_that.reviews);case _:
  return null;

}
}

}

/// @nodoc


class _PosterProfile implements PosterProfile {
  const _PosterProfile({required this.id, required this.displayName, required this.initials, required this.verified, required this.reliable, required this.city, required this.memberSince, required this.rating, required this.reviewsCount, required this.paidMissions, required this.avgValidationHours, required final  List<Review> reviews}): _reviews = reviews;
  

@override final  String id;
@override final  String displayName;
@override final  String initials;
@override final  bool verified;
@override final  bool reliable;
@override final  String city;
@override final  DateTime memberSince;
@override final  double rating;
@override final  int reviewsCount;
@override final  int paidMissions;
@override final  int avgValidationHours;
 final  List<Review> _reviews;
@override List<Review> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}


/// Create a copy of PosterProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PosterProfileCopyWith<_PosterProfile> get copyWith => __$PosterProfileCopyWithImpl<_PosterProfile>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PosterProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.initials, initials) || other.initials == initials)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.reliable, reliable) || other.reliable == reliable)&&(identical(other.city, city) || other.city == city)&&(identical(other.memberSince, memberSince) || other.memberSince == memberSince)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.paidMissions, paidMissions) || other.paidMissions == paidMissions)&&(identical(other.avgValidationHours, avgValidationHours) || other.avgValidationHours == avgValidationHours)&&const DeepCollectionEquality().equals(other._reviews, _reviews));
}


@override
int get hashCode => Object.hash(runtimeType,id,displayName,initials,verified,reliable,city,memberSince,rating,reviewsCount,paidMissions,avgValidationHours,const DeepCollectionEquality().hash(_reviews));

@override
String toString() {
  return 'PosterProfile(id: $id, displayName: $displayName, initials: $initials, verified: $verified, reliable: $reliable, city: $city, memberSince: $memberSince, rating: $rating, reviewsCount: $reviewsCount, paidMissions: $paidMissions, avgValidationHours: $avgValidationHours, reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class _$PosterProfileCopyWith<$Res> implements $PosterProfileCopyWith<$Res> {
  factory _$PosterProfileCopyWith(_PosterProfile value, $Res Function(_PosterProfile) _then) = __$PosterProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, String initials, bool verified, bool reliable, String city, DateTime memberSince, double rating, int reviewsCount, int paidMissions, int avgValidationHours, List<Review> reviews
});




}
/// @nodoc
class __$PosterProfileCopyWithImpl<$Res>
    implements _$PosterProfileCopyWith<$Res> {
  __$PosterProfileCopyWithImpl(this._self, this._then);

  final _PosterProfile _self;
  final $Res Function(_PosterProfile) _then;

/// Create a copy of PosterProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? initials = null,Object? verified = null,Object? reliable = null,Object? city = null,Object? memberSince = null,Object? rating = null,Object? reviewsCount = null,Object? paidMissions = null,Object? avgValidationHours = null,Object? reviews = null,}) {
  return _then(_PosterProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,initials: null == initials ? _self.initials : initials // ignore: cast_nullable_to_non_nullable
as String,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,reliable: null == reliable ? _self.reliable : reliable // ignore: cast_nullable_to_non_nullable
as bool,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,memberSince: null == memberSince ? _self.memberSince : memberSince // ignore: cast_nullable_to_non_nullable
as DateTime,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,paidMissions: null == paidMissions ? _self.paidMissions : paidMissions // ignore: cast_nullable_to_non_nullable
as int,avgValidationHours: null == avgValidationHours ? _self.avgValidationHours : avgValidationHours // ignore: cast_nullable_to_non_nullable
as int,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,
  ));
}


}

/// @nodoc
mixin _$Review {

 String get authorName; int get stars; String get comment; String get context; DateTime get date; String? get reply;
/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewCopyWith<Review> get copyWith => _$ReviewCopyWithImpl<Review>(this as Review, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Review&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.stars, stars) || other.stars == stars)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.context, context) || other.context == context)&&(identical(other.date, date) || other.date == date)&&(identical(other.reply, reply) || other.reply == reply));
}


@override
int get hashCode => Object.hash(runtimeType,authorName,stars,comment,context,date,reply);

@override
String toString() {
  return 'Review(authorName: $authorName, stars: $stars, comment: $comment, context: $context, date: $date, reply: $reply)';
}


}

/// @nodoc
abstract mixin class $ReviewCopyWith<$Res>  {
  factory $ReviewCopyWith(Review value, $Res Function(Review) _then) = _$ReviewCopyWithImpl;
@useResult
$Res call({
 String authorName, int stars, String comment, String context, DateTime date, String? reply
});




}
/// @nodoc
class _$ReviewCopyWithImpl<$Res>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._self, this._then);

  final Review _self;
  final $Res Function(Review) _then;

/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? authorName = null,Object? stars = null,Object? comment = null,Object? context = null,Object? date = null,Object? reply = freezed,}) {
  return _then(_self.copyWith(
authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,stars: null == stars ? _self.stars : stars // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,reply: freezed == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Review].
extension ReviewPatterns on Review {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Review value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Review() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Review value)  $default,){
final _that = this;
switch (_that) {
case _Review():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Review value)?  $default,){
final _that = this;
switch (_that) {
case _Review() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String authorName,  int stars,  String comment,  String context,  DateTime date,  String? reply)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Review() when $default != null:
return $default(_that.authorName,_that.stars,_that.comment,_that.context,_that.date,_that.reply);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String authorName,  int stars,  String comment,  String context,  DateTime date,  String? reply)  $default,) {final _that = this;
switch (_that) {
case _Review():
return $default(_that.authorName,_that.stars,_that.comment,_that.context,_that.date,_that.reply);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String authorName,  int stars,  String comment,  String context,  DateTime date,  String? reply)?  $default,) {final _that = this;
switch (_that) {
case _Review() when $default != null:
return $default(_that.authorName,_that.stars,_that.comment,_that.context,_that.date,_that.reply);case _:
  return null;

}
}

}

/// @nodoc


class _Review implements Review {
  const _Review({required this.authorName, required this.stars, required this.comment, required this.context, required this.date, this.reply});
  

@override final  String authorName;
@override final  int stars;
@override final  String comment;
@override final  String context;
@override final  DateTime date;
@override final  String? reply;

/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewCopyWith<_Review> get copyWith => __$ReviewCopyWithImpl<_Review>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Review&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.stars, stars) || other.stars == stars)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.context, context) || other.context == context)&&(identical(other.date, date) || other.date == date)&&(identical(other.reply, reply) || other.reply == reply));
}


@override
int get hashCode => Object.hash(runtimeType,authorName,stars,comment,context,date,reply);

@override
String toString() {
  return 'Review(authorName: $authorName, stars: $stars, comment: $comment, context: $context, date: $date, reply: $reply)';
}


}

/// @nodoc
abstract mixin class _$ReviewCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$ReviewCopyWith(_Review value, $Res Function(_Review) _then) = __$ReviewCopyWithImpl;
@override @useResult
$Res call({
 String authorName, int stars, String comment, String context, DateTime date, String? reply
});




}
/// @nodoc
class __$ReviewCopyWithImpl<$Res>
    implements _$ReviewCopyWith<$Res> {
  __$ReviewCopyWithImpl(this._self, this._then);

  final _Review _self;
  final $Res Function(_Review) _then;

/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? authorName = null,Object? stars = null,Object? comment = null,Object? context = null,Object? date = null,Object? reply = freezed,}) {
  return _then(_Review(
authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,stars: null == stars ? _self.stars : stars // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,reply: freezed == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
