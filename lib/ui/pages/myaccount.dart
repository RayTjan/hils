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
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.green[800],
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
      ),
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

class ProfilePic extends StatefulWidget {
  const ProfilePic({
    Key key,
    this.img,
    this.name,
  }) : super(key: key);

  final String img;
  final String name;

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  PickedFile imageFile;
  final ImagePicker imagePicker = ImagePicker();

  Future chooseFile(String type) async {
    ImageSource imgSrc;
    if (type == "camera") {
      imgSrc = ImageSource.camera;
    } else {
      imgSrc = ImageSource.gallery;
    }

    final selectedImage = await imagePicker.getImage(
      source: imgSrc,
      imageQuality: 50,
    );
    setState(() {
      imageFile = selectedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          width: 150,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircleAvatar(
                backgroundImage: widget.img == "assets/images/defaultUser.png"
                    ? AssetImage(widget.img)
                    : NetworkImage(widget.img),
              ),
            ],
          ),
        ),
        Text(
          widget.name,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
        )
      ],
    );
  }
}
