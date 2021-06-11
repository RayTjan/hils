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
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference foodCollection =
      FirebaseFirestore.instance.collection("DietPlan");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/greenTri.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                SizedBox(height: 100000),
                Stack(
                  children: [
                    searchin
                        ? null
                        : Container(
                            padding: const EdgeInsets.only(top: 100.0),
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Date",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(top: 15, bottom: 30),
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      buildDateColumn(
                                          ActivityServices
                                              .getDayNameBeforeAndAfter(
                                                  dateLoc, 3, false),
                                          ActivityServices.getDayBeforeAndAfter(
                                              day, 3, false),
                                          false),
                                      buildDateColumn(
                                          ActivityServices
                                              .getDayNameBeforeAndAfter(
                                                  dateLoc, 2, false),
                                          ActivityServices.getDayBeforeAndAfter(
                                              day, 2, false),
                                          false),
                                      buildDateColumn(
                                          ActivityServices
                                              .getDayNameBeforeAndAfter(
                                                  dateLoc, 1, false),
                                          ActivityServices.getDayBeforeAndAfter(
                                              day, 1, false),
                                          false),
                                      buildDateColumn(
                                          ActivityServices
                                              .getDayNameBeforeAndAfter(
                                                  dateLoc, 0, true),
                                          ActivityServices.getDayBeforeAndAfter(
                                              day, 0, true),
                                          true),
                                      buildDateColumn(
                                          ActivityServices
                                              .getDayNameBeforeAndAfter(
                                                  dateLoc, 1, true),
                                          ActivityServices.getDayBeforeAndAfter(
                                              day, 1, true),
                                          false),
                                      buildDateColumn(
                                          ActivityServices
                                              .getDayNameBeforeAndAfter(
                                                  dateLoc, 2, true),
                                          ActivityServices.getDayBeforeAndAfter(
                                              day, 2, true),
                                          false),
                                      buildDateColumn(
                                          ActivityServices
                                              .getDayNameBeforeAndAfter(
                                                  dateLoc, 3, true),
                                          ActivityServices.getDayBeforeAndAfter(
                                              day, 3, true),
                                          false),
                                    ],
                                  ),
                                ),

                                Padding(
                                    padding: EdgeInsets.only(left: 15),
                                    child: Text(
                                      "Diet History",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black),
                                    )),

                                // HEYYEYAAEYAAAEYAEYAA
                                buildFoodList(),
                              ],
                            ),
                          ),
                  ],
                ),
                searchFood(),
              ],
            )));
  }

  Widget buildFoodList() {
    print("what");

    return Expanded(
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          stream: foodCollection.where('User', isEqualTo: uid).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Failed to load data!");
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return ActivityServices.loadings();
            }
            return new ListView(
              padding: EdgeInsets.zero,
              children: snapshot.data.docs.map((DocumentSnapshot doc) {
                Food foods;
                //cara 1
                // if (doc.data()['addBy'] == FirebaseAuth.instance.currentUser.uid) {
                foods = new Food(
                  doc.data()['foodId'],
                  doc.data()['Title'],
                  doc.data()['Image'],
                  doc.data()['Carbs'],
                  doc.data()['CarbsUnit'],
                  doc.data()['calories'],
                  doc.data()['CaloriesUnit'],
                  doc.data()['Fat'],
                  doc.data()['FatUnit'],
                  doc.data()['protein'],
                  doc.data()['proteinUnit'],
                );
                // }
                return DietCard(food: foods, date: doc.data()['timeAdded']);
              }).toList(),
            );
          },
        ),
      ),
    );
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

  Widget searchFood() {
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
      clearQueryOnClose: true,
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
            child: Expanded(child: null
                // SizedBox(
                //   height:
                //       searchName != "" ? MediaQuery.of(context).size.height : 0,
                //   child: FutureBuilder<List<Food>>(
                //     future: SpoonServices.searchFood(searchName),
                //     builder: (context, snapshot) {
                //       if (snapshot.hasData) {
                //         List<Food> foods = snapshot.data;
                //         return _foodListView(foods);
                //       } else if (snapshot.hasError) {
                //         return Text("${snapshot.error}");
                //       }
                //       return Text("Loading...");
                //     },
                //   ),
                // ),
                ),
          ),
        );
      },
    );
  }
}
