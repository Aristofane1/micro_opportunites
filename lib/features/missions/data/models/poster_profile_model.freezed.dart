// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'poster_profile_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PosterProfileModel {

 String get id; String get displayName; String get initials; bool get verified; bool get reliable; String get city; String get memberSince; double get rating; int get reviewsCount; int get paidMissions; int get avgValidationHours; List<ReviewModel> get reviews;
/// Create a copy of PosterProfileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PosterProfileModelCopyWith<PosterProfileModel> get copyWith => _$PosterProfileModelCopyWithImpl<PosterProfileModel>(this as PosterProfileModel, _$identity);

  /// Serializes this PosterProfileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PosterProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.initials, initials) || other.initials == initials)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.reliable, reliable) || other.reliable == reliable)&&(identical(other.city, city) || other.city == city)&&(identical(other.memberSince, memberSince) || other.memberSince == memberSince)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.paidMissions, paidMissions) || other.paidMissions == paidMissions)&&(identical(other.avgValidationHours, avgValidationHours) || other.avgValidationHours == avgValidationHours)&&const DeepCollectionEquality().equals(other.reviews, reviews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,initials,verified,reliable,city,memberSince,rating,reviewsCount,paidMissions,avgValidationHours,const DeepCollectionEquality().hash(reviews));

