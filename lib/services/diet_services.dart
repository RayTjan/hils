part of 'services.dart';

class DietServices {
  static FirebaseAuth auth = FirebaseAuth.instance;

  //setup cloud firestore
  static CollectionReference dietCollection =
      FirebaseFirestore.instance.collection("DietPlan");
  static DocumentReference productDocument;

  //setup storage
  static Reference ref;
  static UploadTask uploadTask;
  static String imgUrl;

  static Future<bool> addFood(Food food) async {
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    productDocument = await dietCollection.add({
      'User': auth.currentUser.uid,
      'foodId': food.id,
      'Title': food.title,
      'Image': food.images,
      'Carbs': food.carbs,
      'CarbsUnit': food.carbsUnit,
      'calories': food.calories,
      'CaloriesUnit': food.caloriesUnit,
      'Fat': food.fat,
      'FatUnit': food.fatUnit,
      'protein': food.protein,
      'proteinUnit': food.proteinUnit,
      'timeAdded': dateNow,
    });
    return true;
  }

  static Future<bool> deleteFood(String id) async {
    bool hsl = true;
    await Firebase.initializeApp();
    await dietCollection.doc(id).delete().then((value) {
      hsl = true;
    }).catchError((onError) {
      hsl = false;
    });

    return hsl;
  }
}
