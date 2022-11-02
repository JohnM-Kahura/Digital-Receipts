import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:receipts/screens/sign_up.dart';
import 'package:receipts/screens/receipts.dart';
import 'package:receipts/widgets/c_textfeild.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Future _signInWithEmailAndPassword() async {
    final User? user = (await _auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    ))
        .user;
        if(user!=null){
          return true;
        }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey,

      appBar: AppBar(
        elevation: 0,
        title: const Center(child: Text('Login')),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment:CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: customTextFeild(50, MediaQuery.of(context).size.width-100, 'Email', emailController,
                  TextInputType.emailAddress, false),
            ),
            const SizedBox(
              height: 10,
            ),
            customTextFeild(50, MediaQuery.of(context).size.width-100, 'Password', passwordController,
                TextInputType.visiblePassword, true),
            const SizedBox(
              height: 20,
            ),
            TextButton(
               style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                onPressed: ()  {
                   _signInWithEmailAndPassword();
                  if(emailController.text.isEmpty||passwordController.text.isEmpty){
                   
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) 
                    => const Auth()
                  ));
                  }
                  else{

                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) 
                    => const Home()
                  ));
                  }
                },
                child: const Text('Login',style:TextStyle(color:Colors.black))),
           
            TextButton(
               style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.yellow)),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (BuildContext context) => const Register()));
                },
                child: const Text('create account',style:TextStyle(color:Colors.black)))
          ],
        ),
      ),
    );
  }
}
