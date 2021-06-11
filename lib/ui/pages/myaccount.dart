part of 'pages.dart';

class MyAccount extends StatefulWidget {
  @override
  _MyAccountState createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  bool isLoading = false;
  String uid = FirebaseAuth.instance.currentUser.uid;
  CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 20),
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

                    return Column(
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(Glovar.guestPic),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          (users.name != null) ? users.name : "Loading...",
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: GoogleFonts.righteous().fontFamily,
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          (users.email != null) ? users.email : "Loading...",
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: GoogleFonts.righteous().fontFamily,
                            fontSize: 25,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await AuthServices.signOut().then((value) {
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
                              primary: Colors.green[800], elevation: 2),
                        ),
                      ],
                    );
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
