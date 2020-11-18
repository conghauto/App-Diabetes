
class TypeExerciseModel{
  final String id;
  final String typeExercise;
  final String mETs;

  TypeExerciseModel({this.id, this.typeExercise, this.mETs});

  factory TypeExerciseModel.fromJson(Map<String, dynamic> json) {
    return TypeExerciseModel(
      id: json['id'].toString(),
      typeExercise: json['typeExercise'].toString(),
      mETs: json['mETs'].toString(),
    );
  }
}