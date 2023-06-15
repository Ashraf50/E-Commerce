import 'package:e_commerce/reset_password.dart';
import 'package:e_commerce/widget/constant/snackBar.dart';
import 'package:e_commerce/widget/home.dart';
import 'package:e_commerce/widget/provider/google_signIn.dart';
import 'package:e_commerce/widget/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'constant/MyTextfield.dart';
import 'constant/colors.dart';

class SignIn extends StatefulWidget {
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final email_controller = TextEditingController();
  final password_controller = TextEditingController();
  bool ISpassword_on_off = true;

  Sign() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: SpinKitFadingCircle(
            color: Color.fromARGB(146, 12, 16, 49),
            size: 160.0,
          ),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email_controller.text,
        password: password_controller.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
      showSnackBar(context, "successful");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, "incorrect Email");
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, "incorrect password");
      } else {
        showSnackBar(context, "Error");
      }
    }
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    email_controller.dispose();
    password_controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final google_sign_in = Provider.of<GoogleSignInProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppBarColor,
        centerTitle: true,
        title: Text("Sign In"),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyTextfield(
                  control: email_controller,
                  keyboardType: TextInputType.emailAddress,
                  hintText: "Enter Your Email",
                  obscureText: false,
                  suffixIcon: Icon(
                    Icons.email,
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    controller: password_controller,
                    obscureText: ISpassword_on_off,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      hintText: "Enter Your Password",
                      suffixIcon: IconButton(
                        icon: ISpassword_on_off
                            ? (Icon(
                                Icons.visibility,
                              ))
                            : (Icon(
                                Icons.visibility_off,
                              )),
                        onPressed: () {
                          setState(() {
                            if (ISpassword_on_off == true) {
                              ISpassword_on_off = false;
                            } else {
                              ISpassword_on_off = true;
                            }
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await Sign();
                  },
                  child: Text(
                    "Sign In",
                    style: TextStyle(fontSize: 25),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(textfield_color),
                    shape: MaterialStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Reset_Password(),
                      ),
                    );
                  },
                  child: Text(
                    "Forget Password?",
                    style: TextStyle(
                      fontSize: 18,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Do not have an account?",
                      style: TextStyle(fontSize: 17),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ),
                        );
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 330,
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.6,
                          color: Colors.purple[900],
                        ),
                      ),
                      Text(
                        "Sign in with",
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: "my_font",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.6,
                          color: Colors.purple[900],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        "assets/img/facebook-app-symbol.png",
                        width: 30,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        google_sign_in.googleLogin();
                      },
                      child: Image.asset(
                        "assets/img/google.png",
                        width: 30,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
