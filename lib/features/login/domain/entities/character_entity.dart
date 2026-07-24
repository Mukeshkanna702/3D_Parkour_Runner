import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  final String id;
  final String name;
  final String title;
  final String role;
  final String imagePath;
  final String primaryAbility;
  final int agility;
  final int velocity;
  final int armor;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.title,
    required this.role,
    required this.imagePath,
    required this.primaryAbility,
    required this.agility,
    required this.velocity,
    required this.armor,
  });

  @override
  List<Object?> get props => [id, name, title, role, imagePath, primaryAbility, agility, velocity, armor];
}
