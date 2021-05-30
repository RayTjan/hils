part of 'pages.dart';

class Testing extends StatefulWidget {
  Testing({Key key}) : super(key: key);

  @override
  _TestingState createState() => _TestingState();
}

//Test Api here
class _TestingState extends State<Testing> {
  Future<List> responseData;

  @override
  void initState() async {
    responseData = getData();
    super.initState();
  }

  Future<List> getData() async {
    var response = await Dio().get(
        'https://api.spoonacular.com/recipes/complexSearch?query=pasta&apiKey=b626cfb0dcc84cc6893b523346a0bf56&includeNutrition=true');
    print(response.data['results']);
    return response.data['results'];
  }

  @override
  Widget buildBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: FutureBuilder<List>(
          future: responseData,
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              print("PRINTING");
              return new ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                print(snapshot.data[index]);
                return FoodCard(food: snapshot.data[index]);
              });
            } else {
              print("NOT PRINTING");
            }
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'List Data',
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: buildBody(),
    );
  }
}
