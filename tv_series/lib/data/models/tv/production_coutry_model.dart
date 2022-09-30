import 'package:equatable/equatable.dart';

import '../../../domain/entities/tv/production_country.dart';

class ProductionCountryModel extends Equatable {
  const ProductionCountryModel({
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
    return ProductionCountry(iso31661: iso31661, name: name);
  }

  @override
  List<Object?> get props => [
        iso31661,
        name,
      ];
}
