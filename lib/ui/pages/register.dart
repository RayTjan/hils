part of 'pages.dart';

class Register extends StatefulWidget {
  static const String routeName = "/register";
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>(); //underscore demands it to be used
  final ctrlName = TextEditingController();
  final ctrlPhone = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPass = TextEditingController();
  bool passInvisible = true;
  bool isLoading = false;
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

  void showFileDialog(BuildContext ctx) {
    showDialog(
        context: ctx,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Confirmation"),
            content: Text("Pick image from:"),
            actions: [
              ElevatedButton.icon(
                onPressed: () {
                  chooseFile("camera");
                },
                icon: Icon(Icons.camera_alt),
                label: Text("Camera"),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  chooseFile("gallery");
                },
                icon: Icon(Icons.photo_album_rounded),
                label: Text("Gallery"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            ListView(
              padding: EdgeInsets.all(10),
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff70b84d)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      imageFile == null
                          ? Column(
                              children: [
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    // chooseFile();
                                    showFileDialog(context);
                                  },
                                  label: Text("Ambil Foto"),
                                  icon: Icon(Icons.photo_album),
                                ),
                                SizedBox(
                                  width: 16,
                                ),
                                Text(
                                  "File tidak ditemukan",
                                  style: TextStyle(color: Colors.red),
                                )
                              ],
                            )
                          : Column(
                              children: [
                                Semantics(
                                    child: Image.file(
                                  File(imageFile.path),
                                  width: 100,
                                )),
                                SizedBox(
                                  width: 16,
                                ),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    // chooseFile();
                                    showFileDialog(context);
                                  },
                                  label: Text("Ambil Foto"),
                                  icon: Icon(Icons.photo_album),
                                ),
                              ],
                            ),
                      SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        controller: ctrlName,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isNotEmpty) {
                            return null;
                          } else {
                            return "Please fill the field";
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: ctrlEmail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.mail_outline_rounded),
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isNotEmpty) {
                            if (EmailValidator.validate(value)) {
                              return null;
                            } else {
                              return "Please give a valid email";
                            }
                          } else {
                            return "Please fill the field";
                          }
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: ctrlPass,
                        obscureText: passInvisible,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.vpn_key),
                            border: OutlineInputBorder(),
                            suffixIcon: new GestureDetector(
                              child: Icon(passInvisible
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onTap: () {
                                setState(() {
                                  passInvisible = !passInvisible;
                                });
                              },
                            )),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return value.length < 6
                              ? "Passsword requires at least 6 characters"
                              : null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            Users user = new Users(
                                "",
                                ctrlName.text,
                                ctrlEmail.text,
                                ctrlPass.text,
                                Glovar.guestPic,
                                "",
                                "",
                                "");
                            await AuthServices.signUp(user, imageFile)
                                .then((value) {
                              if (value == "Success") {
                                setState(() {
                                  isLoading = false;
                                });
                                ActivityServices.showToast(
                                    "Register success", Colors.green);
                                Navigator.pushReplacementNamed(
                                    context, Login.routeName);
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                ActivityServices.showToast(value, Colors.red);
                              }
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please fill all the fields correctly!",
                                backgroundColor: Colors.red,
                                textColor: Colors.white);
                          }
                        },
                        icon: Icon(Icons.save),
                        label: Text("Register"),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[800],
                          elevation: 5,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, Login.routeName);
                        },
                        child: Text("Have an account already? Login now.",
                            style: TextStyle(
                              color: Colors.green[400],
                              fontSize: 16,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
            isLoading == true ? ActivityServices.loadings() : Container()
          ],
        ),
      ),
    );
  }
}
