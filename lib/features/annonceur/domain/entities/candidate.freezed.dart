// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candidate.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Candidate {

 String get id;// identifiant de la candidature
 String get name;// « Sènami O. »
 String get city; DateTime? get memberSince;// null pour un compte sans profil
 String get pitch;// la présentation du candidat
 String get skills; bool get verified; bool get isExpert; double? get rating; int get reviewsCount; int get missionsCount; int? get reliability;// en pourcentage
 int get absences; List<DoneMission> get doneMissions; CandidateReview? get review; CandidateStatus get status; AttendanceStatus get attendance; String? get assignmentId; DateTime? get arrivedAt; DateTime? get finishedAt; DateTime? get autoPayAt;// sans réponse, le paiement part à cette heure
 DateTime? get offerExpiresAt; int? get distanceMeters; int get proofPhotos; String? get completionNote;
/// Create a copy of Candidate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandidateCopyWith<Candidate> get copyWith => _$CandidateCopyWithImpl<Candidate>(this as Candidate, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Candidate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city)&&(identical(other.memberSince, memberSince) || other.memberSince == memberSince)&&(identical(other.pitch, pitch) || other.pitch == pitch)&&(identical(other.skills, skills) || other.skills == skills)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.isExpert, isExpert) || other.isExpert == isExpert)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.missionsCount, missionsCount) || other.missionsCount == missionsCount)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&(identical(other.absences, absences) || other.absences == absences)&&const DeepCollectionEquality().equals(other.doneMissions, doneMissions)&&(identical(other.review, review) || other.review == review)&&(identical(other.status, status) || other.status == status)&&(identical(other.attendance, attendance) || other.attendance == attendance)&&(identical(other.assignmentId, assignmentId) || other.assignmentId == assignmentId)&&(identical(other.arrivedAt, arrivedAt) || other.arrivedAt == arrivedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.autoPayAt, autoPayAt) || other.autoPayAt == autoPayAt)&&(identical(other.offerExpiresAt, offerExpiresAt) || other.offerExpiresAt == offerExpiresAt)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.proofPhotos, proofPhotos) || other.proofPhotos == proofPhotos)&&(identical(other.completionNote, completionNote) || other.completionNote == completionNote));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,name,city,memberSince,pitch,skills,verified,isExpert,rating,reviewsCount,missionsCount,reliability,absences,const DeepCollectionEquality().hash(doneMissions),review,status,attendance,assignmentId,arrivedAt,finishedAt,autoPayAt,offerExpiresAt,distanceMeters,proofPhotos,completionNote]);

@override
String toString() {
  return 'Candidate(id: $id, name: $name, city: $city, memberSince: $memberSince, pitch: $pitch, skills: $skills, verified: $verified, isExpert: $isExpert, rating: $rating, reviewsCount: $reviewsCount, missionsCount: $missionsCount, reliability: $reliability, absences: $absences, doneMissions: $doneMissions, review: $review, status: $status, attendance: $attendance, assignmentId: $assignmentId, arrivedAt: $arrivedAt, finishedAt: $finishedAt, autoPayAt: $autoPayAt, offerExpiresAt: $offerExpiresAt, distanceMeters: $distanceMeters, proofPhotos: $proofPhotos, completionNote: $completionNote)';
}


}

