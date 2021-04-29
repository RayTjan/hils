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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        centerTitle: true,
        elevation: 0,
      ),
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
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
                      Image.asset(
                        "assets/images/parrot.jpg",
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
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            //Continue to the next stage
                            Navigator.pushReplacementNamed(
                                context,
                                MainMenu
                                    .routeName); //you can't return to login page
                            // Navigator.pushNamed(
                            //     context, MainMenu.routeName); //you can return to login page , THERE IS back button
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
                          primary: Colors.deepPurple[400],
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
                              color: Colors.deepPurple[400],
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
