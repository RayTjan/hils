part of 'models.dart';

class Food {
  final String id;
  final String title;
  final String images;
  final String carbs;
  final String carbsUnit;
  final String calories;
  final String caloriesUnit;
  final String fat;
  final String fatUnit;

  final String protein;
  final String proteinUnit;

  Food(
    this.id,
    this.title,
    this.images,
    this.carbs,
    this.carbsUnit,
    this.calories,
    this.caloriesUnit,
    this.fat,
    this.fatUnit,
    this.protein,
    this.proteinUnit,
  );

  factory Food.createFoods(Map<String, dynamic> object) {
    return Food(
      object['id'].toString(),
      object['title'],
      object['images'][0],
      object['nutrition']['nutrients'][0]['amount'].toString(),
      object['nutrition']['nutrients'][0]['unit'],
      object['nutrition']['nutrients'][2]['amount'].toString(),
      object['nutrition']['nutrients'][2]['unit'],
      object['nutrition']['nutrients'][3]['amount'].toString(),
      object['nutrition']['nutrients'][3]['unit'],
      object['nutrition']['nutrients'][7]['amount'].toString(),
      object['nutrition']['nutrients'][7]['unit'],
    );
  }
}
