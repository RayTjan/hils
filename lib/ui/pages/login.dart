part of 'pages.dart';

class Login extends StatefulWidget {
  static const String routeName = "/login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>(); //underscore demands it to be used
  final ctrlEmail = TextEditingController();
  final ctrlPass = TextEditingController();
  bool passInvisible = true;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        height: double.infinity,
        padding: EdgeInsets.all(10),
        child: Stack(
          children: [
            ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "LOGIN",
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.normal,
                            color: Color(0xff70b84d)),
                      ),
                      Image.asset(
                        "assets/images/loogWhite.png",
                        height: 275,
                      ),
                      SizedBox(
                        height: 24,
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
                              return "Please a valid email";
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
                            await AuthServices.signIn(
                                    ctrlEmail.text, ctrlPass.text)
                                .then((value) {
                              if (value == "Success") {
                                setState(() {
                                  isLoading = false;
                                });
                                ActivityServices.showToast(
                                    "Login success", Colors.greenAccent);
                                Navigator.pushReplacementNamed(
                                    context, MainMenu.routeName);
                              } else {
                                setState(() {
                                  isLoading = false;
                                });
                                ActivityServices.showToast(
                                    value, Colors.redAccent);
                              }
                            });
                          } else {
                            Fluttertoast.showToast(
                                msg: "Please fill all the fields correctly!",
                                backgroundColor: Colors.red,
                                textColor: Colors.white);
                          }
                        },
                        icon: Icon(Icons.login_rounded),
                        label: Text("Login"),
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
                              context, Register.routeName);
                        },
                        child: Text("Not registered yet? Join now.",
                            style: TextStyle(
                              color: Colors.green[600],
                              fontSize: 16,
                            )),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
