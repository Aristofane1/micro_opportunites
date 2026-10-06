// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candidate_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CandidateModel {

 String get id; String get name; String get city; String? get memberSince; String? get pitch; List<String> get skills; bool get verified; bool get isExpert; double? get rating; int get reviewsCount; int get missionsCount; int? get reliability; int get absences; List<DoneMissionModel> get doneMissions; CandidateReviewModel? get review; String get status; String get attendance; String? get assignmentId; String? get arrivedAt; String? get finishedAt; String? get autoPayAt; int? get distanceMeters; int get proofPhotos; String? get completionNote; String? get offerExpiresAt;
/// Create a copy of CandidateModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandidateModelCopyWith<CandidateModel> get copyWith => _$CandidateModelCopyWithImpl<CandidateModel>(this as CandidateModel, _$identity);

  /// Serializes this CandidateModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandidateModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city)&&(identical(other.memberSince, memberSince) || other.memberSince == memberSince)&&(identical(other.pitch, pitch) || other.pitch == pitch)&&const DeepCollectionEquality().equals(other.skills, skills)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.isExpert, isExpert) || other.isExpert == isExpert)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.missionsCount, missionsCount) || other.missionsCount == missionsCount)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&(identical(other.absences, absences) || other.absences == absences)&&const DeepCollectionEquality().equals(other.doneMissions, doneMissions)&&(identical(other.review, review) || other.review == review)&&(identical(other.status, status) || other.status == status)&&(identical(other.attendance, attendance) || other.attendance == attendance)&&(identical(other.assignmentId, assignmentId) || other.assignmentId == assignmentId)&&(identical(other.arrivedAt, arrivedAt) || other.arrivedAt == arrivedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.autoPayAt, autoPayAt) || other.autoPayAt == autoPayAt)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.proofPhotos, proofPhotos) || other.proofPhotos == proofPhotos)&&(identical(other.completionNote, completionNote) || other.completionNote == completionNote)&&(identical(other.offerExpiresAt, offerExpiresAt) || other.offerExpiresAt == offerExpiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,city,memberSince,pitch,const DeepCollectionEquality().hash(skills),verified,isExpert,rating,reviewsCount,missionsCount,reliability,absences,const DeepCollectionEquality().hash(doneMissions),review,status,attendance,assignmentId,arrivedAt,finishedAt,autoPayAt,distanceMeters,proofPhotos,completionNote,offerExpiresAt]);

@override
String toString() {
  return 'CandidateModel(id: $id, name: $name, city: $city, memberSince: $memberSince, pitch: $pitch, skills: $skills, verified: $verified, isExpert: $isExpert, rating: $rating, reviewsCount: $reviewsCount, missionsCount: $missionsCount, reliability: $reliability, absences: $absences, doneMissions: $doneMissions, review: $review, status: $status, attendance: $attendance, assignmentId: $assignmentId, arrivedAt: $arrivedAt, finishedAt: $finishedAt, autoPayAt: $autoPayAt, distanceMeters: $distanceMeters, proofPhotos: $proofPhotos, completionNote: $completionNote, offerExpiresAt: $offerExpiresAt)';
}


}

/// @nodoc
abstract mixin class $CandidateModelCopyWith<$Res>  {
  factory $CandidateModelCopyWith(CandidateModel value, $Res Function(CandidateModel) _then) = _$CandidateModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String city, String? memberSince, String? pitch, List<String> skills, bool verified, bool isExpert, double? rating, int reviewsCount, int missionsCount, int? reliability, int absences, List<DoneMissionModel> doneMissions, CandidateReviewModel? review, String status, String attendance, String? assignmentId, String? arrivedAt, String? finishedAt, String? autoPayAt, int? distanceMeters, int proofPhotos, String? completionNote, String? offerExpiresAt
});


