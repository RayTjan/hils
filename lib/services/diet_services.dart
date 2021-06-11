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
    ActivityServices.showToast("Food Added", Colors.green[800]);
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

  static List getSummary() {
    int carb = 0;
    int calory = 0;
    int fat = 0;
    int protein = 0;
    FirebaseFirestore.instance.collection('DietPlan').get().then((value) => {
          if (value.docs.length == 0)
            {print("Nothing")}
          else
            {
              value.docs.forEach((element) {
                carb += int.parse(element.data()['Carbs']);
                calory += int.parse(element.data()['calories']);
                fat += int.parse(element.data()['Fat']);
                protein += int.parse(element.data()['protein']);
              })
            }
        });

    return [carb, calory, fat, protein];
  }
}
