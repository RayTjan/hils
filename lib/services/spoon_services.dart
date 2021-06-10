part of 'services.dart';

class SpoonServices {
  static Future<List<Food>> searchFood(String search) async {
    List<Food> foods = [];
    String apiURL = Glovar.baseUrl +
        "/food/menuItems/search?query= " +
        search +
        "&apiKey=" +
        Glovar.apiKey;

    var apiResult = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(apiResult.body);
    print(jsonObject);
    List<dynamic> listFoods = (jsonObject as Map<String, dynamic>)['menuItems'];
    print(listFoods);
    for (int i = 0; i < listFoods.length; i++)
      foods.add(Food.createFoods(
          (await getFoodDetails(listFoods[i]['id'].toString()))));

    return foods;
  }

  static Future<Map<String, dynamic>> getFoodDetails(String id) async {
    String apiURL =
        Glovar.baseUrl + "/food/products/" + id + "?apiKey=" + Glovar.apiKey;
    //https://api.spoonacular.com/food/products/419357?apiKey=b626cfb0dcc84cc6893b523346a0bf56
    //https://api.spoonacular.com/food/products/224185&apiKey=b626cfb0dcc84cc6893b523346a0bf56

    var apiResult = await http.get(Uri.parse(apiURL));
    var jsonObject = json.decode(apiResult.body) as Map;
    return jsonObject;
  }
}
