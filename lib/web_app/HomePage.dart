import './DashBoard.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  String pass = 'admin1234';
  String emails = 'admin@gmail.com';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            height: size.height,
            width: size.width * 0.7,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/Travel-BUS-LED.jpg',
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Center(
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 50.0, left: 100, top: 20, bottom: 20),
                    child: Container(
                      width: 300,
                      child: TextFormField(
                        enableSuggestions: true,
                        textCapitalization: TextCapitalization.sentences,
                        controller: email,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          // filled: true,
                          // contentPadding: EdgeInsets.all(16),
                          // fillColor: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 50.0, left: 100, top: 20, bottom: 30),
                    child: Container(
                      width: 300,
                      child: TextFormField(
                        enableSuggestions: true,
                        textCapitalization: TextCapitalization.sentences,
                        controller: password,
                        textAlign: TextAlign.center,
                        obscureText: true,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 1,
                              style: BorderStyle.solid,
                            ),
                          ),
                          // filled: true,
                          // contentPadding: EdgeInsets.all(16),
                          // fillColor: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (emails == email.text || pass == password.text) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashBoard()));
                      } else {
                        SnackBar(
                            content: Text("Provide correct email&Password"));
                      }
                    },
                    child: Container(
                      width: 250,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xff4465dc),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        color: Color(0xff4465dc),
                      ),
                      child: Center(
                          child: Text(
                        'Sign in',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
