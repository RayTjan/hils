part of 'pages.dart';

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final ctrlName = TextEditingController();
  final ctrlDesc = TextEditingController();
  final ctrlPrice = TextEditingController();
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

  void dispose() {
    ctrlName.dispose();
    ctrlDesc.dispose();
    ctrlPrice.dispose();

    super.dispose();
  }

  void clearForm() {
    ctrlName.clear();
    ctrlDesc.clear();
    ctrlPrice.clear();

    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            ListView(
              padding: EdgeInsets.all(16),
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 40),
                      TextFormField(
                        controller: ctrlName,
                        decoration: InputDecoration(
                          labelText: "Product Name",
                          prefixIcon: Icon(Icons.label),
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please fill the field!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: ctrlDesc,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: "Product Description",
                          prefixIcon: Icon(Icons.description),
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please fill the field!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: ctrlPrice,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: "Product Price",
                          prefixIcon: Icon(Icons.price_check),
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Please fill the field!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 24),
                      imageFile == null
                          ? Row(
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
                          : Row(
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
                                Semantics(
                                    child: Image.file(
                                  File(imageFile.path),
                                  width: 100,
                                ))
                              ],
                            ),
                      SizedBox(
                        height: 40,
                      ),
                      ElevatedButton.icon(
                        onPressed: () async {
                          if (_formKey.currentState.validate() &&
                              imageFile != null) {
                            setState(() {
                              isLoading = true;
                            });
                            Products products = Products(
                                "",
                                ctrlName.text,
                                ctrlDesc.text,
                                ctrlPrice.text,
                                "",
                                FirebaseAuth.instance.currentUser.uid,
                                "",
                                "");
                            await ProductServices.addProduct(
                                    products, imageFile)
                                .then((value) {
                              if (value == true) {
                                ActivityServices.showToast(
                                    "Add product Successfuly", Colors.green);
                                clearForm();
                                setState(() {
                                  isLoading = false;
                                });
                              } else {
                                ActivityServices.showToast(
                                    "Error adding product", Colors.red);
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            });
                          } else {
                            ActivityServices.showToast(
                                "Please check the fields", Colors.red);
                          }
                        },
                        icon: Icon(Icons.card_travel),
                        label: Text("Save Product"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.deepOrange[400], elevation: 0),
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
