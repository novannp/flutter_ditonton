import 'package:ditonton/domain/entities/tv/production_country.dart';
import 'package:equatable/equatable.dart';

class ProductionCountryModel extends Equatable {
  ProductionCountryModel({
    required this.iso31661,
    required this.name,
  });

  final String iso31661;
  final String name;

  factory ProductionCountryModel.fromJson(Map<String, dynamic> json) =>
      ProductionCountryModel(
        iso31661: json["iso_3166_1"],
        name: json["name"],
      );

  ProductionCountry toEntity() {
    return ProductionCountry(iso31661: this.iso31661, name: this.name);
  }

  @override
  List<Object?> get props => [
        iso31661,
        name,
      ];
}