/// @nodoc
abstract mixin class $CandidateCopyWith<$Res>  {
  factory $CandidateCopyWith(Candidate value, $Res Function(Candidate) _then) = _$CandidateCopyWithImpl;
@useResult
$Res call({
 String id, String name, String city, DateTime? memberSince, String pitch, String skills, bool verified, bool isExpert, double? rating, int reviewsCount, int missionsCount, int? reliability, int absences, List<DoneMission> doneMissions, CandidateReview? review, CandidateStatus status, AttendanceStatus attendance, String? assignmentId, DateTime? arrivedAt, DateTime? finishedAt, DateTime? autoPayAt, DateTime? offerExpiresAt, int? distanceMeters, int proofPhotos, String? completionNote
});




}
/// @nodoc
class _$CandidateCopyWithImpl<$Res>
    implements $CandidateCopyWith<$Res> {
  _$CandidateCopyWithImpl(this._self, this._then);

  final Candidate _self;
  final $Res Function(Candidate) _then;

/// Create a copy of Candidate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? city = null,Object? memberSince = freezed,Object? pitch = null,Object? skills = null,Object? verified = null,Object? isExpert = null,Object? rating = freezed,Object? reviewsCount = null,Object? missionsCount = null,Object? reliability = freezed,Object? absences = null,Object? doneMissions = null,Object? review = freezed,Object? status = null,Object? attendance = null,Object? assignmentId = freezed,Object? arrivedAt = freezed,Object? finishedAt = freezed,Object? autoPayAt = freezed,Object? offerExpiresAt = freezed,Object? distanceMeters = freezed,Object? proofPhotos = null,Object? completionNote = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,memberSince: freezed == memberSince ? _self.memberSince : memberSince // ignore: cast_nullable_to_non_nullable
as DateTime?,pitch: null == pitch ? _self.pitch : pitch // ignore: cast_nullable_to_non_nullable
as String,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as String,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,isExpert: null == isExpert ? _self.isExpert : isExpert // ignore: cast_nullable_to_non_nullable
as bool,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,missionsCount: null == missionsCount ? _self.missionsCount : missionsCount // ignore: cast_nullable_to_non_nullable
as int,reliability: freezed == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as int?,absences: null == absences ? _self.absences : absences // ignore: cast_nullable_to_non_nullable
as int,doneMissions: null == doneMissions ? _self.doneMissions : doneMissions // ignore: cast_nullable_to_non_nullable
as List<DoneMission>,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as CandidateReview?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CandidateStatus,attendance: null == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as AttendanceStatus,assignmentId: freezed == assignmentId ? _self.assignmentId : assignmentId // ignore: cast_nullable_to_non_nullable
as String?,arrivedAt: freezed == arrivedAt ? _self.arrivedAt : arrivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,autoPayAt: freezed == autoPayAt ? _self.autoPayAt : autoPayAt // ignore: cast_nullable_to_non_nullable
as DateTime?,offerExpiresAt: freezed == offerExpiresAt ? _self.offerExpiresAt : offerExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int?,proofPhotos: null == proofPhotos ? _self.proofPhotos : proofPhotos // ignore: cast_nullable_to_non_nullable
as int,completionNote: freezed == completionNote ? _self.completionNote : completionNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Candidate].
extension CandidatePatterns on Candidate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Candidate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Candidate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Candidate value)  $default,){
final _that = this;
switch (_that) {
case _Candidate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Candidate value)?  $default,){
final _that = this;
switch (_that) {
case _Candidate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String city,  DateTime? memberSince,  String pitch,  String skills,  bool verified,  bool isExpert,  double? rating,  int reviewsCount,  int missionsCount,  int? reliability,  int absences,  List<DoneMission> doneMissions,  CandidateReview? review,  CandidateStatus status,  AttendanceStatus attendance,  String? assignmentId,  DateTime? arrivedAt,  DateTime? finishedAt,  DateTime? autoPayAt,  DateTime? offerExpiresAt,  int? distanceMeters,  int proofPhotos,  String? completionNote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Candidate() when $default != null:
return $default(_that.id,_that.name,_that.city,_that.memberSince,_that.pitch,_that.skills,_that.verified,_that.isExpert,_that.rating,_that.reviewsCount,_that.missionsCount,_that.reliability,_that.absences,_that.doneMissions,_that.review,_that.status,_that.attendance,_that.assignmentId,_that.arrivedAt,_that.finishedAt,_that.autoPayAt,_that.offerExpiresAt,_that.distanceMeters,_that.proofPhotos,_that.completionNote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String city,  DateTime? memberSince,  String pitch,  String skills,  bool verified,  bool isExpert,  double? rating,  int reviewsCount,  int missionsCount,  int? reliability,  int absences,  List<DoneMission> doneMissions,  CandidateReview? review,  CandidateStatus status,  AttendanceStatus attendance,  String? assignmentId,  DateTime? arrivedAt,  DateTime? finishedAt,  DateTime? autoPayAt,  DateTime? offerExpiresAt,  int? distanceMeters,  int proofPhotos,  String? completionNote)  $default,) {final _that = this;
switch (_that) {
case _Candidate():
return $default(_that.id,_that.name,_that.city,_that.memberSince,_that.pitch,_that.skills,_that.verified,_that.isExpert,_that.rating,_that.reviewsCount,_that.missionsCount,_that.reliability,_that.absences,_that.doneMissions,_that.review,_that.status,_that.attendance,_that.assignmentId,_that.arrivedAt,_that.finishedAt,_that.autoPayAt,_that.offerExpiresAt,_that.distanceMeters,_that.proofPhotos,_that.completionNote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String city,  DateTime? memberSince,  String pitch,  String skills,  bool verified,  bool isExpert,  double? rating,  int reviewsCount,  int missionsCount,  int? reliability,  int absences,  List<DoneMission> doneMissions,  CandidateReview? review,  CandidateStatus status,  AttendanceStatus attendance,  String? assignmentId,  DateTime? arrivedAt,  DateTime? finishedAt,  DateTime? autoPayAt,  DateTime? offerExpiresAt,  int? distanceMeters,  int proofPhotos,  String? completionNote)?  $default,) {final _that = this;
switch (_that) {
case _Candidate() when $default != null:
return $default(_that.id,_that.name,_that.city,_that.memberSince,_that.pitch,_that.skills,_that.verified,_that.isExpert,_that.rating,_that.reviewsCount,_that.missionsCount,_that.reliability,_that.absences,_that.doneMissions,_that.review,_that.status,_that.attendance,_that.assignmentId,_that.arrivedAt,_that.finishedAt,_that.autoPayAt,_that.offerExpiresAt,_that.distanceMeters,_that.proofPhotos,_that.completionNote);case _:
  return null;

}
}

}

/// @nodoc


class _Candidate extends Candidate {
  const _Candidate({required this.id, required this.name, required this.city, this.memberSince, required this.pitch, required this.skills, this.verified = false, this.isExpert = false, this.rating, this.reviewsCount = 0, this.missionsCount = 0, this.reliability, this.absences = 0, final  List<DoneMission> doneMissions = const [], this.review, this.status = CandidateStatus.pending, this.attendance = AttendanceStatus.notArrived, this.assignmentId, this.arrivedAt, this.finishedAt, this.autoPayAt, this.offerExpiresAt, this.distanceMeters, this.proofPhotos = 0, this.completionNote}): _doneMissions = doneMissions,super._();
  

@override final  String id;
// identifiant de la candidature
@override final  String name;
// « Sènami O. »
@override final  String city;
@override final  DateTime? memberSince;
// null pour un compte sans profil
@override final  String pitch;
// la présentation du candidat
@override final  String skills;
@override@JsonKey() final  bool verified;
@override@JsonKey() final  bool isExpert;
@override final  double? rating;
@override@JsonKey() final  int reviewsCount;
@override@JsonKey() final  int missionsCount;
@override final  int? reliability;
// en pourcentage
@override@JsonKey() final  int absences;
 final  List<DoneMission> _doneMissions;
@override@JsonKey() List<DoneMission> get doneMissions {
  if (_doneMissions is EqualUnmodifiableListView) return _doneMissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_doneMissions);
}

@override final  CandidateReview? review;
@override@JsonKey() final  CandidateStatus status;
@override@JsonKey() final  AttendanceStatus attendance;
@override final  String? assignmentId;
@override final  DateTime? arrivedAt;
@override final  DateTime? finishedAt;
@override final  DateTime? autoPayAt;
// sans réponse, le paiement part à cette heure
@override final  DateTime? offerExpiresAt;
@override final  int? distanceMeters;
@override@JsonKey() final  int proofPhotos;
@override final  String? completionNote;

/// Create a copy of Candidate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandidateCopyWith<_Candidate> get copyWith => __$CandidateCopyWithImpl<_Candidate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Candidate&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.city, city) || other.city == city)&&(identical(other.memberSince, memberSince) || other.memberSince == memberSince)&&(identical(other.pitch, pitch) || other.pitch == pitch)&&(identical(other.skills, skills) || other.skills == skills)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.isExpert, isExpert) || other.isExpert == isExpert)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewsCount, reviewsCount) || other.reviewsCount == reviewsCount)&&(identical(other.missionsCount, missionsCount) || other.missionsCount == missionsCount)&&(identical(other.reliability, reliability) || other.reliability == reliability)&&(identical(other.absences, absences) || other.absences == absences)&&const DeepCollectionEquality().equals(other._doneMissions, _doneMissions)&&(identical(other.review, review) || other.review == review)&&(identical(other.status, status) || other.status == status)&&(identical(other.attendance, attendance) || other.attendance == attendance)&&(identical(other.assignmentId, assignmentId) || other.assignmentId == assignmentId)&&(identical(other.arrivedAt, arrivedAt) || other.arrivedAt == arrivedAt)&&(identical(other.finishedAt, finishedAt) || other.finishedAt == finishedAt)&&(identical(other.autoPayAt, autoPayAt) || other.autoPayAt == autoPayAt)&&(identical(other.offerExpiresAt, offerExpiresAt) || other.offerExpiresAt == offerExpiresAt)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.proofPhotos, proofPhotos) || other.proofPhotos == proofPhotos)&&(identical(other.completionNote, completionNote) || other.completionNote == completionNote));
}


