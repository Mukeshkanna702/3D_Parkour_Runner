import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  final String id;
  final String name;
  final String title;
  final String role;
  final String imagePath;
  final String primaryAbility;
  final String ultimateAbility;
  final String biography;
  final String difficulty;
  final int powerRating;
  final int agility;
  final int velocity;
  final int armor;
  final String rarity;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.title,
    required this.role,
    required this.imagePath,
    required this.primaryAbility,
    required this.ultimateAbility,
    required this.biography,
    required this.difficulty,
    required this.powerRating,
    required this.agility,
    required this.velocity,
    required this.armor,
    required this.rarity,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        title,
        role,
        imagePath,
        primaryAbility,
        ultimateAbility,
        biography,
        difficulty,
        powerRating,
        agility,
        velocity,
        armor,
        rarity,
      ];
}
