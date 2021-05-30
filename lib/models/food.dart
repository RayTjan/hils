part of 'models.dart';

class Food extends Equatable {
  final String id;
  final String title;
  final String image;
  final String imageType;

  Food(
    this.id,
    this.title,
    this.image,
    this.imageType,
  );

  @override
  List<Object> get props => [
        id,
        title,
        image,
        imageType,
      ];
}