@override
int get hashCode => Object.hashAll([runtimeType,id,name,city,memberSince,pitch,skills,verified,isExpert,rating,reviewsCount,missionsCount,reliability,absences,const DeepCollectionEquality().hash(_doneMissions),review,status,attendance,assignmentId,arrivedAt,finishedAt,autoPayAt,offerExpiresAt,distanceMeters,proofPhotos,completionNote]);

@override
String toString() {
  return 'Candidate(id: $id, name: $name, city: $city, memberSince: $memberSince, pitch: $pitch, skills: $skills, verified: $verified, isExpert: $isExpert, rating: $rating, reviewsCount: $reviewsCount, missionsCount: $missionsCount, reliability: $reliability, absences: $absences, doneMissions: $doneMissions, review: $review, status: $status, attendance: $attendance, assignmentId: $assignmentId, arrivedAt: $arrivedAt, finishedAt: $finishedAt, autoPayAt: $autoPayAt, offerExpiresAt: $offerExpiresAt, distanceMeters: $distanceMeters, proofPhotos: $proofPhotos, completionNote: $completionNote)';
}


}

/// @nodoc
abstract mixin class _$CandidateCopyWith<$Res> implements $CandidateCopyWith<$Res> {
  factory _$CandidateCopyWith(_Candidate value, $Res Function(_Candidate) _then) = __$CandidateCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String city, DateTime? memberSince, String pitch, String skills, bool verified, bool isExpert, double? rating, int reviewsCount, int missionsCount, int? reliability, int absences, List<DoneMission> doneMissions, CandidateReview? review, CandidateStatus status, AttendanceStatus attendance, String? assignmentId, DateTime? arrivedAt, DateTime? finishedAt, DateTime? autoPayAt, DateTime? offerExpiresAt, int? distanceMeters, int proofPhotos, String? completionNote
});




}
/// @nodoc
class __$CandidateCopyWithImpl<$Res>
    implements _$CandidateCopyWith<$Res> {
  __$CandidateCopyWithImpl(this._self, this._then);

  final _Candidate _self;
  final $Res Function(_Candidate) _then;

/// Create a copy of Candidate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? city = null,Object? memberSince = freezed,Object? pitch = null,Object? skills = null,Object? verified = null,Object? isExpert = null,Object? rating = freezed,Object? reviewsCount = null,Object? missionsCount = null,Object? reliability = freezed,Object? absences = null,Object? doneMissions = null,Object? review = freezed,Object? status = null,Object? attendance = null,Object? assignmentId = freezed,Object? arrivedAt = freezed,Object? finishedAt = freezed,Object? autoPayAt = freezed,Object? offerExpiresAt = freezed,Object? distanceMeters = freezed,Object? proofPhotos = null,Object? completionNote = freezed,}) {
  return _then(_Candidate(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,memberSince: freezed == memberSince ? _self.memberSince : memberSince // ignore: cast_nullable_to_non_nullable
as DateTime?,pitch: null == pitch ? _self.pitch : pitch // ignore: cast_nullable_to_non_nullable
as String,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as String,verified: null == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool,isExpert: null == isExpert ? _self.isExpert : isExpert // ignore: cast_nullable_to_non_nullable
as bool,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,reviewsCount: null == reviewsCount ? _self.reviewsCount : reviewsCount // ignore: cast_nullable_to_non_nullable
as int,missionsCount: null == missionsCount ? _self.missionsCount : missionsCount // ignore: cast_nullable_to_non_nullable
as int,reliability: freezed == reliability ? _self.reliability : reliability // ignore: cast_nullable_to_non_nullable
as int?,absences: null == absences ? _self.absences : absences // ignore: cast_nullable_to_non_nullable
as int,doneMissions: null == doneMissions ? _self._doneMissions : doneMissions // ignore: cast_nullable_to_non_nullable
as List<DoneMission>,review: freezed == review ? _self.review : review // ignore: cast_nullable_to_non_nullable
as CandidateReview?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CandidateStatus,attendance: null == attendance ? _self.attendance : attendance // ignore: cast_nullable_to_non_nullable
as AttendanceStatus,assignmentId: freezed == assignmentId ? _self.assignmentId : assignmentId // ignore: cast_nullable_to_non_nullable
as String?,arrivedAt: freezed == arrivedAt ? _self.arrivedAt : arrivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,finishedAt: freezed == finishedAt ? _self.finishedAt : finishedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,autoPayAt: freezed == autoPayAt ? _self.autoPayAt : autoPayAt // ignore: cast_nullable_to_non_nullable
as DateTime?,offerExpiresAt: freezed == offerExpiresAt ? _self.offerExpiresAt : offerExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,distanceMeters: freezed == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as int?,proofPhotos: null == proofPhotos ? _self.proofPhotos : proofPhotos // ignore: cast_nullable_to_non_nullable
as int,completionNote: freezed == completionNote ? _self.completionNote : completionNote // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