$CandidateReviewModelCopyWith<$Res>? get review;

}
/// @nodoc
class _$CandidateModelCopyWithImpl<$Res>
    implements $CandidateModelCopyWith<$Res> {
  _$CandidateModelCopyWithImpl(this._self, this._then);

  final CandidateModel _self;
  final $Res Function(CandidateModel) _then;

/// Create a copy of CandidateModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? city = null,Object? memberSince = freezed,Object? pitch = freezed,Object? skills = null,Object? verified = null,Object? isExpert = null,Object? rating = freezed,Object? reviewsCount = null,Object? missionsCount = null,Object? reliability = freezed,Object? absences = null,Object? doneMissions = null,Object? review = freezed,Object? status = null,Object? attendance = null,Object? assignmentId = freezed,Object? arrivedAt = freezed,Object? finishedAt = freezed,Object? autoPayAt = freezed,Object? distanceMeters = freezed,Object? proofPhotos = null,Object? completionNote = freezed,Object? offerExpiresAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,memberSince: freezed == memberSince ? _self.memberSince : memberSince // ignore: cast_nullable_to_non_nullable
as String?,pitch: freezed == pitch ? _self.pitch : pitch // ignore: cast_nullable_to_non_nullable
as String?,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,isExpert: null == isExpert ? _self.isExpert : isExpert // ignore: cast_nullable_to_non_nullable
as bool,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,missionsCount: null == missionsCount ? _self.missionsCount : missionsCount // ignore: cast_nullable_to_non_nullable
as int,reliability: freezed == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as int?,absences: null == absences ? _self.absences : absences // ignore: cast_nullable_to_non_nullable
as int,doneMissions: null == doneMissions ? _self.doneMissions : doneMissions // ignore: cast_nullable_to_non_nullable
as List<DoneMissionModel>,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as CandidateReviewModel?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,attendance: null == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as String,assignmentId: freezed == assignmentId ? _self.assignmentId : assignmentId // ignore: cast_nullable_to_non_nullable
as String?,arrivedAt: freezed == arrivedAt ? _self.arrivedAt : arrivedAt // ignore: cast_nullable_to_non_nullable
as String?,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as String?,autoPayAt: freezed == autoPayAt ? _self.autoPayAt : autoPayAt // ignore: cast_nullable_to_non_nullable
as String?,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int?,proofPhotos: null == proofPhotos ? _self.proofPhotos : proofPhotos // ignore: cast_nullable_to_non_nullable
as int,completionNote: freezed == completionNote ? _self.completionNote : completionNote // ignore: cast_nullable_to_non_nullable
as String?,offerExpiresAt: freezed == offerExpiresAt ? _self.offerExpiresAt : offerExpiresAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CandidateModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CandidateReviewModelCopyWith<$Res>? get review {
    if (_self.review == null) {
    return null;
  }

  return $CandidateReviewModelCopyWith<$Res>(_self.review!, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// Adds pattern-matching-related methods to [CandidateModel].
extension CandidateModelPatterns on CandidateModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CandidateModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CandidateModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CandidateModel value)  $default,){
final _that = this;
switch (_that) {
case _CandidateModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CandidateModel value)?  $default,){
final _that = this;
switch (_that) {
case _CandidateModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String city,  String? memberSince,  String? pitch,  List<String> skills,  bool verified,  bool isExpert,  double? rating,  int reviewsCount,  int missionsCount,  int? reliability,  int absences,  List<DoneMissionModel> doneMissions,  CandidateReviewModel? review,  String status,  String attendance,  String? assignmentId,  String? arrivedAt,  String? finishedAt,  String? autoPayAt,  int? distanceMeters,  int proofPhotos,  String? completionNote,  String? offerExpiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CandidateModel() when $default != null:
return $default(_that.id,_that.name,_that.city,_that.memberSince,_that.pitch,_that.skills,_that.verified,_that.isExpert,_that.rating,_that.reviewsCount,_that.missionsCount,_that.reliability,_that.absences,_that.doneMissions,_that.review,_that.status,_that.attendance,_that.assignmentId,_that.arrivedAt,_that.finishedAt,_that.autoPayAt,_that.distanceMeters,_that.proofPhotos,_that.completionNote,_that.offerExpiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String city,  String? memberSince,  String? pitch,  List<String> skills,  bool verified,  bool isExpert,  double? rating,  int reviewsCount,  int missionsCount,  int? reliability,  int absences,  List<DoneMissionModel> doneMissions,  CandidateReviewModel? review,  String status,  String attendance,  String? assignmentId,  String? arrivedAt,  String? finishedAt,  String? autoPayAt,  int? distanceMeters,  int proofPhotos,  String? completionNote,  String? offerExpiresAt)  $default,) {final _that = this;
switch (_that) {
case _CandidateModel():
return $default(_that.id,_that.name,_that.city,_that.memberSince,_that.pitch,_that.skills,_that.verified,_that.isExpert,_that.rating,_that.reviewsCount,_that.missionsCount,_that.reliability,_that.absences,_that.doneMissions,_that.review,_that.status,_that.attendance,_that.assignmentId,_that.arrivedAt,_that.finishedAt,_that.autoPayAt,_that.distanceMeters,_that.proofPhotos,_that.completionNote,_that.offerExpiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String city,  String? memberSince,  String? pitch,  List<String> skills,  bool verified,  bool isExpert,  double? rating,  int reviewsCount,  int missionsCount,  int? reliability,  int absences,  List<DoneMissionModel> doneMissions,  CandidateReviewModel? review,  String status,  String attendance,  String? assignmentId,  String? arrivedAt,  String? finishedAt,  String? autoPayAt,  int? distanceMeters,  int proofPhotos,  String? completionNote,  String? offerExpiresAt)?  $default,) {final _that = this;
switch (_that) {
case _CandidateModel() when $default != null:
return $default(_that.id,_that.name,_that.city,_that.memberSince,_that.pitch,_that.skills,_that.verified,_that.isExpert,_that.rating,_that.reviewsCount,_that.missionsCount,_that.reliability,_that.absences,_that.doneMissions,_that.review,_that.status,_that.attendance,_that.assignmentId,_that.arrivedAt,_that.finishedAt,_that.autoPayAt,_that.distanceMeters,_that.proofPhotos,_that.completionNote,_that.offerExpiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CandidateModel extends CandidateModel {
  const _CandidateModel({required this.id, required this.name, required this.city, this.memberSince, this.pitch, final  List<String> skills = const <String>[], this.verified = false, this.isExpert = false, this.rating, this.reviewsCount = 0, this.missionsCount = 0, this.reliability, this.absences = 0, final  List<DoneMissionModel> doneMissions = const <DoneMissionModel>[], this.review, required this.status, required this.attendance, this.assignmentId, this.arrivedAt, this.finishedAt, this.autoPayAt, this.distanceMeters, this.proofPhotos = 0, this.completionNote, this.offerExpiresAt}): _skills = skills,_doneMissions = doneMissions,super._();
  factory _CandidateModel.fromJson(Map<String, dynamic> json) => _$CandidateModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String city;
@override final  String? memberSince;
@override final  String? pitch;
 final  List<String> _skills;
@override@JsonKey() List<String> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}

@override@JsonKey() final  bool verified;
@override@JsonKey() final  bool isExpert;
@override final  double? rating;
@override@JsonKey() final  int reviewsCount;
@override@JsonKey() final  int missionsCount;
@override final  int? reliability;
@override@JsonKey() final  int absences;
 final  List<DoneMissionModel> _doneMissions;
@override@JsonKey() List<DoneMissionModel> get doneMissions {
  if (_doneMissions is EqualUnmodifiableListView) return _doneMissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_doneMissions);
}

@override final  CandidateReviewModel? review;
@override final  String status;
@override final  String attendance;
@override final  String? assignmentId;
@override final  String? arrivedAt;
@override final  String? finishedAt;
@override final  String? autoPayAt;
@override final  int? distanceMeters;
@override@JsonKey() final  int proofPhotos;
@override final  String? completionNote;
@override final  String? offerExpiresAt;

/// Create a copy of CandidateModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandidateModelCopyWith<_CandidateModel> get copyWith => __$CandidateModelCopyWithImpl<_CandidateModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CandidateModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandidateModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city)&&(identical(other.memberSince, memberSince) || other.memberSince == memberSince)&&(identical(other.pitch, pitch) || other.pitch == pitch)&&const DeepCollectionEquality().equals(other._skills, _skills)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.isExpert, isExpert) || other.isExpert == isExpert)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.missionsCount, missionsCount) || other.missionsCount == missionsCount)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&(identical(other.absences, absences) || other.absences == absences)&&const DeepCollectionEquality().equals(other._doneMissions, _doneMissions)&&(identical(other.review, review) || other.review == review)&&(identical(other.status, status) || other.status == status)&&(identical(other.attendance, attendance) || other.attendance == attendance)&&(identical(other.assignmentId, assignmentId) || other.assignmentId == assignmentId)&&(identical(other.arrivedAt, arrivedAt) || other.arrivedAt == arrivedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.autoPayAt, autoPayAt) || other.autoPayAt == autoPayAt)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.proofPhotos, proofPhotos) || other.proofPhotos == proofPhotos)&&(identical(other.completionNote, completionNote) || other.completionNote == completionNote)&&(identical(other.offerExpiresAt, offerExpiresAt) || other.offerExpiresAt == offerExpiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,city,memberSince,pitch,const DeepCollectionEquality().hash(_skills),verified,isExpert,rating,reviewsCount,missionsCount,reliability,absences,const DeepCollectionEquality().hash(_doneMissions),review,status,attendance,assignmentId,arrivedAt,finishedAt,autoPayAt,distanceMeters,proofPhotos,completionNote,offerExpiresAt]);

@override
String toString() {
  return 'CandidateModel(id: $id, name: $name, city: $city, memberSince: $memberSince, pitch: $pitch, skills: $skills, verified: $verified, isExpert: $isExpert, rating: $rating, reviewsCount: $reviewsCount, missionsCount: $missionsCount, reliability: $reliability, absences: $absences, doneMissions: $doneMissions, review: $review, status: $status, attendance: $attendance, assignmentId: $assignmentId, arrivedAt: $arrivedAt, finishedAt: $finishedAt, autoPayAt: $autoPayAt, distanceMeters: $distanceMeters, proofPhotos: $proofPhotos, completionNote: $completionNote, offerExpiresAt: $offerExpiresAt)';
}


}

/// @nodoc
abstract mixin class _$CandidateModelCopyWith<$Res> implements $CandidateModelCopyWith<$Res> {
  factory _$CandidateModelCopyWith(_CandidateModel value, $Res Function(_CandidateModel) _then) = __$CandidateModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String city, String? memberSince, String? pitch, List<String> skills, bool verified, bool isExpert, double? rating, int reviewsCount, int missionsCount, int? reliability, int absences, List<DoneMissionModel> doneMissions, CandidateReviewModel? review, String status, String attendance, String? assignmentId, String? arrivedAt, String? finishedAt, String? autoPayAt, int? distanceMeters, int proofPhotos, String? completionNote, String? offerExpiresAt
});


@override $CandidateReviewModelCopyWith<$Res>? get review;

}
/// @nodoc
class __$CandidateModelCopyWithImpl<$Res>
    implements _$CandidateModelCopyWith<$Res> {
  __$CandidateModelCopyWithImpl(this._self, this._then);

  final _CandidateModel _self;
  final $Res Function(_CandidateModel) _then;

/// Create a copy of CandidateModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? city = null,Object? memberSince = freezed,Object? pitch = freezed,Object? skills = null,Object? verified = null,Object? isExpert = null,Object? rating = freezed,Object? reviewsCount = null,Object? missionsCount = null,Object? reliability = freezed,Object? absences = null,Object? doneMissions = null,Object? review = freezed,Object? status = null,Object? attendance = null,Object? assignmentId = freezed,Object? arrivedAt = freezed,Object? finishedAt = freezed,Object? autoPayAt = freezed,Object? distanceMeters = freezed,Object? proofPhotos = null,Object? completionNote = freezed,Object? offerExpiresAt = freezed,}) {
  return _then(_CandidateModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,memberSince: freezed == memberSince ? _self.memberSince : memberSince // ignore: cast_nullable_to_non_nullable
as String?,pitch: freezed == pitch ? _self.pitch : pitch // ignore: cast_nullable_to_non_nullable
as String?,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,isExpert: null == isExpert ? _self.isExpert : isExpert // ignore: cast_nullable_to_non_nullable
as bool,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,missionsCount: null == missionsCount ? _self.missionsCount : missionsCount // ignore: cast_nullable_to_non_nullable
as int,reliability: freezed == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as int?,absences: null == absences ? _self.absences : absences // ignore: cast_nullable_to_non_nullable
as int,doneMissions: null == doneMissions ? _self._doneMissions : doneMissions // ignore: cast_nullable_to_non_nullable
as List<DoneMissionModel>,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as CandidateReviewModel?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,attendance: null == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as String,assignmentId: freezed == assignmentId ? _self.assignmentId : assignmentId // ignore: cast_nullable_to_non_nullable
as String?,arrivedAt: freezed == arrivedAt ? _self.arrivedAt : arrivedAt // ignore: cast_nullable_to_non_nullable
as String?,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as String?,autoPayAt: freezed == autoPayAt ? _self.autoPayAt : autoPayAt // ignore: cast_nullable_to_non_nullable
as String?,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int?,proofPhotos: null == proofPhotos ? _self.proofPhotos : proofPhotos // ignore: cast_nullable_to_non_nullable
as int,completionNote: freezed == completionNote ? _self.completionNote : completionNote // ignore: cast_nullable_to_non_nullable
as String?,offerExpiresAt: freezed == offerExpiresAt ? _self.offerExpiresAt : offerExpiresAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CandidateModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CandidateReviewModelCopyWith<$Res>? get review {
    if (_self.review == null) {
    return null;
  }

  return $CandidateReviewModelCopyWith<$Res>(_self.review!, (value) {
    return _then(_self.copyWith(review: value));
  });
}
}


/// @nodoc
mixin _$DoneMissionModel {

 String get category; int get count;
/// Create a copy of DoneMissionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DoneMissionModelCopyWith<DoneMissionModel> get copyWith => _$DoneMissionModelCopyWithImpl<DoneMissionModel>(this as DoneMissionModel, _$identity);

  /// Serializes this DoneMissionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DoneMissionModel&&(identical(other.category, category) || other.category == category)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,count);

@override
String toString() {
  return 'DoneMissionModel(category: $category, count: $count)';
}


}

/// @nodoc
abstract mixin class $DoneMissionModelCopyWith<$Res>  {
  factory $DoneMissionModelCopyWith(DoneMissionModel value, $Res Function(DoneMissionModel) _then) = _$DoneMissionModelCopyWithImpl;
@useResult
$Res call({
 String category, int count
});




}
/// @nodoc
class _$DoneMissionModelCopyWithImpl<$Res>
    implements $DoneMissionModelCopyWith<$Res> {
  _$DoneMissionModelCopyWithImpl(this._self, this._then);

  final DoneMissionModel _self;
  final $Res Function(DoneMissionModel) _then;

/// Create a copy of DoneMissionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? count = null,}) {
  return _then(_self.copyWith(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [DoneMissionModel].
extension DoneMissionModelPatterns on DoneMissionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DoneMissionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DoneMissionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DoneMissionModel value)  $default,){
final _that = this;
switch (_that) {
case _DoneMissionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DoneMissionModel value)?  $default,){
final _that = this;
switch (_that) {
case _DoneMissionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String category,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DoneMissionModel() when $default != null:
return $default(_that.category,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String category,  int count)  $default,) {final _that = this;
switch (_that) {
case _DoneMissionModel():
return $default(_that.category,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String category,  int count)?  $default,) {final _that = this;
switch (_that) {
case _DoneMissionModel() when $default != null:
return $default(_that.category,_that.count);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DoneMissionModel extends DoneMissionModel {
  const _DoneMissionModel({required this.category, required this.count}): super._();
  factory _DoneMissionModel.fromJson(Map<String, dynamic> json) => _$DoneMissionModelFromJson(json);

@override final  String category;
@override final  int count;

/// Create a copy of DoneMissionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DoneMissionModelCopyWith<_DoneMissionModel> get copyWith => __$DoneMissionModelCopyWithImpl<_DoneMissionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DoneMissionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DoneMissionModel&&(identical(other.category, category) || other.category == category)&&(identical(other.count, count) || other.count == count));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,count);

@override
String toString() {
  return 'DoneMissionModel(category: $category, count: $count)';
}


}

/// @nodoc
abstract mixin class _$DoneMissionModelCopyWith<$Res> implements $DoneMissionModelCopyWith<$Res> {
  factory _$DoneMissionModelCopyWith(_DoneMissionModel value, $Res Function(_DoneMissionModel) _then) = __$DoneMissionModelCopyWithImpl;
@override @useResult
$Res call({
 String category, int count
});




}
/// @nodoc
class __$DoneMissionModelCopyWithImpl<$Res>
    implements _$DoneMissionModelCopyWith<$Res> {
  __$DoneMissionModelCopyWithImpl(this._self, this._then);

  final _DoneMissionModel _self;
  final $Res Function(_DoneMissionModel) _then;

/// Create a copy of DoneMissionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? count = null,}) {
  return _then(_DoneMissionModel(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$CandidateReviewModel {

 String get author; int get stars; String get text; int get punctuality; int get quality; int get communication;
/// Create a copy of CandidateReviewModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandidateReviewModelCopyWith<CandidateReviewModel> get copyWith => _$CandidateReviewModelCopyWithImpl<CandidateReviewModel>(this as CandidateReviewModel, _$identity);

  /// Serializes this CandidateReviewModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandidateReviewModel&&(identical(other.author, author) || other.author == author)&&(identical(other.stars, stars) || other.stars == stars)&&(identical(other.text, text) || other.text == text)&&(identical(other.punctuality, punctuality) || other.punctuality == punctuality)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.communication, communication) || other.communication == communication));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,author,stars,text,punctuality,quality,communication);

@override
String toString() {
  return 'CandidateReviewModel(author: $author, stars: $stars, text: $text, punctuality: $punctuality, quality: $quality, communication: $communication)';
}


}

/// @nodoc
abstract mixin class $CandidateReviewModelCopyWith<$Res>  {
  factory $CandidateReviewModelCopyWith(CandidateReviewModel value, $Res Function(CandidateReviewModel) _then) = _$CandidateReviewModelCopyWithImpl;
@useResult
$Res call({
 String author, int stars, String text, int punctuality, int quality, int communication
});




}
/// @nodoc
class _$CandidateReviewModelCopyWithImpl<$Res>
    implements $CandidateReviewModelCopyWith<$Res> {
  _$CandidateReviewModelCopyWithImpl(this._self, this._then);

  final CandidateReviewModel _self;
  final $Res Function(CandidateReviewModel) _then;

/// Create a copy of CandidateReviewModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? author = null,Object? stars = null,Object? text = null,Object? punctuality = null,Object? quality = null,Object? communication = null,}) {
  return _then(_self.copyWith(
author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,stars: null == stars ? _self.stars : stars // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,punctuality: null == punctuality ? _self.punctuality : punctuality // ignore: cast_nullable_to_non_nullable
as int,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as int,communication: null == communication ? _self.communication : communication // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CandidateReviewModel].
extension CandidateReviewModelPatterns on CandidateReviewModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CandidateReviewModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CandidateReviewModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CandidateReviewModel value)  $default,){
final _that = this;
switch (_that) {
case _CandidateReviewModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CandidateReviewModel value)?  $default,){
final _that = this;
switch (_that) {
case _CandidateReviewModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String author,  int stars,  String text,  int punctuality,  int quality,  int communication)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CandidateReviewModel() when $default != null:
return $default(_that.author,_that.stars,_that.text,_that.punctuality,_that.quality,_that.communication);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String author,  int stars,  String text,  int punctuality,  int quality,  int communication)  $default,) {final _that = this;
switch (_that) {
case _CandidateReviewModel():
return $default(_that.author,_that.stars,_that.text,_that.punctuality,_that.quality,_that.communication);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String author,  int stars,  String text,  int punctuality,  int quality,  int communication)?  $default,) {final _that = this;
switch (_that) {
case _CandidateReviewModel() when $default != null:
return $default(_that.author,_that.stars,_that.text,_that.punctuality,_that.quality,_that.communication);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CandidateReviewModel extends CandidateReviewModel {
  const _CandidateReviewModel({required this.author, required this.stars, required this.text, required this.punctuality, required this.quality, required this.communication}): super._();
  factory _CandidateReviewModel.fromJson(Map<String, dynamic> json) => _$CandidateReviewModelFromJson(json);

@override final  String author;
@override final  int stars;
@override final  String text;
@override final  int punctuality;
@override final  int quality;
@override final  int communication;

/// Create a copy of CandidateReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandidateReviewModelCopyWith<_CandidateReviewModel> get copyWith => __$CandidateReviewModelCopyWithImpl<_CandidateReviewModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CandidateReviewModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandidateReviewModel&&(identical(other.author, author) || other.author == author)&&(identical(other.stars, stars) || other.stars == stars)&&(identical(other.text, text) || other.text == text)&&(identical(other.punctuality, punctuality) || other.punctuality == punctuality)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.communication, communication) || other.communication == communication));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,author,stars,text,punctuality,quality,communication);

@override
String toString() {
  return 'CandidateReviewModel(author: $author, stars: $stars, text: $text, punctuality: $punctuality, quality: $quality, communication: $communication)';
}


}

/// @nodoc
abstract mixin class _$CandidateReviewModelCopyWith<$Res> implements $CandidateReviewModelCopyWith<$Res> {
  factory _$CandidateReviewModelCopyWith(_CandidateReviewModel value, $Res Function(_CandidateReviewModel) _then) = __$CandidateReviewModelCopyWithImpl;
@override @useResult
$Res call({
 String author, int stars, String text, int punctuality, int quality, int communication
});




}
/// @nodoc
class __$CandidateReviewModelCopyWithImpl<$Res>
    implements _$CandidateReviewModelCopyWith<$Res> {
  __$CandidateReviewModelCopyWithImpl(this._self, this._then);

  final _CandidateReviewModel _self;
  final $Res Function(_CandidateReviewModel) _then;

/// Create a copy of CandidateReviewModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? author = null,Object? stars = null,Object? text = null,Object? punctuality = null,Object? quality = null,Object? communication = null,}) {
  return _then(_CandidateReviewModel(
author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,stars: null == stars ? _self.stars : stars // ignore: cast_nullable_to_non_nullable
as int,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,punctuality: null == punctuality ? _self.punctuality : punctuality // ignore: cast_nullable_to_non_nullable
as int,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as int,communication: null == communication ? _self.communication : communication // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
