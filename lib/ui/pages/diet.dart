part of 'pages.dart';

class Diet extends StatefulWidget {
  @override
  _DietState createState() => _DietState();
}

class _DietState extends State<Diet> {
  List<Food> foodList;
  bool isLoading = false;
  bool searchin = false;
  String searchName = "";
  String year = ActivityServices.dateNow().substring(0, 4);
  int day = int.parse(ActivityServices.dateNow().substring(8, 10));
  int dateLoc = ActivityServices.getDateLocation();
  String userName = AuthServices.getName();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            searchBarUI(),
            Stack(
              children: [
                searchin
                    ? null
                    : Container(
                        padding: const EdgeInsets.only(top: 100.0),
                        alignment: Alignment.topCenter,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 15, bottom: 30),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                            // HEYYEYAAEYAAAEYAEYAA

                            Image.asset(
                              "assets/images/loogWhite.png",
                              height: 275,
                            ),
                          ],
                        ),
                      ),
              ],
            )
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
              color: Colors.green[800], borderRadius: BorderRadius.circular(10))
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

  Widget searchBarUI() {
    return FloatingSearchBar(
      hint: 'Search.....',
      openAxisAlignment: 0.0,
      openWidth: 600,
      axisAlignment: 0.0,
      scrollPadding: EdgeInsets.only(top: 16, bottom: 20),
      physics: BouncingScrollPhysics(),
      onQueryChanged: (query) {
        setState(() {
          searchName = query;
        });
      },
      automaticallyImplyDrawerHamburger: false,
      transitionCurve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 500),
      transition: CircularFloatingSearchBarTransition(),
      debounceDelay: Duration(milliseconds: 500),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: true,
          child: CircularButton(
            icon: Icon(Icons.search),
            onPressed: () {
              print('Places Pressed');
            },
          ),
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Material(
            child: Expanded(
              child: SizedBox(
                height: searchName != ""
                    ? MediaQuery.of(context).size.height * 4 / 5
                    : 0,
                child: FutureBuilder<List<Food>>(
                  future: SpoonServices.searchFood(searchName),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Food> foods = snapshot.data;
                      return _foodListView(foods);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Text("Loading...");
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
