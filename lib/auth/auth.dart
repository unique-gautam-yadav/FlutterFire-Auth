import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> signIn() async {
    try {
      if (formKey.currentState!.validate()) {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
        content: const Text(
          "Login Failed",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text("OK"))
        ],
        leading: const Icon(Icons.error_rounded, color: Colors.white),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 65),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const FlutterLogo(size: 200),
                const Text(
                  "Login Page",
                  style: TextStyle(fontSize: 45),
                ),
                const SizedBox(height: 50),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a your mail";
                    } else {
                      return null;
                    }
                  },
                  controller: _emailController,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 15, top: 2, bottom: 2),
                      label: const Text("Email"),
                      hintText: "Enter Your Mail Address",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Pease enter a password";
                    } else if (value.length < 8) {
                      return "Password must have 8 char";
                    } else {
                      return null;
                    }
                  },
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 15, top: 2, bottom: 2),
                      hintText: "Enter Your Password",
                      label: const Text("Password"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                    onPressed: () {
                      signIn();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(
                                left: 65, right: 65, top: 10, bottom: 10)),
                        shape:
                            MaterialStateProperty.all(const StadiumBorder())),
                    child: const Text("Login",
                        style: TextStyle(color: Colors.white))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("If you dont have an account,"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ));
                        },
                        child: const Text(
                          "register",
                        )),
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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePassword = TextEditingController();

  Future<void> signUp() async {
    try {
      if (formKey.currentState!.validate()) {
        if (_rePassword.text != _passwordController.text) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Password didn't match to Re Password")));
        } else {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Registration Done")));
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showMaterialBanner(MaterialBanner(
        content: const Text(
          "Sign Up faild!!",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          TextButton(
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              },
              child: const Text("OK"))
        ],
        leading: const Icon(Icons.error_rounded, color: Colors.white),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10, top: 65),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const FlutterLogo(size: 200),
                const Text("Registration Page", style: TextStyle(fontSize: 45)),
                const SizedBox(height: 50),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter a your mail";
                    } else {
                      return null;
                    }
                  },
                  controller: _emailController,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 15, top: 2, bottom: 2),
                      label: const Text("Email"),
                      hintText: "Enter Your Mail Address",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Pease enter a password";
                    } else {
                      return null;
                    }
                  },
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 15, top: 2, bottom: 2),
                      hintText: "Enter Your Password",
                      label: const Text("Password"),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _rePassword,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.only(left: 15, top: 2, bottom: 2),
                      label: const Text("Re Password"),
                      hintText: "Retype your password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                    onPressed: () {
                      signUp();
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(
                                left: 65, right: 65, top: 10, bottom: 10)),
                        shape:
                            MaterialStateProperty.all(const StadiumBorder())),
                    child: const Text("Register",
                        style: TextStyle(color: Colors.white))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account,"),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "login",
                        )),
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
