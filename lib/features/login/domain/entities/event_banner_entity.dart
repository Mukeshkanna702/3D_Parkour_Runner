import 'package:equatable/equatable.dart';

class EventBannerEntity extends Equatable {
  final String id;
  final String title;
  final String subtitle;
  final String tag;
  final String imagePath;
  final String expiryText;

  const EventBannerEntity({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.imagePath,
    required this.expiryText,
  });

  @override
  List<Object?> get props => [id, title, subtitle, tag, imagePath, expiryText];
}
