import 'package:firebase_auth/firebase_auth.dart';
import 'package:flower_app/pages/register.dart';
import 'package:flower_app/pages/resetpassword.dart';
import 'package:flower_app/provider/google_signin.dart';
import 'package:flower_app/shared/colors.dart';
import 'package:flower_app/shared/contants.dart';
import 'package:flower_app/shared/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool isVisable = false;

  siginIn() async {
    setState(() {
      isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      // showSnackBar(context, "done ....");
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "Eerror ....: ${e.code}");
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 247, 247, 247),
            appBar: AppBar(
              backgroundColor: appbarGreen,
              title: const Text(
                "Sign in",
                style: TextStyle(fontSize: 25),
              ),
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(33.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 64,
                        ),
                        TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            obscureText: false,
                            decoration: decorationTextfield.copyWith(
                              hintText: "Enter Your Email : ",
                              suffixIcon: const Icon(Icons.email),
                            )),
                        const SizedBox(
                          height: 33,
                        ),
                        TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            obscureText: isVisable ? true : false,
                            decoration: decorationTextfield.copyWith(
                                hintText: "Enter Your Password : ",
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        isVisable = !isVisable;
                                      });
                                    },
                                    icon: isVisable
                                        ? const Icon(Icons.visibility)
                                        : const Icon(Icons.visibility_off)))),
                        const SizedBox(
                          height: 33,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await siginIn();
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(bTNpink),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.all(12)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                          ),
                          child:
                              // isLoading
                              //     ? CircularProgressIndicator(
                              //         color: Colors.white,
                              //       ):
                              const Text(
                            "Sign in",
                            style: TextStyle(fontSize: 19),
                          ),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ResetPassword()),
                              );
                            },
                            child: const Text(
                              "Reset Password",
                              style: TextStyle(
                                  fontSize: 18,
                                  decoration: TextDecoration.underline),
                            )),
                        const SizedBox(
                          height: 23,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Do not have an account?",
                                style: TextStyle(fontSize: 18)),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const Register()),
                                  );
                                },
                                child: const Text('sign up',
                                    style: TextStyle(
                                        fontSize: 18,
                                        decoration: TextDecoration.underline))),
                          ],
                        ),
                        const SizedBox(
                          height: 17,
                        ),
                        SizedBox(
                          width: 299,
                          child: Row(
                            children: [
                              Expanded(
                                  child: Divider(
                                thickness: 0.6,
                                color: Colors.purple[900],
                              )),
                              Text(
                                "OR",
                                style: TextStyle(
                                  color: Colors.purple[900],
                                ),
                              ),
                              Expanded(
                                  child: Divider(
                                thickness: 0.6,
                                color: Colors.purple[900],
                              )),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 27),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  googleSignInProvider.googlelogin();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(13),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          // color: Colors.purple,
                                          width: 1)),
                                  child: SvgPicture.asset(
                                    "assets/icons/google.svg",
                                    // color: Colors.purple[400],
                                    height: 27,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            )));
  }
}
