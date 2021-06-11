part of 'pages.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool isLoading = false;
  List sum = [0, 0, 0, 0];

  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  void updateSummary() {
    setState(() {
      DietServices.getSummary().then((value) => {sum = value});
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      updateSummary();
    });
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: StreamBuilder<QuerySnapshot>(
              stream: userCollection.where('uid', isEqualTo: uid).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return ActivityServices.loadings();
                }
                DietServices.getSummary();
                return new ListView(
                  children: snapshot.data.docs.map((DocumentSnapshot doc) {
                    Users users;
                    users = new Users(
                      doc.data()['uid'],
                      doc.data()['name'],
                      doc.data()['email'],
                      doc.data()['password'],
                      doc.data()['pic'],
                      doc.data()['description'],
                      doc.data()['createdAt'],
                      doc.data()['updatedAt'],
                    );

                    return Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Padding(
                              padding: EdgeInsets.all(0),
                              child: Text(
                                "PROFILE",
                                style: TextStyle(
                                    fontSize: 40,
                                    fontWeight: FontWeight.normal,
                                    color: Color(0xff70b84d)),
                              ),
                            ),
                            SizedBox(height: 30),
                            Container(
                              width: double.infinity,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 200,
                                      height: 200,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                            image: users.imagePath ==
                                                    "assets/images/defaultUser.jpg"
                                                ? NetworkImage(users.imagePath)
                                                : AssetImage(Glovar.guestPic),
                                            fit: BoxFit.fill),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      (users.name != null)
                                          ? users.name
                                          : "Loading...",
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily:
                                            GoogleFonts.righteous().fontFamily,
                                        fontSize: 25,
                                      ),
                                    ),
                                    Text(
                                      (users.email != null)
                                          ? users.email
                                          : "Loading...",
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily:
                                            GoogleFonts.righteous().fontFamily,
                                        fontSize: 15,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Color(0xffD7F9DB),
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            // Padding(
                                            //   padding:
                                            //       EdgeInsets.only(left: 20),
                                            //   child: Text(
                                            //     "Summary",
                                            //     style: TextStyle(
                                            //         fontSize: 20,
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.green[800]),
                                            //   ),
                                            // ),
                                            // SizedBox(
                                            //   height: 5,
                                            // ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  child: Text(
                                                    "Carbs\n " +
                                                        sum[0].toString() +
                                                        "mg",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            Colors.green[800]),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    "Calorie\n " +
                                                        sum[1].toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            Colors.green[800]),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    "Fat\n " +
                                                        sum[2].toString() +
                                                        "kcal",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            Colors.green[800]),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    "Protein\n " +
                                                        sum[3].toString() +
                                                        "g",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color:
                                                            Colors.green[800]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        setState(() {
                                          isLoading = true;
                                        });
                                        await AuthServices.signOut()
                                            .then((value) {
                                          if (value == true) {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            ActivityServices.showToast(
                                                "Logout Success", Colors.green);
                                            Navigator.pushReplacementNamed(
                                                context, Login.routeName);
                                          } else {
                                            setState(() {
                                              isLoading = false;
                                            });
                                            ActivityServices.showToast(
                                                "Logout Failed", Colors.red);
                                          }
                                        });
                                      },
                                      icon: Icon(Icons.login_rounded),
                                      label: Text("Logout"),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green[800],
                                          elevation: 2),
                                    ),
                                  ]),
                            ),
                          ],
                        ));
                  }).toList(),
                );
              },
            ),
          ),
          isLoading == true ? ActivityServices.loadings() : Container()
        ],
      ),
    );
  }
}