@override
String toString() {
  return 'PosterProfileModel(id: $id, displayName: $displayName, initials: $initials, verified: $verified, reliable: $reliable, city: $city, memberSince: $memberSince, rating: $rating, reviewsCount: $reviewsCount, paidMissions: $paidMissions, avgValidationHours: $avgValidationHours, reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class $PosterProfileModelCopyWith<$Res>  {
  factory $PosterProfileModelCopyWith(PosterProfileModel value, $Res Function(PosterProfileModel) _then) = _$PosterProfileModelCopyWithImpl;
@useResult
$Res call({
 String id, String displayName, String initials, bool verified, bool reliable, String city, String memberSince, double rating, int reviewsCount, int paidMissions, int avgValidationHours, List<ReviewModel> reviews
});




}
/// @nodoc
class _$PosterProfileModelCopyWithImpl<$Res>
    implements $PosterProfileModelCopyWith<$Res> {
  _$PosterProfileModelCopyWithImpl(this._self, this._then);

  final PosterProfileModel _self;
  final $Res Function(PosterProfileModel) _then;

/// Create a copy of PosterProfileModel
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
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,paidMissions: null == paidMissions ? _self.paidMissions : paidMissions // ignore: cast_nullable_to_non_nullable
as int,avgValidationHours: null == avgValidationHours ? _self.avgValidationHours : avgValidationHours // ignore: cast_nullable_to_non_nullable
as int,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<ReviewModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [PosterProfileModel].
extension PosterProfileModelPatterns on PosterProfileModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PosterProfileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PosterProfileModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PosterProfileModel value)  $default,){
final _that = this;
switch (_that) {
case _PosterProfileModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PosterProfileModel value)?  $default,){
final _that = this;
switch (_that) {
case _PosterProfileModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String displayName,  String initials,  bool verified,  bool reliable,  String city,  String memberSince,  double rating,  int reviewsCount,  int paidMissions,  int avgValidationHours,  List<ReviewModel> reviews)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PosterProfileModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String displayName,  String initials,  bool verified,  bool reliable,  String city,  String memberSince,  double rating,  int reviewsCount,  int paidMissions,  int avgValidationHours,  List<ReviewModel> reviews)  $default,) {final _that = this;
switch (_that) {
case _PosterProfileModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String displayName,  String initials,  bool verified,  bool reliable,  String city,  String memberSince,  double rating,  int reviewsCount,  int paidMissions,  int avgValidationHours,  List<ReviewModel> reviews)?  $default,) {final _that = this;
switch (_that) {
case _PosterProfileModel() when $default != null:
return $default(_that.id,_that.displayName,_that.initials,_that.verified,_that.reliable,_that.city,_that.memberSince,_that.rating,_that.reviewsCount,_that.paidMissions,_that.avgValidationHours,_that.reviews);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PosterProfileModel extends PosterProfileModel {
  const _PosterProfileModel({required this.id, required this.displayName, required this.initials, required this.verified, required this.reliable, required this.city, required this.memberSince, required this.rating, required this.reviewsCount, required this.paidMissions, required this.avgValidationHours, required final  List<ReviewModel> reviews}): _reviews = reviews,super._();
  factory _PosterProfileModel.fromJson(Map<String, dynamic> json) => _$PosterProfileModelFromJson(json);

@override final  String id;
@override final  String displayName;
@override final  String initials;
@override final  bool verified;
@override final  bool reliable;
@override final  String city;
@override final  String memberSince;
@override final  double rating;
@override final  int reviewsCount;
@override final  int paidMissions;
@override final  int avgValidationHours;
 final  List<ReviewModel> _reviews;
@override List<ReviewModel> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}


/// Create a copy of PosterProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PosterProfileModelCopyWith<_PosterProfileModel> get copyWith => __$PosterProfileModelCopyWithImpl<_PosterProfileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PosterProfileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PosterProfileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.initials, initials) || other.initials == initials)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.reliable, reliable) || other.reliable == reliable)&&(identical(other.city, city) || other.city == city)&&(identical(other.memberSince, memberSince) || other.memberSince == memberSince)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.paidMissions, paidMissions) || other.paidMissions == paidMissions)&&(identical(other.avgValidationHours, avgValidationHours) || other.avgValidationHours == avgValidationHours)&&const DeepCollectionEquality().equals(other._reviews, _reviews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,initials,verified,reliable,city,memberSince,rating,reviewsCount,paidMissions,avgValidationHours,const DeepCollectionEquality().hash(_reviews));

@override
String toString() {
  return 'PosterProfileModel(id: $id, displayName: $displayName, initials: $initials, verified: $verified, reliable: $reliable, city: $city, memberSince: $memberSince, rating: $rating, reviewsCount: $reviewsCount, paidMissions: $paidMissions, avgValidationHours: $avgValidationHours, reviews: $reviews)';
}


}

/// @nodoc
abstract mixin class _$PosterProfileModelCopyWith<$Res> implements $PosterProfileModelCopyWith<$Res> {
  factory _$PosterProfileModelCopyWith(_PosterProfileModel value, $Res Function(_PosterProfileModel) _then) = __$PosterProfileModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String displayName, String initials, bool verified, bool reliable, String city, String memberSince, double rating, int reviewsCount, int paidMissions, int avgValidationHours, List<ReviewModel> reviews
});




}
/// @nodoc
class __$PosterProfileModelCopyWithImpl<$Res>
    implements _$PosterProfileModelCopyWith<$Res> {
  __$PosterProfileModelCopyWithImpl(this._self, this._then);

  final _PosterProfileModel _self;
  final $Res Function(_PosterProfileModel) _then;

/// Create a copy of PosterProfileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = null,Object? initials = null,Object? verified = null,Object? reliable = null,Object? city = null,Object? memberSince = null,Object? rating = null,Object? reviewsCount = null,Object? paidMissions = null,Object? avgValidationHours = null,Object? reviews = null,}) {
  return _then(_PosterProfileModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,initials: null == initials ? _self.initials : initials // ignore: cast_nullable_to_non_nullable
as String,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,reliable: null == reliable ? _self.reliable : reliable // ignore: cast_nullable_to_non_nullable
as bool,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,memberSince: null == memberSince ? _self.memberSince : memberSince // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,paidMissions: null == paidMissions ? _self.paidMissions : paidMissions // ignore: cast_nullable_to_non_nullable
as int,avgValidationHours: null == avgValidationHours ? _self.avgValidationHours : avgValidationHours // ignore: cast_nullable_to_non_nullable
as int,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<ReviewModel>,
  ));
}


}


