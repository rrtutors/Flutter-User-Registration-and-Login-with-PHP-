import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rest_app/apis/api.dart';
import 'package:rest_app/screens/signup.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  String email, password;
  bool isLoading=false;
  TextEditingController _emailController=new TextEditingController();
  TextEditingController _passwordController=new TextEditingController();
  GlobalKey<ScaffoldState>_scaffoldKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        body: SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                "assets/background.jpg",
                fit: BoxFit.fill,
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                      child: Image.asset(
                    "assets/logo.png",
                    height: 30,
                    width: 30,
                    alignment: Alignment.center,
                  )),
                  SizedBox(
                    height: 13,
                  ),
                  Text(
                    "Learn With Us",
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            fontSize: 27,
                            color: Colors.white,
                            letterSpacing: 1)),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: 180,
                    child: Text(
                      "RRTutors, Hyderabad",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                            color: Colors.white54,
                            letterSpacing: 0.6,
                            fontSize: 11),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Sign In",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Learn new Technologies 😋",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                            color: Colors.white70,
                            letterSpacing: 1,
                            fontSize: 17,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            controller: _emailController,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              hintText: "Email",
                              hintStyle: TextStyle(
                                  color: Colors.white70, fontSize: 15),
                            ),
                            onSaved: (val) {
                              email = val;
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            controller: _passwordController,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  color: Colors.white70, fontSize: 15),
                            ),
                            onSaved: (val) {
                              email = val;
                            },
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Stack(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if(isLoading)
                                    {
                                      return;
                                    }
                                  if(_emailController.text.isEmpty||_passwordController.text.isEmpty)
                                  {
                                    _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please Fill all fileds")));
                                    return;
                                  }
                                  login(_emailController.text,_passwordController.text);
                                  setState(() {
                                    isLoading=true;
                                  });
                                  //Navigator.pushReplacementNamed(context, "/home");
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 0),
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    "SUBMIT",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            letterSpacing: 1)),
                                  ),
                                ),
                              ),
                              Positioned(child: (isLoading)?Center(child: Container(height:26,width: 26,child: CircularProgressIndicator(backgroundColor: Colors.green,))):Container(),right: 30,bottom: 0,top: 0,)

                            ],
                          )

                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "OR",
                    style: TextStyle(fontSize: 14, color: Colors.white60),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/fingerprint.png",
                    height: 36,
                    width: 36,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/signup");
                    },
                    child: Text(
                      "Don't have an account?",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                              letterSpacing: 0.5)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  login(email,password) async
  {



    Map data = {
      'email': email,
      'password': password
    };
    print(data.toString());
    final  response= await http.post(
        LOGIN,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },


        body: data,
        encoding: Encoding.getByName("utf-8")
    )  ;
    setState(() {
      isLoading=false;
    });
    if (response.statusCode == 200) {
      Map<String,dynamic>resposne=jsonDecode(response.body);
      if(!resposne['error'])
      {
        Map<String,dynamic>user=resposne['data'];
        print(" User name ${user['id']}");
        savePref(1,user['name'],user['email'],user['id']);
        Navigator.pushReplacementNamed(context, "/home");
      }else{
        print(" ${resposne['message']}");
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("${resposne['message']}")));

    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content:Text("Please try again!")));
    }


  }
  savePref(int value, String name, String email, int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

      preferences.setInt("value", value);
      preferences.setString("name", name);
      preferences.setString("email", email);
      preferences.setString("id", id.toString());
      preferences.commit();

  }
}
