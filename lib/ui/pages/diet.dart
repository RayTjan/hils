part of 'pages.dart';

class Diet extends StatefulWidget {
  @override
  _DietState createState() => _DietState();
}

class _DietState extends State<Diet> {
  List<Food> foodList;
  bool isLoading = false;
  String year = ActivityServices.dateNow().substring(0, 4);
  int day = int.parse(ActivityServices.dateNow().substring(8, 10));
  int dateLoc = ActivityServices.getDateLocation();

  // @override
  // void initState() async {
  //   await SpoonServices.searchFood("burger").then((foods) => {
  //         foodList = foods,
  //       });
  // }

  void getFoods() async {
    await SpoonServices.searchFood("burger").then((foods) => {
          foodList = foods,
        });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getFoods();
    });
    return Scaffold(
        //error when you call the API, the page just doesnt load for some reaosn
        appBar: AppBar(
          title: Text(
            'List Data',
          ),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              alignment: Alignment.topCenter,
              color: Color(0xFFF0F0F0),
              height: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.calendar_today, color: Colors.grey),
                      SizedBox(
                        width: 15,
                      ),
                      RichText(
                        text: TextSpan(
                            text: ActivityServices.getDateName('MMMM'),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0XFF263064),
                              fontSize: 22,
                            ),
                            children: [
                              TextSpan(
                                text: year,
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 16,
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  Text(
                    "Today",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0XFF3E3993),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 100,
              child: Container(
                height: MediaQuery.of(context).size.height - 160,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 15, bottom: 30),
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildDateColumn(
                              ActivityServices.getDayNameBeforeAndAfter(
                                  dateLoc, 3, false),
                              ActivityServices.getDayBeforeAndAfter(
                                  day, 3, false),
                              false),
                          buildDateColumn(
                              ActivityServices.getDayNameBeforeAndAfter(
                                  dateLoc, 2, false),
                              ActivityServices.getDayBeforeAndAfter(
                                  day, 2, false),
                              false),
                          buildDateColumn(
                              ActivityServices.getDayNameBeforeAndAfter(
                                  dateLoc, 1, false),
                              ActivityServices.getDayBeforeAndAfter(
                                  day, 1, false),
                              false),
                          buildDateColumn(
                              ActivityServices.getDayNameBeforeAndAfter(
                                  dateLoc, 0, true),
                              ActivityServices.getDayBeforeAndAfter(
                                  day, 0, true),
                              true),
                          buildDateColumn(
                              ActivityServices.getDayNameBeforeAndAfter(
                                  dateLoc, 1, true),
                              ActivityServices.getDayBeforeAndAfter(
                                  day, 1, true),
                              false),
                          buildDateColumn(
                              ActivityServices.getDayNameBeforeAndAfter(
                                  dateLoc, 2, true),
                              ActivityServices.getDayBeforeAndAfter(
                                  day, 2, true),
                              false),
                          buildDateColumn(
                              ActivityServices.getDayNameBeforeAndAfter(
                                  dateLoc, 3, true),
                              ActivityServices.getDayBeforeAndAfter(
                                  day, 3, true),
                              false),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    Expanded(
                      child: SizedBox(
                        height: 200.0,
                        child: FutureBuilder<List<Food>>(
                          future: SpoonServices.searchFood("burger"),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<Food> foods = snapshot.data;
                              return _foodListView(foods);
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  ListView _foodListView(foods) {
    return ListView.builder(
        itemCount: foods.length,
        padding: const EdgeInsets.only(top: 10.0),
        itemBuilder: (context, index) {
          return FoodCard(food: foods[index]);
        });
  }

  Container buildDateColumn(String weekDay, int date, bool isActive) {
    return Container(
      decoration: isActive
          ? BoxDecoration(
              color: Color(0xff402fcc), borderRadius: BorderRadius.circular(10))
          : BoxDecoration(),
      height: 55,
      width: 35,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            weekDay,
            style: TextStyle(color: Colors.grey, fontSize: 11),
          ),
          Text(
            date.toString(),
            style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
