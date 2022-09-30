import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv/created_by.dart';

class CreatedByModel extends Equatable {
  const CreatedByModel({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    required this.profilePath,
  });

  final int? id;
  final String? creditId;
  final String? name;
  final int? gender;
  final String? profilePath;

  factory CreatedByModel.fromJson(Map<String, dynamic> json) => CreatedByModel(
        id: json["id"],
        creditId: json["credit_id"],
        name: json["name"],
        gender: json["gender"],
        profilePath: json["profile_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "credit_id": creditId,
        "name": name,
        "gender": gender,
        "profile_path": profilePath,
      };

  CreatedBy toEntity() {
    return CreatedBy(
        id: id,
        creditId: creditId,
        name: name,
        gender: gender,
        profilePath: profilePath);
  }

  @override
  List<Object?> get props => [id, creditId, name, gender, profilePath];
}
