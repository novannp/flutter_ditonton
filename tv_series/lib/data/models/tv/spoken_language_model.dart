import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv/spoken_language.dart';

class SpokenLanguageModel extends Equatable {
  const SpokenLanguageModel({
    required this.englishName,
    required this.iso6391,
    required this.name,
  });

  final String englishName;
  final String iso6391;
  final String name;

  factory SpokenLanguageModel.fromJson(Map<String, dynamic> json) =>
      SpokenLanguageModel(
        englishName: json["english_name"],
        iso6391: json["iso_639_1"],
        name: json["name"],
      );

  SpokenLanguage toEntity() {
    return SpokenLanguage(
        englishName: englishName, iso6391: iso6391, name: name);
  }

  @override
  List<Object?> get props => [
        englishName,
        iso6391,
        name,
      ];
}
