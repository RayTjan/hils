part of 'pages.dart';

class Test2 extends StatefulWidget {
  Test2({Key key}) : super(key: key);

  @override
  _Test2State createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  List<Food> foodList;
  bool isLoading = false;
  String year = ActivityServices.dateNow().substring(0, 4);
  int day = int.parse(ActivityServices.dateNow().substring(8, 10));
  int dateLoc = ActivityServices.getDateLocation();

  @override
  void initState() async {
    isLoading = true;
    ActivityServices.loadings();
    // await SpoonServices.searchFood("burger").then((foods) => {
    //       foodList = foods,
    //     });
    isLoading = false;
    super.initState();
  }

  // Widget buildBody() {
  //   return Container(
  //     child: Scaffold(
  //       body: Container(
  //         decoration: BoxDecoration(
  //             gradient: LinearGradient(
  //                 colors: [Color(0xff1542bf), Color(0xff51a8ff)],
  //                 begin: FractionalOffset(0.5, 1))),
  //         width: double.infinity,
  //         child: ListView.builder(
  //           itemBuilder: (context, index) =>
  //               FoodCard(food: await responseData.elementAt(index)),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget buildBody() {
  //   return Container(
  //     child: Scaffold(
  //       body: Container(
  //         decoration: BoxDecoration(
  //             gradient: LinearGradient(
  //                 colors: [Color(0xff1542bf), Color(0xff51a8ff)],
  //                 begin: FractionalOffset(0.5, 1))),
  //         width: double.infinity,
  //         child: ListView.builder(
  //           itemBuilder: (context, index) => FoodCard(
  //               food: new Food(
  //             "1",
  //             "sth",
  //             "https://spoonacular.com/recipeImages/511728-312x231.jpg",
  //             "jpg",
  //           )),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget build(BuildContext context) {
    return Scaffold(
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
                    // Container(
                    //     decoration: BoxDecoration(
                    //         gradient: LinearGradient(
                    //             colors: [Color(0xff1542bf), Color(0xff51a8ff)],
                    //             begin: FractionalOffset(0.5, 1))),
                    //     width: double.infinity,
                    //     child: ListView.builder(
                    //       itemCount: foodList.length,
                    //       itemBuilder: (BuildContext ctx, int index) {
                    //         return FoodCard(food: foodList[index]);
                    //       },
                    //     )),
                    isLoading == true
                        ? ActivityServices.loadings()
                        : Container()
                  ],
                ),
              ),
            ),
          ],
        ));
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