/// @nodoc
mixin _$ReviewModel {

 String get authorName; int get stars; String get comment; String get context; String get date; String? get reply;
/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewModelCopyWith<ReviewModel> get copyWith => _$ReviewModelCopyWithImpl<ReviewModel>(this as ReviewModel, _$identity);

  /// Serializes this ReviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewModel&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.stars, stars) || other.stars == stars)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.context, context) || other.context == context)&&(identical(other.date, date) || other.date == date)&&(identical(other.reply, reply) || other.reply == reply));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authorName,stars,comment,context,date,reply);

@override
String toString() {
  return 'ReviewModel(authorName: $authorName, stars: $stars, comment: $comment, context: $context, date: $date, reply: $reply)';
}


}

/// @nodoc
abstract mixin class $ReviewModelCopyWith<$Res>  {
  factory $ReviewModelCopyWith(ReviewModel value, $Res Function(ReviewModel) _then) = _$ReviewModelCopyWithImpl;
@useResult
$Res call({
 String authorName, int stars, String comment, String context, String date, String? reply
});




}
/// @nodoc
class _$ReviewModelCopyWithImpl<$Res>
    implements $ReviewModelCopyWith<$Res> {
  _$ReviewModelCopyWithImpl(this._self, this._then);

  final ReviewModel _self;
  final $Res Function(ReviewModel) _then;

/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? authorName = null,Object? stars = null,Object? comment = null,Object? context = null,Object? date = null,Object? reply = freezed,}) {
  return _then(_self.copyWith(
authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,stars: null == stars ? _self.stars : stars // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,reply: freezed == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReviewModel].
extension ReviewModelPatterns on ReviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReviewModel value)  $default,){
final _that = this;
switch (_that) {
case _ReviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String authorName,  int stars,  String comment,  String context,  String date,  String? reply)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String authorName,  int stars,  String comment,  String context,  String date,  String? reply)  $default,) {final _that = this;
switch (_that) {
case _ReviewModel():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String authorName,  int stars,  String comment,  String context,  String date,  String? reply)?  $default,) {final _that = this;
switch (_that) {
case _ReviewModel() when $default != null:
return $default(_that.authorName,_that.stars,_that.comment,_that.context,_that.date,_that.reply);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReviewModel extends ReviewModel {
  const _ReviewModel({required this.authorName, required this.stars, required this.comment, required this.context, required this.date, this.reply}): super._();
  factory _ReviewModel.fromJson(Map<String, dynamic> json) => _$ReviewModelFromJson(json);

@override final  String authorName;
@override final  int stars;
@override final  String comment;
@override final  String context;
@override final  String date;
@override final  String? reply;

/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewModelCopyWith<_ReviewModel> get copyWith => __$ReviewModelCopyWithImpl<_ReviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewModel&&(identical(other.authorName, authorName) || other.authorName == authorName)&&(identical(other.stars, stars) || other.stars == stars)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.context, context) || other.context == context)&&(identical(other.date, date) || other.date == date)&&(identical(other.reply, reply) || other.reply == reply));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authorName,stars,comment,context,date,reply);

@override
String toString() {
  return 'ReviewModel(authorName: $authorName, stars: $stars, comment: $comment, context: $context, date: $date, reply: $reply)';
}


}

/// @nodoc
abstract mixin class _$ReviewModelCopyWith<$Res> implements $ReviewModelCopyWith<$Res> {
  factory _$ReviewModelCopyWith(_ReviewModel value, $Res Function(_ReviewModel) _then) = __$ReviewModelCopyWithImpl;
@override @useResult
$Res call({
 String authorName, int stars, String comment, String context, String date, String? reply
});




}
/// @nodoc
class __$ReviewModelCopyWithImpl<$Res>
    implements _$ReviewModelCopyWith<$Res> {
  __$ReviewModelCopyWithImpl(this._self, this._then);

  final _ReviewModel _self;
  final $Res Function(_ReviewModel) _then;

/// Create a copy of ReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? authorName = null,Object? stars = null,Object? comment = null,Object? context = null,Object? date = null,Object? reply = freezed,}) {
  return _then(_ReviewModel(
authorName: null == authorName ? _self.authorName : authorName // ignore: cast_nullable_to_non_nullable
as String,stars: null == stars ? _self.stars : stars // ignore: cast_nullable_to_non_nullable
as int,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,context: null == context ? _self.context : context // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,reply: freezed == reply ? _self.reply : reply // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
